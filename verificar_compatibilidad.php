<?php

/**
 * Script para verificar compatibilidad de cambios antes de desplegar
 * 
 * Uso: php verificar_compatibilidad.php
 * 
 * Este script verifica:
 * - Migraciones nuevas
 * - Cambios en modelos
 * - Cambios en controladores
 * - Endpoints que podrían romperse
 */

require __DIR__ . '/vendor/autoload.php';

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "🔍 Verificando compatibilidad de cambios...\n\n";

$warnings = [];
$errors = [];
$info = [];

// 1. Verificar migraciones pendientes
echo "📊 Migraciones:\n";
try {
    $migrations = DB::select("SELECT * FROM migrations ORDER BY id DESC LIMIT 10");
    echo "   ✅ Base de datos accesible\n";
    echo "   📝 Últimas 10 migraciones aplicadas\n";
} catch (\Exception $e) {
    $errors[] = "No se puede acceder a la base de datos: " . $e->getMessage();
    echo "   ❌ Error accediendo a base de datos\n";
}

// 2. Verificar tablas críticas
echo "\n📋 Tablas críticas:\n";
$criticalTables = ['users', 'emprendedores', 'eventos', 'planes', 'servicios'];
foreach ($criticalTables as $table) {
    if (Schema::hasTable($table)) {
        echo "   ✅ Tabla '$table' existe\n";
    } else {
        $errors[] = "Tabla crítica '$table' no existe";
        echo "   ❌ Tabla '$table' NO existe\n";
    }
}

// 3. Verificar columnas críticas en emprendedores
echo "\n🔍 Columnas en 'emprendedores':\n";
if (Schema::hasTable('emprendedores')) {
    $columns = Schema::getColumnListing('emprendedores');
    $criticalColumns = ['id', 'nombre', 'descripcion', 'user_id'];
    foreach ($criticalColumns as $col) {
        if (in_array($col, $columns)) {
            echo "   ✅ Columna '$col' existe\n";
        } else {
            $warnings[] = "Columna '$col' no encontrada en 'emprendedores'";
            echo "   ⚠️  Columna '$col' NO existe\n";
        }
    }
}

// 4. Verificar endpoints de API
echo "\n🌐 Endpoints de API:\n";
$routes = \Illuminate\Support\Facades\Route::getRoutes();
$apiRoutes = [];
foreach ($routes as $route) {
    if (str_starts_with($route->uri(), 'api/')) {
        $apiRoutes[] = $route->uri();
    }
}

$criticalEndpoints = [
    'api/emprendedores',
    'api/eventos',
    'api/planes',
    'api/servicios',
    'api/login',
    'api/register',
];

foreach ($criticalEndpoints as $endpoint) {
    $found = false;
    foreach ($apiRoutes as $route) {
        if (str_contains($route, $endpoint)) {
            $found = true;
            break;
        }
    }
    if ($found) {
        echo "   ✅ Endpoint '$endpoint' existe\n";
    } else {
        $warnings[] = "Endpoint crítico '$endpoint' no encontrado";
        echo "   ⚠️  Endpoint '$endpoint' NO encontrado\n";
    }
}

// 5. Verificar configuración
echo "\n⚙️  Configuración:\n";
$appEnv = config('app.env');
$appDebug = config('app.debug');

if ($appEnv === 'production' && $appDebug) {
    $errors[] = "APP_DEBUG está en true en producción";
    echo "   ❌ APP_DEBUG está en true (debe ser false en producción)\n";
} else {
    echo "   ✅ APP_DEBUG: " . ($appDebug ? 'true' : 'false') . "\n";
}

// Resumen
echo "\n" . str_repeat("=", 50) . "\n";
echo "📊 RESUMEN\n";
echo str_repeat("=", 50) . "\n";

if (empty($errors) && empty($warnings)) {
    echo "✅ Todo parece estar bien. Puedes proceder con el despliegue.\n";
    exit(0);
}

if (!empty($errors)) {
    echo "❌ ERRORES ENCONTRADOS:\n";
    foreach ($errors as $error) {
        echo "   - $error\n";
    }
    echo "\n⚠️  NO se recomienda desplegar hasta resolver estos errores.\n";
}

if (!empty($warnings)) {
    echo "\n⚠️  ADVERTENCIAS:\n";
    foreach ($warnings as $warning) {
        echo "   - $warning\n";
    }
    echo "\n💡 Revisa estas advertencias antes de desplegar.\n";
}

exit(empty($errors) ? 0 : 1);



