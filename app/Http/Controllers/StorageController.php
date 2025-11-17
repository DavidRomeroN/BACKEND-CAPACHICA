<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\StreamedResponse;

class StorageController extends Controller
{
    /**
     * Servir archivos de storage con streaming
     *
     * @param string $folder
     * @param string $filename
     * @return StreamedResponse
     */
    public function serveFile(string $path)
    {
        $cleanPath = ltrim($path, '/');
        
        // Verificar que el archivo existe
        if (str_contains($cleanPath, '..')) {
            abort(403, 'Acceso no permitido');
        }

        if (!Storage::disk('public')->exists($cleanPath)) {
            abort(404, 'Archivo no encontrado');
        }
        
        $fullPath = Storage::disk('public')->path($cleanPath);
        $mimeType = Storage::disk('public')->mimeType($cleanPath) ?? 'application/octet-stream';
        $fileSize = Storage::disk('public')->size($cleanPath);
        
        // Crear respuesta con streaming
        return response()->stream(
            function () use ($fullPath) {
                $stream = fopen($fullPath, 'rb');
                
                // Leer y enviar en chunks de 8KB
                while (!feof($stream)) {
                    echo fread($stream, 8192);
                    flush();
                }
                
                fclose($stream);
            },
            200,
            [
                'Content-Type' => $mimeType,
                'Content-Length' => $fileSize,
                'Cache-Control' => 'public, max-age=31536000',
                'Expires' => gmdate('D, d M Y H:i:s \G\M\T', time() + 31536000),
                'Accept-Ranges' => 'bytes',
            ]
        );
    }
}
