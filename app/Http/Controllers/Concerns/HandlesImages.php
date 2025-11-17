<?php

namespace App\Http\Controllers\Concerns;

use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

trait HandlesImages
{
    protected function storeImage(UploadedFile $file, string $folder): string
    {
        try {
            $ext = strtolower($file->getClientOriginalExtension() ?: 'jpg');
            $name = Str::uuid().'.'.$ext;
            $path = trim($folder, '/').'/'.$name;

            // Asegurar que el directorio existe
            $directory = dirname($path);
            if (!Storage::disk('public')->exists($directory)) {
                Storage::disk('public')->makeDirectory($directory);
            }

            Storage::disk('public')->putFileAs($directory, $file, basename($path));
            return $path; // guarda este path en la BD
        } catch (\Exception $e) {
            \Log::error('Error en storeImage: ' . $e->getMessage());
            throw $e;
        }
    }

    protected function deleteImage(?string $path): void
    {
        if ($path && !filter_var($path, FILTER_VALIDATE_URL)) {
            Storage::disk('public')->delete($path);
        }
    }
}
