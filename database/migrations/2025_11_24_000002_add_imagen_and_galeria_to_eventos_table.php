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
        Schema::table('eventos', function (Blueprint $table) {
            // Verificar si la columna no existe antes de agregarla
            if (!Schema::hasColumn('eventos', 'imagen')) {
                $table->string('imagen')->nullable()->after('que_llevar');
            }
            if (!Schema::hasColumn('eventos', 'galeria')) {
                $table->json('galeria')->nullable()->after('imagen');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('eventos', function (Blueprint $table) {
            if (Schema::hasColumn('eventos', 'imagen')) {
                $table->dropColumn('imagen');
            }
            if (Schema::hasColumn('eventos', 'galeria')) {
                $table->dropColumn('galeria');
            }
        });
    }
};

