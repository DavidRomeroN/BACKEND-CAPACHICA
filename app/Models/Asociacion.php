<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;
use App\Helpers\ImageUrlHelper;

class Asociacion extends Model
{
    use HasFactory;

    protected $table = 'asociaciones';

    protected $fillable = [
        'nombre',
        'descripcion',
        'telefono',
        'email',
        'municipalidad_id',
        'estado',
        'imagen',
    ];

    protected $casts = [
        'estado' => 'boolean',
        'latitud' => 'float',
        'longitud' => 'float',
        'galeria' => 'array',

    ];
    protected $appends = ['imagen_url'];
    /**
     * Obtener la municipalidad a la que pertenece la asociación
     */
    public function municipalidad(): BelongsTo
    {
        return $this->belongsTo(Municipalidad::class);
    }

    /**
     * Obtener los emprendedores que pertenecen a esta asociación
     */
    public function emprendedores(): HasMany
    {
        return $this->hasMany(Emprendedor::class);
    }
    /**
     * Obtener la URL completa de la imagen
     */
    public function getImagenUrlAttribute(): ?string {
        return ImageUrlHelper::getImageUrl($this->imagen, 'media');
    }
}
