<?php

namespace App\Http\Controllers\API\Emprendedores;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Concerns\HandlesImages; // Importar el trait
use App\Http\Requests\EmprendedorRequest;
use App\Models\User;
use App\Models\Emprendedor;
use App\Models\Reserva;
use App\Services\EmprendedoresService;
use Illuminate\Http\Response;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage; // Necesario para el método destroy

class EmprendedorController extends Controller
{
    use HandlesImages; // Usar el trait para gestión de imágenes

    protected $emprendedorService;

    public function __construct(EmprendedoresService $emprendedorService)
    {
        $this->emprendedorService = $emprendedorService;
    }

    /**
     * Mostrar todos los emprendedores
     */
    public function index(Request $request): JsonResponse
    {
        $perPage = $request->query('per_page', 15);
        $emprendedores = $this->emprendedorService->getAll($perPage);

        // Cargar sliders para cada emprendedor
        foreach ($emprendedores as $emprendedor) {
            $emprendedor->load(['slidersPrincipales', 'slidersSecundarios']);
        }

        return response()->json([
            'success' => true,
            'data' => $emprendedores
        ]);
    }

    /**
     * Almacenar un nuevo emprendedor
     */
    public function store(EmprendedorRequest $request): JsonResponse
    {
        try{
            $data = $request->validated();

            // Separar datos de archivos para la creación inicial
            $dataSinArchivos = collect($data)->except(['imagen', 'imagenes', 'sliders_principales', 'sliders_secundarios', 'usuario_id'])->all();

            // Crear el emprendedor usando el servicio
            $emprendedor = $this->emprendedorService->create($dataSinArchivos);

            // ✅ CORREGIDO: Asignar usuario al emprendimiento si se proporciona
            $usuarioAsignado = false;
            if ($request->has('usuario_id') && $request->usuario_id) {
                $usuario = \App\Models\User::find($request->usuario_id);
                if ($usuario) {
                    // Verificar que el usuario tenga rol emprendedor
                    if ($usuario->hasRole('emprendedor')) {
                        $usuario->emprendimientos()->attach($emprendedor->id, [
                            'es_principal' => true,
                            'rol' => 'administrador'
                        ]);
                        $usuarioAsignado = true;
                        Log::info('✅ Usuario emprendedor asignado en creación', [
                            'usuario_id' => $request->usuario_id,
                            'emprendedor_id' => $emprendedor->id
                        ]);
                    } else {
                        Log::warning('⚠️ Usuario no tiene rol emprendedor', ['usuario_id' => $request->usuario_id]);
                    }
                } else {
                    Log::warning('⚠️ Usuario no encontrado', ['usuario_id' => $request->usuario_id]);
                }
            }

            // === Lógica de Gestión de Imágenes (Añadida) ===
            $datosActualizacion = [];
            $imagenes = [];

            // Imagen principal (single) - agregar como primera imagen
            if ($request->hasFile('imagen')) {
                try {
                    $imagenes[] = $this->storeImage($request->file('imagen'), "emprendedores/{$emprendedor->id}");
                } catch (\Exception $e) {
                    Log::error('❌ Error guardando imagen principal en store', ['error' => $e->getMessage()]);
                }
            }

            // Galería (múltiples imágenes)
            if ($request->hasFile('imagenes')) {
                foreach ($request->file('imagenes') as $file) {
                    try {
                        $imagenes[] = $this->storeImage($file, "emprendedores/{$emprendedor->id}");
                    } catch (\Exception $e) {
                        Log::error('❌ Error guardando imagen secundaria en store', ['error' => $e->getMessage()]);
                    }
                }
            }
            
            if (!empty($imagenes)) {
                $datosActualizacion['imagenes'] = $imagenes;
            }

            // Procesar sliders principales
            $slidersPrincipales = [];
            if ($request->hasFile('sliders_principales')) {
                foreach ($request->file('sliders_principales') as $index => $file) {
                    $slidersPrincipales[] = [
                        'url' => $this->storeImage($file, "emprendedores/{$emprendedor->id}/sliders"),
                        'nombre' => 'Imagen principal ' . ($index + 1),
                        'es_principal' => true,
                        'orden' => $index + 1
                    ];
                }
            }

            // Procesar sliders secundarios
            $slidersSecundarios = [];
            if ($request->hasFile('sliders_secundarios')) {
                foreach ($request->file('sliders_secundarios') as $index => $file) {
                    $slidersSecundarios[] = [
                        'url' => $this->storeImage($file, "emprendedores/{$emprendedor->id}/sliders"),
                        'nombre' => 'Imagen secundaria ' . ($index + 1),
                        'es_principal' => false,
                        'orden' => $index + 1
                    ];
                }
            }

            // Actualizar el emprendedor con las rutas de las imágenes si existen
            if (!empty($datosActualizacion)) {
                $emprendedor->update($datosActualizacion);
            }

            // Procesar sliders usando el servicio
            if (!empty($slidersPrincipales)) {
                $this->emprendedorService->procesarSliders($emprendedor->id, $slidersPrincipales, true);
            }
            if (!empty($slidersSecundarios)) {
                $this->emprendedorService->procesarSliders($emprendedor->id, $slidersSecundarios, false);
            }
            // ===============================================

            // ✅ CORREGIDO: Solo asignar usuario autenticado si no se asignó ningún usuario específico
            if (!$usuarioAsignado && Auth::check()) {
                $user = Auth::user();
                // Verificar que el usuario autenticado tenga rol emprendedor
                if ($user->hasRole('emprendedor')) {
                    $user->emprendimientos()->attach($emprendedor->id, [
                        'es_principal' => true,
                        'rol' => 'administrador'
                    ]);
                    Log::info('✅ Usuario autenticado asignado como administrador principal', [
                        'usuario_id' => $user->id,
                        'emprendedor_id' => $emprendedor->id
                    ]);
                } else {
                    Log::warning('⚠️ Usuario autenticado no tiene rol emprendedor', ['usuario_id' => $user->id]);
                }
            }

            return response()->json([
                'success' => true,
                'message' => 'Emprendedor creado exitosamente',
                'data' => $emprendedor->fresh() // Retornar la versión fresca con rutas de imágenes
            ], Response::HTTP_CREATED);
        }catch(\Exception $e){
            Log::error('Error al crear emprendedor: ' . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function show($id): JsonResponse
    {
        // Convertir explícitamente a entero
        $id = (int) $id;

        $emprendedor = $this->emprendedorService->getById($id);

        if (!$emprendedor) {
            return response()->json([
                'success' => false,
                'message' => 'Emprendedor no encontrado'
            ], 404);
        }

        // Cargar relaciones
        $emprendedor->load([
            'slidersPrincipales',
            'slidersSecundarios',
            'servicios.horarios',
            'servicios.sliders',
            'asociacion',
            'administradores' // Cargar los administradores
        ]);

        return response()->json([
            'success' => true,
            'data' => $emprendedor

        ]);
    }

    /**
     * Actualizar un emprendedor
     */
    public function update(EmprendedorRequest $request, $id): JsonResponse
    {
        try {
        // ✅ LOGGING COMPLETO AL INICIO
        Log::info('🚀 UPDATE METHOD CALLED', [
            'id' => $id,
            'method' => $request->method(),
            'has_files' => $request->hasFile('imagen'),
            'all_files' => array_keys($request->allFiles()),
            'user_id' => auth()->id(),
            'user_name' => auth()->user()?->name
        ]);
        
        Log::info('UPDATE START');
        Log::info('ID: ' . $id);
        Log::info('USER: ' . Auth::id());
        Log::info('DATA COUNT: ' . count($request->all()));
        Log::info('VALIDATED DATA COUNT: ' . count($request->validated()));
        
        // ✅ DEBUG: Mostrar algunos campos específicos
        $validatedData = $request->validated();
        Log::info('OPCIONES_ACCESO: ' . ($validatedData['opciones_acceso'] ?? 'NOT_FOUND'));
        Log::info('CERTIFICACIONES: ' . ($validatedData['certificaciones'] ?? 'NOT_FOUND'));
        Log::info('IMAGENES COUNT: ' . count($request->allFiles()));
        
        // ✅ DEBUG: Mostrar datos raw del request
        Log::info('RAW REQUEST DATA: ' . json_encode($request->all()));
        Log::info('RAW FILES: ' . json_encode(array_keys($request->allFiles())));
        Log::info('CONTENT TYPE: ' . $request->header('Content-Type'));
        Log::info('REQUEST METHOD: ' . $request->method());

            // Convertir ID a entero
            $id = (int) $id;

            // Los datos ya están validados por el Request
            $datos = $request->validated();
            Log::info('📋 Datos recibidos del request', [
            'all_data' => $request->all(),
            'files' => $request->allFiles(),
            'form_data' => $request->except(['imagen', 'imagenes']),
            'opciones_acceso_raw' => $request->input('opciones_acceso'),
            'opciones_acceso_validated' => $datos['opciones_acceso'] ?? 'NOT_FOUND'
        ]);

            // Cargar el modelo para la lógica de permisos y archivos
            $emprendedor = $this->emprendedorService->getById($id);
            Log::info('📋 Emprendedor encontrado', ['emprendedor' => $emprendedor ? $emprendedor->toArray() : 'No encontrado']);

            if (!$emprendedor) {
                Log::warning('❌ Emprendedor no encontrado', ['id' => $id]);
                return response()->json([
                    'success' => false,
                    'message' => 'Emprendedor no encontrado'
                ], Response::HTTP_NOT_FOUND);
            }

            // Verificar si el usuario tiene permisos para actualizar este emprendedor
            if (Auth::check() && !Auth::user()->hasPermissionTo('emprendedor_update')) {
                $user = Auth::user();
                $esAdministrador = $user->emprendimientos()
                    ->where('emprendedores.id', $id)
                    ->exists();

                if (!$esAdministrador) {
                    Log::warning('❌ Usuario sin permisos', ['user_id' => $user->id, 'emprendedor_id' => $id]);
                    return response()->json([
                        'success' => false,
                        'message' => 'No tienes permisos para actualizar este emprendedor'
                    ], Response::HTTP_FORBIDDEN);
                }
            }

            // ✅ SIMPLIFICADO: Solo incluir campos básicos sin procesar imágenes
            $datosActualizacion = [
                'nombre' => $datos['nombre'] ?? $emprendedor->nombre,
                'descripcion' => $datos['descripcion'] ?? $emprendedor->descripcion,
                'opciones_acceso' => $datos['opciones_acceso'] ?? $emprendedor->opciones_acceso,
                'categoria' => $datos['categoria'] ?? $emprendedor->categoria,
                'tipo_servicio' => $datos['tipo_servicio'] ?? $emprendedor->tipo_servicio,
                'ubicacion' => $datos['ubicacion'] ?? $emprendedor->ubicacion,
                'telefono' => $datos['telefono'] ?? $emprendedor->telefono,
                'email' => $datos['email'] ?? $emprendedor->email,
                'pagina_web' => $datos['pagina_web'] ?? $emprendedor->pagina_web,
                'horario_atencion' => $datos['horario_atencion'] ?? $emprendedor->horario_atencion,
                'precio_rango' => $datos['precio_rango'] ?? $emprendedor->precio_rango,
                'capacidad_aforo' => $datos['capacidad_aforo'] ?? $emprendedor->capacidad_aforo,
                'numero_personas_atiende' => $datos['numero_personas_atiende'] ?? $emprendedor->numero_personas_atiende,
                'metodos_pago' => $datos['metodos_pago'] ?? $emprendedor->metodos_pago,
                'idiomas_hablados' => $datos['idiomas_hablados'] ?? $emprendedor->idiomas_hablados,
                'certificaciones' => $datos['certificaciones'] ?? $emprendedor->certificaciones,
                'facilidades_discapacidad' => $datos['facilidades_discapacidad'] ?? $emprendedor->facilidades_discapacidad,
                'estado' => $datos['estado'] ?? $emprendedor->estado,
                'asociacion_id' => $datos['asociacion_id'] ?? $emprendedor->asociacion_id,
            ];
            Log::info('📝 Datos para actualización', [
                'datos_actualizacion' => $datosActualizacion,
                'count_fields' => count($datosActualizacion),
                'keys' => array_keys($datosActualizacion)
            ]);

            // === Lógica de Gestión de Imágenes (SIMPLIFICADA PARA DEBUGGING) ===
            $imagenes = [];

            // ✅ DEBUG: Verificar archivos recibidos
            Log::info('🔍 DEBUGGING ARCHIVOS:', [
                'hasFile_imagen' => $request->hasFile('imagen'),
                'hasFile_imagenes' => $request->hasFile('imagenes'),
                'allFiles_keys' => array_keys($request->allFiles()),
                'allFiles_count' => count($request->allFiles()),
                'files_content' => $request->allFiles()
            ]);

            // ✅ SIMPLIFICADO: Procesar imagen principal
            if ($request->hasFile('imagen')) {
                try {
                    $imagenes[] = $this->storeImage($request->file('imagen'), "emprendedores/{$id}");
                    Log::info('✅ Imagen principal procesada correctamente');
                } catch (\Exception $e) {
                    Log::error('❌ Error guardando imagen principal en update', ['error' => $e->getMessage()]);
                }
            } else {
                Log::warning('⚠️ No se detectó archivo con clave "imagen"');
            }

            // ✅ SIMPLIFICADO: Procesar galería
            if ($request->hasFile('imagenes')) {
                foreach ($request->file('imagenes') as $file) {
                    try {
                        $imagenes[] = $this->storeImage($file, "emprendedores/{$id}");
                        Log::info('✅ Imagen secundaria procesada correctamente');
                    } catch (\Exception $e) {
                        Log::error('❌ Error guardando imagen secundaria en update', ['error' => $e->getMessage()]);
                    }
                }
            } else {
                Log::warning('⚠️ No se detectaron archivos con clave "imagenes"');
            }
            
            // ✅ SIMPLIFICADO: Si hay nuevas imágenes, reemplazar las existentes
            if (!empty($imagenes)) {
                $datosActualizacion['imagenes'] = $imagenes;
                Log::info('📸 Imágenes actualizadas (reemplazadas)', [
                    'nuevas' => count($imagenes),
                    'imagenes' => $imagenes
                ]);
            } else {
                Log::warning('⚠️ No se procesaron nuevas imágenes');
            }

            // ✅ NUEVO: Manejar usuario emprendedor si se proporciona
            if ($request->has('usuario_id') && $request->usuario_id) {
                $usuarioId = $request->usuario_id;
                $usuario = \App\Models\User::find($usuarioId);
                
                if ($usuario) {
                    // Verificar que el usuario tenga rol emprendedor
                    if ($usuario->hasRole('emprendedor')) {
                        // Verificar si ya existe la relación
                        $existeRelacion = $usuario->emprendimientos()->where('emprendedores.id', $id)->exists();
                        
                        if (!$existeRelacion) {
                            // Crear nueva relación
                            $usuario->emprendimientos()->attach($id, [
                                'es_principal' => true,
                                'rol' => 'administrador'
                            ]);
                            Log::info('✅ Usuario emprendedor asignado', [
                                'usuario_id' => $usuarioId,
                                'emprendedor_id' => $id
                            ]);
                        } else {
                            Log::info('⚠️ Usuario ya está asignado a este emprendedor', [
                                'usuario_id' => $usuarioId,
                                'emprendedor_id' => $id
                            ]);
                        }
                    } else {
                        Log::warning('⚠️ Usuario no tiene rol emprendedor', ['usuario_id' => $usuarioId]);
                    }
                } else {
                    Log::warning('⚠️ Usuario no encontrado', ['usuario_id' => $usuarioId]);
                }
            }

            // ✅ CORRECCIÓN: Actualizar directamente en el modelo (como en store)
            Log::info('🔄 Actualizando directamente en el modelo', [
                'id' => $id,
                'datos_actualizacion' => $datosActualizacion,
                'opciones_acceso_en_datos' => $datosActualizacion['opciones_acceso'] ?? 'NOT_FOUND',
                'imagenes_en_datos' => $datosActualizacion['imagenes'] ?? 'NOT_FOUND'
            ]);

            // Actualizar directamente en el modelo (como en store)
            if (!empty($datosActualizacion)) {
                $emprendedor->update($datosActualizacion);
                Log::info('✅ Actualización directa completada');
            }
            
            $emprendedorActualizado = $emprendedor->fresh();

            // Eliminar puntuales de galería
            if ($ids = $request->input('eliminar_imagenes', [])) {
                Log::info('🗑️ Eliminando imágenes específicas', ['ids' => $ids]);
                $gal = collect($emprendedor->imagenes ?? []);
                foreach ($ids as $path) {
                    $this->deleteImage($path);
                    $gal = $gal->reject(fn($p) => $p === $path);
                }
                $emprendedor->imagenes = $gal->values()->all();
                $emprendedor->save();
                $resultado = $emprendedor; // Asegurar que el resultado retornado refleje el cambio
            }
            // ===============================================

            if (!$emprendedorActualizado) {
                Log::error('❌ Error en la actualización directa');
                return response()->json([
                    'success' => false,
                    'message' => 'Error al actualizar el emprendedor'
                ], Response::HTTP_NOT_FOUND);
            }

            Log::info('🎉 Actualización completada exitosamente');
            
            // Refrescar el modelo y cargar relaciones para asegurar URLs actualizadas
            $emprendedorActualizado = $emprendedorActualizado->fresh();
            $emprendedorActualizado->load([
                'slidersPrincipales',
                'slidersSecundarios',
                'servicios.horarios',
                'servicios.sliders',
                'asociacion',
                'administradores'
            ]);
            
            return response()->json([
                'success' => true,
                'message' => 'Emprendedor actualizado exitosamente',
                'data' => $emprendedorActualizado // Retornar la versión fresca con relaciones
            ], Response::HTTP_OK);

        } catch (\Exception $e) {
            Log::error('❌ Error al actualizar emprendedor', [
                'message' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Eliminar un emprendedor
     */
    public function destroy($id): JsonResponse
    {
        try {
            // Convertir ID a entero
            $id = (int) $id;

            // Cargar el modelo para la lógica de permisos y archivos
            $emprendedor = $this->emprendedorService->getById($id);

            if (!$emprendedor) {
                return response()->json([
                    'success' => false,
                    'message' => 'Emprendedor no encontrado'
                ], 404);
            }

            // Verificar si el usuario tiene permisos para eliminar este emprendedor
            if (Auth::check() && !Auth::user()->hasPermissionTo('emprendedor_delete')) {
                // Si no tiene el permiso general, verificar si es administrador principal de este emprendimiento
                $user = Auth::user();
                $esAdministradorPrincipal = $user->emprendimientos()
                    ->where('emprendedores.id', $id)
                    ->wherePivot('es_principal', true)
                    ->exists();

                if (!$esAdministradorPrincipal) {
                    return response()->json([
                        'success' => false,
                        'message' => 'No tienes permisos para eliminar este emprendedor'
                    ], Response::HTTP_FORBIDDEN);
                }
            }

            $deleted = $this->emprendedorService->delete($id);

            if (!$deleted) {
                return response()->json([
                    'success' => false,
                    'message' => 'Emprendedor no encontrado (o error en el servicio)'
                ], 404);
            }

            // === Lógica de Gestión de Imágenes (Añadida) ===
            // Borrar carpeta completa después de eliminar el registro
            $folder = "emprendedores/{$id}";
            if (Storage::disk('media')->exists($folder)) {
                Storage::disk('media')->deleteDirectory($folder);
            }
            // ===============================================

            return response()->json([
                'success' => true,
                'message' => 'Emprendedor eliminado exitosamente'
            ]);
        } catch (\Exception $e) {
            Log::error('Error al eliminar emprendedor: ' . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Buscar emprendedores por categoría
     */
    public function byCategory(string $categoria): JsonResponse
    {
        $emprendedores = $this->emprendedorService->findByCategory($categoria);

        return response()->json([
            'success' => true,
            'data' => $emprendedores
        ]);
    }

    /**
     * Obtener usuarios con rol emprendedor para asignación
     */
    public function getUsuariosEmprendedores(): JsonResponse
    {
        try {
            $usuarios = \App\Models\User::role('emprendedor')
                ->select('id', 'name', 'email', 'phone')
                ->where('active', true)
                ->orderBy('name')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $usuarios
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener usuarios emprendedores: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Obtener los servicios de un emprendedor
     */
    public function getServicios($id): JsonResponse
    {
        try {
            // Convertir ID a entero
            $id = (int) $id;

            // Buscar el emprendedor
            $emprendedor = $this->emprendedorService->getById($id);

            if (!$emprendedor) {
                return response()->json([
                    'success' => false,
                    'message' => 'Emprendedor no encontrado'
                ], Response::HTTP_NOT_FOUND);
            }

            // Cargar los servicios con sus relaciones
            $servicios = $emprendedor->servicios()
                ->with(['categorias', 'horarios', 'sliders'])
                ->get();

            return response()->json([
                'success' => true,
                'data' => $servicios
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener servicios del emprendedor: ' . $e->getMessage(), [
                'emprendedor_id' => $id,
                'trace' => $e->getTraceAsString()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Error interno del servidor'
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}