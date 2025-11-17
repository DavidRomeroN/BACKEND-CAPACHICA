<?php

namespace App\Repository;

use App\Models\ReservaServicio;
use App\Models\Servicio;
use App\Models\ServicioHorario;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class ServicioRepository
{
    protected $model;
    protected $sliderRepository;

    public function __construct(Servicio $servicio, SliderRepository $sliderRepository = null)
    {
        $this->model = $servicio;
        $this->sliderRepository = $sliderRepository ?: app(SliderRepository::class);
    }

    public function getAll(): Collection
    {
        return $this->model->with(['emprendedor', 'categorias', 'horarios'])->get();
    }

    public function getPaginated(int $perPage = 15): LengthAwarePaginator
    {
        return $this->model->with(['emprendedor', 'categorias', 'horarios'])->paginate($perPage);
    }

    public function findById(int $id): ?Servicio
    {
        return $this->model->with(['emprendedor', 'categorias', 'horarios', 'sliders'])->find($id);
    }

    public function create(array $data, array $categoriaIds = [], array $horarios = []): Servicio
    {
        try {
            DB::beginTransaction();
            
            // Extraer datos de sliders si existen
            $sliders = $data['sliders'] ?? [];
            
            // Eliminar datos de sliders y horarios del array principal
            unset($data['sliders']);
            unset($data['horarios']);
            
            $servicio = $this->model->create($data);
            
            if (!empty($categoriaIds)) {
                $servicio->categorias()->sync($categoriaIds);
            }
            
            // Crear horarios si existen
            if (!empty($horarios)) {
                foreach ($horarios as $horario) {
                    $servicio->horarios()->create($horario);
                }
            }
            
            // Crear sliders si existen
            if (!empty($sliders)) {
                // Agregar es_principal a cada slider si no está definido
                foreach ($sliders as &$slider) {
                    if (!isset($slider['es_principal'])) {
                        $slider['es_principal'] = true; // valor predeterminado
                    }
                }
                $this->sliderRepository->createMultiple('servicio', $servicio->id, $sliders);
            }
            
            DB::commit();
            return $servicio->fresh(['emprendedor', 'categorias', 'sliders', 'horarios']);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function update(int $id, array $data, array $categoriaIds = [], array $horarios = []): bool
    {
        try {
            DB::beginTransaction();
            
            $servicio = $this->findById($id);
            if (!$servicio) {
                DB::rollBack();
                return false;
            }
            
            // Extraer datos de sliders si existen
            $sliders = $data['sliders'] ?? [];
            $deletedSliderIds = $data['deleted_sliders'] ?? [];
            
            // Eliminar datos de sliders y horarios del array principal
            unset($data['sliders']);
            unset($data['deleted_sliders']);
            unset($data['horarios']);
            unset($data['deleted_horarios']);
            
            $updated = $servicio->update($data);
            
            if ($updated && !empty($categoriaIds)) {
                $servicio->categorias()->sync($categoriaIds);
            }
            
            // Actualizar horarios
            if (!empty($horarios)) {
                // Eliminar horarios existentes que no sean actualizados
                $horariosIds = array_column($horarios, 'id');
                $horariosIds = array_filter($horariosIds); // Eliminar valores nulos
                
                if (!empty($horariosIds)) {
                    $servicio->horarios()->whereNotIn('id', $horariosIds)->delete();
                } else {
                    $servicio->horarios()->delete();
                }
                
                // Crear o actualizar horarios
                foreach ($horarios as $horarioData) {
                    $horarioId = $horarioData['id'] ?? null;
                    unset($horarioData['id']);
                    
                    if ($horarioId) {
                        $horario = ServicioHorario::find($horarioId);
                        if ($horario && $horario->servicio_id == $servicio->id) {
                            $horario->update($horarioData);
                        }
                    } else {
                        $horarioData['servicio_id'] = $servicio->id;
                        ServicioHorario::create($horarioData);
                    }
                }
            }
            
            // Eliminar sliders especificados
            if (!empty($deletedSliderIds)) {
                foreach ($deletedSliderIds as $sliderId) {
                    $this->sliderRepository->delete($sliderId);
                }
            }
            
            // Actualizar sliders si existen
            if (!empty($sliders)) {
                $this->sliderRepository->updateEntitySliders('servicio', $servicio->id, $sliders);
            }
            
            DB::commit();
            return $updated;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function delete(int $id): bool
    {
        try {
            DB::beginTransaction();
            
            $servicio = $this->findById($id);
            if (!$servicio) {
                DB::rollBack();
                return false;
            }
            
            // Eliminar horarios
            $servicio->horarios()->delete();
            
            // Eliminar sliders asociados
            $servicio->sliders->each(function ($slider) {
                app(SliderRepository::class)->delete($slider->id);
            });
            
            $deleted = $servicio->delete();
            
            DB::commit();
            return $deleted;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function getActiveServicios(): Collection
    {
        return $this->model->where('estado', true)
            ->with(['emprendedor', 'categorias', 'horarios'])
            ->get();
    }

    public function getServiciosByEmprendedor(int $emprendedorId): Collection
    {
        return $this->model->where('emprendedor_id', $emprendedorId)
            ->with(['categorias', 'horarios'])
            ->get();
    }

    public function getServiciosByCategoria(int $categoriaId): Collection
    {
        return $this->model->whereHas('categorias', function ($query) use ($categoriaId) {
            $query->where('categorias.id', $categoriaId);
        })->with(['emprendedor', 'categorias', 'horarios'])->get();
    }
    
    /**
     * Verifica la disponibilidad de un servicio en una fecha y horario específicos
     */
    public function verificarDisponibilidad(int $servicioId, string $fecha, string $horaInicio, string $horaFin, int $cantidadSolicitada = 1, ?int $excluirReservaServicioId = null): bool
    {
        $resultado = $this->calcularCuposDisponibles($servicioId, $fecha, $horaInicio, $horaFin, $cantidadSolicitada, $excluirReservaServicioId);
        return $resultado['disponible'] ?? false;
    }

    public function calcularCuposDisponibles(
        int $servicioId,
        string $fecha,
        string $horaInicio,
        string $horaFin,
        int $cantidadSolicitada = 1,
        ?int $excluirReservaServicioId = null
    ): array {
        $servicio = $this->model->with('horarios')->find($servicioId);

        if (!$servicio) {
            return [
                'disponible' => false,
                'motivo' => 'servicio_no_encontrado',
                'cupo_total' => 0,
                'cupo_reservado' => 0,
                'cupo_restante' => 0,
                'cantidad_solicitada' => $cantidadSolicitada,
            ];
        }

        $capacidad = $servicio->capacidad;
        if ($capacidad !== null) {
            $capacidad = (int)$capacidad;
        }

        $mapDias = [
            'monday' => 'lunes',
            'tuesday' => 'martes',
            'wednesday' => 'miercoles',
            'thursday' => 'jueves',
            'friday' => 'viernes',
            'saturday' => 'sabado',
            'sunday' => 'domingo',
        ];

        $diaEnglish = strtolower(Carbon::parse($fecha)->format('l'));
        $diaSemana = $mapDias[$diaEnglish] ?? $diaEnglish;

        $horarioDisponible = $servicio->horarios()
            ->where('dia_semana', $diaSemana)
            ->where('activo', true)
            ->where('hora_inicio', '<=', $horaInicio)
            ->where('hora_fin', '>=', $horaFin)
            ->first();

        if (!$horarioDisponible) {
            return [
                'disponible' => false,
                'motivo' => 'sin_horario',
                'cupo_total' => $capacidad,
                'cupo_reservado' => 0,
                'cupo_restante' => $capacidad,
                'cantidad_solicitada' => $cantidadSolicitada,
            ];
        }

        $reservasQuery = ReservaServicio::where('servicio_id', $servicioId)
            ->whereIn('estado', [ReservaServicio::ESTADO_PENDIENTE, ReservaServicio::ESTADO_CONFIRMADO])
            ->where(function ($query) use ($fecha) {
                $query->whereDate('fecha_inicio', $fecha)
                    ->orWhere(function ($inner) use ($fecha) {
                        $inner->where('fecha_inicio', '<=', $fecha)
                              ->where(function ($nested) use ($fecha) {
                                  $nested->whereDate('fecha_fin', '>=', $fecha)
                                         ->orWhereNull('fecha_fin');
                              });
                    });
            })
            ->where(function ($query) use ($horaInicio, $horaFin) {
                $query->where(function ($inner) use ($horaInicio, $horaFin) {
                    $inner->where('hora_inicio', '<', $horaFin)
                          ->where('hora_fin', '>', $horaInicio);
                });
            });

        if ($excluirReservaServicioId) {
            $reservasQuery->where('id', '!=', $excluirReservaServicioId);
        }

        $cupoReservado = (int)$reservasQuery->sum('cantidad');

        $cupoRestante = $capacidad !== null ? max(0, $capacidad - $cupoReservado) : null;

        if ($capacidad !== null) {
            if ($cupoRestante <= 0) {
                return [
                    'disponible' => false,
                    'motivo' => 'sin_cupo',
                    'cupo_total' => $capacidad,
                    'cupo_reservado' => $cupoReservado,
                    'cupo_restante' => 0,
                    'cantidad_solicitada' => $cantidadSolicitada,
                ];
            }

            if ($cantidadSolicitada > $cupoRestante) {
                return [
                    'disponible' => false,
                    'motivo' => 'sin_cupo',
                    'cupo_total' => $capacidad,
                    'cupo_reservado' => $cupoReservado,
                    'cupo_restante' => $cupoRestante,
                    'cantidad_solicitada' => $cantidadSolicitada,
                ];
            }
        }

        return [
            'disponible' => true,
            'motivo' => null,
            'cupo_total' => $capacidad,
            'cupo_reservado' => $cupoReservado,
            'cupo_restante' => $cupoRestante,
            'cantidad_solicitada' => $cantidadSolicitada,
        ];
    }
    
    /**
     * Obtiene los servicios disponibles en un área geográfica (por distancia)
     */
    public function getServiciosByUbicacion(float $latitud, float $longitud, float $distanciaKm = 10): Collection
    {
        $haversine = "(
            6371 * acos(
                cos(radians(?)) * cos(radians(latitud)) *
                cos(radians(longitud) - radians(?)) +
                sin(radians(?)) * sin(radians(latitud))
            )
        )";

        $baseQuery = $this->model->where('estado', true)
            ->whereNotNull('latitud')
            ->whereNotNull('longitud')
            ->selectRaw("*, $haversine AS distancia", [$latitud, $longitud, $latitud]);

        $rawResults = DB::table(DB::raw("({$baseQuery->toSql()}) as sub"))
            ->mergeBindings($baseQuery->getQuery())
            ->where('distancia', '<=', $distanciaKm)
            ->orderBy('distancia')
            ->get();

        $servicios = Servicio::hydrate($rawResults->toArray());

        // ⚠️ Si quieres ver la distancia en el JSON, debes agregar un accessor en el modelo
        return $servicios->load(['emprendedor', 'categorias', 'horarios']);
    }


}