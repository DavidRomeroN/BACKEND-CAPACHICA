<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Support\Facades\Storage;
use App\Helpers\ImageUrlHelper;

class Slider extends Model
{
    use HasFactory;

    protected $fillable = [
        'url',
        'nombre',
        'es_principal',
        'tipo_entidad',
        'entidad_id',
        'orden',
        'activo'
    ];

    protected $appends = ['url_completa'];

    protected $casts = [
        'es_principal' => 'boolean',
        'activo' => 'boolean',
        'galeria' => 'array',

    ];

    public function descripcion(): HasOne
    {
        return $this->hasOne(SliderDescripcion::class);
    }

    // Relación polimórfica para diferentes entidades
    public function entidad()
    {
        return $this->morphTo('entidad', 'tipo_entidad', 'entidad_id');
    }

    // Atributo dinámico para generar URL completa
    public function getUrlCompletaAttribute(): string {
        return ImageUrlHelper::getImageUrl($this->url, 'media') ?? '';
    }
}
