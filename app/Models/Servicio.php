<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;
use App\Helpers\ImageUrlHelper;

class Servicio extends Model
{
    use HasFactory;

    protected $fillable = [
        'nombre',
        'descripcion',
        'precio_referencial',
        'emprendedor_id',
        'estado',
        'estado_aprobacion',
        'capacidad',
        'latitud',
        'longitud',
        'ubicacion_referencia',
        'imagen',
        'galeria',
    ];

    protected $casts = [
        'precio_referencial' => 'decimal:2',
        'estado' => 'boolean',
        'latitud' => 'decimal:7',
        'longitud' => 'decimal:7',
        'galeria' => 'array',
    ];

    // Estados de aprobación
    const ESTADO_APROBACION_PENDIENTE = 'pendiente';
    const ESTADO_APROBACION_APROBADO = 'aprobado';
    const ESTADO_APROBACION_RECHAZADO = 'rechazado';

    protected $appends = ['imagen_url','galeria_urls'];

    public function emprendedor(): BelongsTo
    {
        return $this->belongsTo(Emprendedor::class);
    }

    public function categorias(): BelongsToMany
    {
        return $this->belongsToMany(Categoria::class, 'categoria_servicio')
            ->withTimestamps();
    }

    public function sliders(): HasMany
    {
        return $this->hasMany(Slider::class, 'entidad_id')
                    ->where('tipo_entidad', 'servicio')
                    ->orderBy('orden');
    }

    public function horarios(): HasMany
    {
        return $this->hasMany(ServicioHorario::class)
                    ->where('activo', true)
                    ->orderBy('dia_semana')
                    ->orderBy('hora_inicio');
    }

    public function reservas(): HasMany
    {
        return $this->hasMany(ReservaServicio::class);
    }

    /**
     * Verifica si el servicio está disponible en una fecha y horario específicos
     */
    public function estaDisponible($fecha, $horaInicio, $horaFin): bool
    {
        // Obtener el día de la semana (lunes, martes, etc.) de la fecha dada
        $diaSemana = strtolower(date('l', strtotime($fecha)));

        // Traducir el día al español
        $diasTraducidos = [
            'monday' => 'lunes',
            'tuesday' => 'martes',
            'wednesday' => 'miercoles',
            'thursday' => 'jueves',
            'friday' => 'viernes',
            'saturday' => 'sabado',
            'sunday' => 'domingo',
        ];

        $diaSemanaEsp = $diasTraducidos[$diaSemana] ?? $diaSemana;

        // Verificar si existe un horario disponible para ese día
        $horarioDisponible = $this->horarios()
            ->where('dia_semana', $diaSemanaEsp)
            ->where('hora_inicio', '<=', $horaInicio)
            ->where('hora_fin', '>=', $horaFin)
            ->exists();

        if (!$horarioDisponible) {
            return false;
        }

        // Verificar si ya existe una reserva para ese servicio en ese horario
        $reservaExistente = $this->reservas()
            ->where('fecha_inicio', '<=', $fecha)
            ->where('fecha_fin', '>=', $fecha)
            ->where(function($query) use ($horaInicio, $horaFin) {
                $query->where(function($q) use ($horaInicio, $horaFin) {
                    // Coincidencia exacta
                    $q->where('hora_inicio', '=', $horaInicio)
                      ->where('hora_fin', '=', $horaFin);
                })->orWhere(function($q) use ($horaInicio, $horaFin) {
                    // Hora de inicio dentro del rango existente
                    $q->where('hora_inicio', '<', $horaInicio)
                      ->where('hora_fin', '>', $horaInicio);
                })->orWhere(function($q) use ($horaInicio, $horaFin) {
                    // Hora de fin dentro del rango existente
                    $q->where('hora_inicio', '<', $horaFin)
                      ->where('hora_fin', '>', $horaFin);
                })->orWhere(function($q) use ($horaInicio, $horaFin) {
                    // El rango existente está dentro del nuevo rango
                    $q->where('hora_inicio', '>=', $horaInicio)
                      ->where('hora_fin', '<=', $horaFin);
                });
            })
            ->whereIn('estado', ['pendiente', 'confirmado'])
            ->exists();

        return !$reservaExistente;
    }



    public function getImagenUrlAttribute(): ?string {
        return ImageUrlHelper::getImageUrl($this->imagen ?? null, 'public');
    }

    public function getGaleriaUrlsAttribute(): array {
        return ImageUrlHelper::getImageUrls($this->galeria ?? null, 'public');
    }

    // Scopes para estado de aprobación
    public function scopePendientesAprobacion($query)
    {
        return $query->where('estado_aprobacion', self::ESTADO_APROBACION_PENDIENTE);
    }

    public function scopeAprobados($query)
    {
        return $query->where('estado_aprobacion', self::ESTADO_APROBACION_APROBADO);
    }

    public function scopeRechazados($query)
    {
        return $query->where('estado_aprobacion', self::ESTADO_APROBACION_RECHAZADO);
    }

    // Verificar si está aprobado
    public function estaAprobado(): bool
    {
        return $this->estado_aprobacion === self::ESTADO_APROBACION_APROBADO;
    }

    // Verificar si está pendiente
    public function estaPendiente(): bool
    {
        return $this->estado_aprobacion === self::ESTADO_APROBACION_PENDIENTE;
    }

}
