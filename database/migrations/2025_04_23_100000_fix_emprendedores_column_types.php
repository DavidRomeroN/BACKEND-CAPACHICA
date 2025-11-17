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
        Schema::table('emprendedores', function (Blueprint $table) {
            // Cambiar certificaciones de string a json
            $table->json('certificaciones')->nullable()->change();
            
            // Cambiar idiomas_hablados de string a json
            $table->json('idiomas_hablados')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('emprendedores', function (Blueprint $table) {
            // Revertir certificaciones de json a string
            $table->string('certificaciones')->nullable()->change();
            
            // Revertir idiomas_hablados de json a string
            $table->string('idiomas_hablados')->nullable()->change();
        });
    }
};



