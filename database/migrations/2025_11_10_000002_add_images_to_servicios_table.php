<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('servicios', function (Blueprint $table) {
            if (!Schema::hasColumn('servicios', 'imagen')) {
                $table->string('imagen')->nullable()->after('ubicacion_referencia');
            }

            if (!Schema::hasColumn('servicios', 'galeria')) {
                $table->json('galeria')->nullable()->after('imagen');
            }
        });
    }

    public function down(): void
    {
        Schema::table('servicios', function (Blueprint $table) {
            if (Schema::hasColumn('servicios', 'galeria')) {
                $table->dropColumn('galeria');
            }

            if (Schema::hasColumn('servicios', 'imagen')) {
                $table->dropColumn('imagen');
            }
        });
    }
};












