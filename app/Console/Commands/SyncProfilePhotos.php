<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class SyncProfilePhotos extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'storage:sync-photos';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Sincronizar fotos de perfil de storage/app/public a public/storage';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $source = storage_path('app/public/fotos_perfil');
        $destination = public_path('storage/fotos_perfil');

        // Verificar que el directorio de origen existe
        if (!File::exists($source)) {
            $this->error('El directorio de origen no existe: ' . $source);
            return 1;
        }

        // Crear el directorio de destino si no existe
        if (!File::exists($destination)) {
            File::makeDirectory($destination, 0755, true);
            $this->info('Directorio de destino creado: ' . $destination);
        }

        // Obtener todos los archivos del directorio de origen
        $files = File::files($source);
        $syncedCount = 0;

        foreach ($files as $file) {
            $filename = $file->getFilename();
            $destinationFile = $destination . DIRECTORY_SEPARATOR . $filename;

            // Copiar solo si el archivo no existe o es diferente
            if (!File::exists($destinationFile) || File::lastModified($file->getPathname()) > File::lastModified($destinationFile)) {
                File::copy($file->getPathname(), $destinationFile);
                $syncedCount++;
                $this->line("✓ Sincronizado: {$filename}");
            }
        }

        if ($syncedCount > 0) {
            $this->info("✓ {$syncedCount} foto(s) sincronizada(s) exitosamente.");
        } else {
            $this->info('✓ Todas las fotos ya están sincronizadas.');
        }

        return 0;
    }
}
