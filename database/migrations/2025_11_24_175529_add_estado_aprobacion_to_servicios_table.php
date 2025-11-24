<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('servicios', function (Blueprint $table) {
            // Verificar si la columna no existe antes de agregarla
            if (!Schema::hasColumn('servicios', 'estado_aprobacion')) {
                $table->enum('estado_aprobacion', ['pendiente', 'aprobado', 'rechazado'])
                    ->default('aprobado')
                    ->after('estado')
                    ->comment('Estado de aprobación del servicio por el administrador');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('servicios', function (Blueprint $table) {
            if (Schema::hasColumn('servicios', 'estado_aprobacion')) {
                $table->dropColumn('estado_aprobacion');
            }
        });
    }
};
