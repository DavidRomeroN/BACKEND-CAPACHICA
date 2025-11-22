<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     * 
     * ✅ CORRECCIÓN CRÍTICA: Agregar índices para mejorar performance
     * Estos índices previenen queries lentas (5-30 segundos) cuando hay muchos datos
     */
    public function up(): void
    {
        // Índice para reservas por usuario y estado (usado frecuentemente en "Mis reservas")
        if (Schema::hasTable('reservas')) {
            try {
                Schema::table('reservas', function (Blueprint $table) {
                    $table->index(['usuario_id', 'estado'], 'idx_reservas_usuario_estado');
                    $table->index('estado', 'idx_reservas_estado');
                });
            } catch (\Exception $e) {
                // Ignorar si la tabla no existe o el índice ya existe
                if (strpos($e->getMessage(), 'does not exist') === false && 
                    strpos($e->getMessage(), 'already exists') === false &&
                    strpos($e->getMessage(), 'duplicate') === false) {
                    throw $e;
                }
            }
        }

        // Índice para inscripciones de planes (crítico para validación de cupos)
        if (Schema::hasTable('plan_inscripciones')) {
            try {
                Schema::table('plan_inscripciones', function (Blueprint $table) {
                    $table->index(['user_id', 'estado'], 'idx_plan_inscripciones_user_estado');
                    $table->index(['plan_id', 'estado'], 'idx_plan_inscripciones_plan_estado');
                    $table->index('estado', 'idx_plan_inscripciones_estado');
                });
            } catch (\Exception $e) {
                if (strpos($e->getMessage(), 'does not exist') === false && 
                    strpos($e->getMessage(), 'already exists') === false &&
                    strpos($e->getMessage(), 'duplicate') === false) {
                    throw $e;
                }
            }
        }

        // Índice para servicios por emprendedor (usado en filtros y listados)
        if (Schema::hasTable('servicios')) {
            try {
                Schema::table('servicios', function (Blueprint $table) {
                    $table->index('emprendedor_id', 'idx_servicios_emprendedor');
                    $table->index('estado', 'idx_servicios_estado');
                });
            } catch (\Exception $e) {
                if (strpos($e->getMessage(), 'does not exist') === false && 
                    strpos($e->getMessage(), 'already exists') === false &&
                    strpos($e->getMessage(), 'duplicate') === false) {
                    throw $e;
                }
            }
        }

        // Índice para reserva_servicios (usado en JOINs frecuentes)
        if (Schema::hasTable('reserva_servicios')) {
            try {
                Schema::table('reserva_servicios', function (Blueprint $table) {
                    $table->index(['reserva_id', 'estado'], 'idx_reserva_servicios_reserva_estado');
                    $table->index('servicio_id', 'idx_reserva_servicios_servicio');
                });
            } catch (\Exception $e) {
                if (strpos($e->getMessage(), 'does not exist') === false && 
                    strpos($e->getMessage(), 'already exists') === false &&
                    strpos($e->getMessage(), 'duplicate') === false) {
                    throw $e;
                }
            }
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        if (Schema::hasTable('reservas')) {
            try {
                Schema::table('reservas', function (Blueprint $table) {
                    $table->dropIndex('idx_reservas_usuario_estado');
                    $table->dropIndex('idx_reservas_estado');
                });
            } catch (\Exception $e) {
                // Ignorar si el índice no existe
            }
        }

        if (Schema::hasTable('plan_inscripciones')) {
            try {
                Schema::table('plan_inscripciones', function (Blueprint $table) {
                    $table->dropIndex('idx_plan_inscripciones_user_estado');
                    $table->dropIndex('idx_plan_inscripciones_plan_estado');
                    $table->dropIndex('idx_plan_inscripciones_estado');
                });
            } catch (\Exception $e) {
                // Ignorar si el índice no existe
            }
        }

        if (Schema::hasTable('servicios')) {
            try {
                Schema::table('servicios', function (Blueprint $table) {
                    $table->dropIndex('idx_servicios_emprendedor');
                    $table->dropIndex('idx_servicios_estado');
                });
            } catch (\Exception $e) {
                // Ignorar si el índice no existe
            }
        }

        if (Schema::hasTable('reserva_servicios')) {
            try {
                Schema::table('reserva_servicios', function (Blueprint $table) {
                    $table->dropIndex('idx_reserva_servicios_reserva_estado');
                    $table->dropIndex('idx_reserva_servicios_servicio');
                });
            } catch (\Exception $e) {
                // Ignorar si el índice no existe
            }
        }
    }
};









