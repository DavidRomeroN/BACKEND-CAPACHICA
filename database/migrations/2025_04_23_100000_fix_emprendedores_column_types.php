<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB; // ✅ FALTABA

return new class extends Migration
{
    public function up()
    {
        // ✅ Convierte explícitamente a jsonb en Postgres
        DB::statement("
            ALTER TABLE emprendedores
            ALTER COLUMN certificaciones TYPE jsonb
            USING certificaciones::jsonb
        ");

        // ✅ deja nullable (esto ya no debería fallar)
        Schema::table('emprendedores', function (Blueprint $table) {
            $table->jsonb('certificaciones')->nullable()->change();
        });
    }

    public function down(): void
    {
        // ✅ Revertir jsonb -> text con cast explícito
        DB::statement("
            ALTER TABLE emprendedores
            ALTER COLUMN certificaciones TYPE text
            USING certificaciones::text
        ");

        // Si también cambiaste idiomas_hablados a jsonb en otra migración,
        // revierte igual aquí (si no existe, puedes borrar esto)
        DB::statement("
            ALTER TABLE emprendedores
            ALTER COLUMN idiomas_hablados TYPE text
            USING idiomas_hablados::text
        ");

        // ✅ opcional: volver a nullable por schema (ya como text)
        Schema::table('emprendedores', function (Blueprint $table) {
            $table->text('certificaciones')->nullable()->change();
            $table->text('idiomas_hablados')->nullable()->change();
        });
    }
};
