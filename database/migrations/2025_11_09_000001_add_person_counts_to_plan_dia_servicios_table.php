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
        Schema::table('plan_dia_servicios', function (Blueprint $table) {
            $table->unsignedInteger('capacidad_personas')->nullable()->after('precio_adicional');
            $table->unsignedInteger('cantidad_personas')->nullable()->after('capacidad_personas');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('plan_dia_servicios', function (Blueprint $table) {
            $table->dropColumn(['capacidad_personas', 'cantidad_personas']);
        });
    }
};






