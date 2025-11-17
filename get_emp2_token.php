<?php

require_once 'vendor/autoload.php';

$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

echo "=== CREANDO TOKEN PARA EMPRENDEDOR2 ===\n";

$user = App\Models\User::where('email', 'emprendedor2@gmail.com')->first();
if ($user) {
    $token = $user->createToken('test')->plainTextToken;
    echo "Token para emprendedor2@gmail.com:\n";
    echo $token . "\n";
    
    echo "\nEmprendedores asociados:\n";
    $emprendedorIds = $user->emprendedores()->pluck('emprendedor_id')->toArray();
    echo "IDs: " . implode(', ', $emprendedorIds) . "\n";
    
    echo "\nPlanes de estos emprendedores:\n";
    $planIds = DB::table('plan_emprendedores')
        ->whereIn('emprendedor_id', $emprendedorIds)
        ->pluck('plan_id')
        ->toArray();
    echo "Plan IDs: " . implode(', ', $planIds) . "\n";
    
    echo "\nInscripciones que debería ver:\n";
    $inscripciones = App\Models\PlanInscripcion::whereIn('plan_id', $planIds)
        ->where('user_id', '!=', $user->id)
        ->get();
    echo "Total: " . $inscripciones->count() . "\n";
    foreach ($inscripciones as $insc) {
        echo "- Inscripcion ID: {$insc->id}, Plan ID: {$insc->plan_id}, Usuario ID: {$insc->user_id}\n";
    }
} else {
    echo "Usuario emprendedor2@gmail.com no encontrado\n";
}
