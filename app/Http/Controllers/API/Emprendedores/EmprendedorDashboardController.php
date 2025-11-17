<?php

namespace App\Http\Controllers\API\Emprendedores;

use App\Http\Controllers\Controller;
use App\Models\Reserva;
use App\Models\PlanInscripcion;
use App\Models\Emprendedor;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;

class EmprendedorDashboardController extends Controller
{
    /**
     * Obtener TODAS las reservas de TODOS los emprendimientos del usuario
     */
    public function misReservas(Request $request): JsonResponse
    {
        try {
            $user = Auth::user();
            
            // Verificar que tenga rol emprendedor
            if (!$user->hasRole('emprendedor')) {
                return response()->json([
                    'success' => false,
                    'message' => 'No tienes permisos de emprendedor'
                ], Response::HTTP_FORBIDDEN);
            }
            
            // Obtener IDs de todos los emprendimientos del usuario
            $emprendimientoIds = $user->emprendimientos()->pluck('emprendedor_id');
            
            if ($emprendimientoIds->isEmpty()) {
                return response()->json([
                    'success' => true,
                    'data' => [
                        'data' => [],
                        'total' => 0,
                        'message' => 'No tienes emprendimientos registrados'
                    ]
                ]);
            }
            
            // Obtener reservas de todos sus emprendimientos
            $reservas = Reserva::whereHas('servicios', function($query) use ($emprendimientoIds) {
                $query->whereIn('emprendedor_id', $emprendimientoIds);
            })
            ->where('estado', '!=', Reserva::ESTADO_EN_CARRITO)
            ->with([
                'usuario:id,name,email,phone',
                'servicios' => function($query) use ($emprendimientoIds) {
                    $query->whereIn('emprendedor_id', $emprendimientoIds)
                          ->with(['servicio:id,nombre,descripcion,precio_referencial', 'emprendedor:id,nombre']);
                }
            ])
            ->orderBy('created_at', 'desc')
            ->paginate(15);
            
            return response()->json([
                'success' => true,
                'data' => $reservas
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener reservas del emprendedor: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Obtener TODAS las inscripciones de TODOS los planes del usuario
     */
    public function misInscripciones(Request $request): JsonResponse
    {
        try {
            $user = Auth::user();
            
            // Verificar que tenga rol emprendedor
            if (!$user->hasRole('emprendedor')) {
                return response()->json([
                    'success' => false,
                    'message' => 'No tienes permisos de emprendedor'
                ], Response::HTTP_FORBIDDEN);
            }
            
            // Obtener IDs de todos los emprendimientos del usuario
            $emprendimientoIds = $user->emprendimientos()->pluck('emprendedor_id');
            
            if ($emprendimientoIds->isEmpty()) {
                return response()->json([
                    'success' => true,
                    'data' => [
                        'data' => [],
                        'total' => 0,
                        'message' => 'No tienes emprendimientos registrados'
                    ]
                ]);
            }
            
            // Obtener inscripciones de planes donde el emprendedor participa
            $inscripciones = PlanInscripcion::whereHas('plan.emprendedores', function($query) use ($emprendimientoIds) {
                $query->whereIn('emprendedores.id', $emprendimientoIds);
            })
            ->with([
                'usuario:id,name,email,phone',
                'plan:id,nombre,descripcion,precio_total',
                'plan.emprendedores' => function($query) use ($emprendimientoIds) {
                    $query->whereIn('emprendedores.id', $emprendimientoIds)
                          ->select('emprendedores.id', 'emprendedores.nombre');
                }
            ])
            ->orderBy('created_at', 'desc')
            ->paginate(15);
            
            return response()->json([
                'success' => true,
                'data' => $inscripciones
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener inscripciones del emprendedor: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * Obtener dashboard con estadísticas del emprendedor
     */
    public function dashboard(): JsonResponse
    {
        try {
            $user = Auth::user();
            
            // Verificar que tenga rol emprendedor
            if (!$user->hasRole('emprendedor')) {
                return response()->json([
                    'success' => false,
                    'message' => 'No tienes permisos de emprendedor'
                ], Response::HTTP_FORBIDDEN);
            }
            
            // Obtener IDs de todos los emprendimientos del usuario
            $emprendimientoIds = $user->emprendimientos()->pluck('emprendedor_id');
            
            if ($emprendimientoIds->isEmpty()) {
                return response()->json([
                    'success' => true,
                    'data' => [
                        'emprendimientos_count' => 0,
                        'reservas_pendientes' => 0,
                        'reservas_confirmadas' => 0,
                        'inscripciones_pendientes' => 0,
                        'ingresos_mes' => 0,
                        'message' => 'No tienes emprendimientos registrados'
                    ]
                ]);
            }
            
            // Estadísticas de reservas
            $reservasPendientes = Reserva::whereHas('servicios', function($query) use ($emprendimientoIds) {
                $query->whereIn('emprendedor_id', $emprendimientoIds);
            })->where('estado', 'pendiente')->count();
            
            $reservasConfirmadas = Reserva::whereHas('servicios', function($query) use ($emprendimientoIds) {
                $query->whereIn('emprendedor_id', $emprendimientoIds);
            })->where('estado', 'confirmada')->count();
            
            // Estadísticas de inscripciones
            $inscripcionesPendientes = PlanInscripcion::whereHas('plan.emprendedores', function($query) use ($emprendimientoIds) {
                $query->whereIn('emprendedores.id', $emprendimientoIds);
            })->where('estado', 'pendiente')->count();
            
            // Ingresos del mes (simplificado)
            $ingresosMes = Reserva::whereHas('servicios', function($query) use ($emprendimientoIds) {
                $query->whereIn('emprendedor_id', $emprendimientoIds);
            })
            ->where('estado', 'confirmada')
            ->whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->with('servicios')
            ->get()
            ->sum(function($reserva) {
                return $reserva->servicios->sum('precio');
            });
            
            return response()->json([
                'success' => true,
                'data' => [
                    'emprendimientos_count' => $emprendimientoIds->count(),
                    'reservas_pendientes' => $reservasPendientes,
                    'reservas_confirmadas' => $reservasConfirmadas,
                    'inscripciones_pendientes' => $inscripcionesPendientes,
                    'ingresos_mes' => $ingresosMes,
                    'emprendimientos' => $user->emprendimientos()->select('id', 'nombre', 'tipo_servicio')->get()
                ]
            ]);
        } catch (\Exception $e) {
            Log::error('Error al obtener dashboard del emprendedor: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Error al procesar la solicitud: ' . $e->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
