<?php

namespace App\Observers;

use App\Models\Evento;
use App\Models\Plan;
use Illuminate\Support\Facades\Storage;

class EventoObserver
{
    /**
     * Sincronizar imágenes después de guardar
     */
    public function saved(Evento $evento): void
    {
        // Sincronizar imagen principal
        if ($evento->imagen && !filter_var($evento->imagen, FILTER_VALIDATE_URL)) {
            $this->syncImageToPublic($evento->imagen);
        }

        // Sincronizar galería
        if ($evento->galeria && is_array($evento->galeria)) {
            foreach ($evento->galeria as $imagePath) {
                if (!filter_var($imagePath, FILTER_VALIDATE_URL)) {
                    $this->syncImageToPublic($imagePath);
                }
            }
        }
    }

    /**
     * Sincronizar imagen a public/storage
     */
    private function syncImageToPublic(string $imagePath): void
    {
        $sourcePath = storage_path('app/public/' . $imagePath);
        $destinationPath = public_path('storage/' . $imagePath);

        // Crear directorio de destino si no existe
        $destinationDir = dirname($destinationPath);
        if (!file_exists($destinationDir)) {
            mkdir($destinationDir, 0755, true);
        }

        // Copiar archivo
        if (file_exists($sourcePath)) {
            copy($sourcePath, $destinationPath);
        }
    }

    public function deleted(Evento $evento): void
    {
        // si usas SoftDeletes y no quieres borrar físicamente en delete simple, sal aquí.
        // if (method_exists($plan, 'isForceDeleting') && !$plan->isForceDeleting()) return;

        $folder = "eventos/{$evento->id}";
        if (Storage::disk('media')->exists($folder)) {
            Storage::disk('media')->deleteDirectory($folder);
        }

        // También eliminar de public/storage
        $publicFolder = public_path("storage/eventos/{$evento->id}");
        if (file_exists($publicFolder)) {
            $this->deleteDirectory($publicFolder);
        }

        // Eliminar imagen principal de public
        if ($evento->imagen && !filter_var($evento->imagen, FILTER_VALIDATE_URL)) {
            $publicPath = public_path('storage/' . $evento->imagen);
            if (file_exists($publicPath)) {
                unlink($publicPath);
            }
        }

        // Eliminar galería de public
        if ($evento->galeria && is_array($evento->galeria)) {
            foreach ($evento->galeria as $imagePath) {
                if (!filter_var($imagePath, FILTER_VALIDATE_URL)) {
                    $publicPath = public_path('storage/' . $imagePath);
                    if (file_exists($publicPath)) {
                        unlink($publicPath);
                    }
                }
            }
        }
    }

    /**
     * Eliminar directorio recursivamente
     */
    private function deleteDirectory(string $dir): void
    {
        if (!is_dir($dir)) {
            return;
        }

        $files = array_diff(scandir($dir), ['.', '..']);
        foreach ($files as $file) {
            $path = $dir . DIRECTORY_SEPARATOR . $file;
            is_dir($path) ? $this->deleteDirectory($path) : unlink($path);
        }
        rmdir($dir);
    }
}
