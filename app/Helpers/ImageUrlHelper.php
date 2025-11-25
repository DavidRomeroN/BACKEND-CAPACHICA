<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Storage;

class ImageUrlHelper
{
    /**
     * Genera una URL completa para una imagen almacenada
     * 
     * @param string|null $path Ruta de la imagen (relativa o absoluta)
     * @param string $disk Disco de storage a usar ('public' o 'media')
     * @return string|null URL completa de la imagen o null si no hay path
     */
    public static function getImageUrl(?string $path, string $disk = 'public'): ?string
    {
        if (!$path) {
            return null;
        }

        // Si ya es una URL completa, devolverla tal cual
        if (filter_var($path, FILTER_VALIDATE_URL)) {
            return $path;
        }

        // Generar URL usando el disco configurado
        $url = Storage::disk($disk)->url($path);
        
        // Asegurar que sea URL absoluta
        if (!filter_var($url, FILTER_VALIDATE_URL)) {
            $url = url($url);
        }

        return $url;
    }

    /**
     * Genera URLs completas para un array de imágenes
     * 
     * @param array|null $paths Array de rutas de imágenes
     * @param string $disk Disco de storage a usar
     * @return array Array de URLs completas
     */
    public static function getImageUrls(?array $paths, string $disk = 'public'): array
    {
        if (!$paths || !is_array($paths)) {
            return [];
        }

        return collect($paths)->map(function($path) use ($disk) {
            return self::getImageUrl($path, $disk);
        })->filter()->values()->all();
    }
}

