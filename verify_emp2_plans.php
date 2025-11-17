<?php

require_once 'vendor/autoload.php';

$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== VERIFICACIÓN ACTUALIZADA ===\n";

// Verificar todos los planes
echo "=== TODOS LOS PLANES ===\n";
$planes = App\Models\Plan::all();
foreach ($planes as $plan) {
    echo "Plan ID: {$plan->id}, Nombre: {$plan->nombre}, Emprendedor ID (legacy): {$plan->emprendedor_id}\n";
}

// Verificar tabla plan_emprendedores
echo "\n=== TABLA plan_emprendedores ===\n";
$planEmprendedores = DB::table('plan_emprendedores')->get();
foreach ($planEmprendedores as $pe) {
    echo "Plan ID: {$pe->plan_id}, Emprendedor ID: {$pe->emprendedor_id}, Rol: {$pe->rol}\n";
}

// Verificar qué planes tiene el emprendedor ID 11
echo "\n=== PLANES DEL EMPRENDEDOR ID 11 ===\n";
$planesEmp11 = DB::table('plan_emprendedores')->where('emprendedor_id', 11)->get();
echo "Total planes del emprendedor ID 11: " . $planesEmp11->count() . "\n";
foreach ($planesEmp11 as $pe) {
    echo "Plan ID: {$pe->plan_id}\n";
}

// Verificar inscripciones a esos planes
if ($planesEmp11->count() > 0) {
    $planIds = $planesEmp11->pluck('plan_id')->toArray();
    echo "\n=== INSCRIPCIONES A PLANES DEL EMPRENDEDOR ID 11 ===\n";
    $inscripciones = App\Models\PlanInscripcion::whereIn('plan_id', $planIds)->get();
    echo "Total inscripciones: " . $inscripciones->count() . "\n";
    foreach ($inscripciones as $insc) {
        echo "Inscripcion ID: {$insc->id}, Plan ID: {$insc->plan_id}, Usuario ID: {$insc->user_id}\n";
    }
}
