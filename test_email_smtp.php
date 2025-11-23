<?php

/**
 * Script de prueba para verificar configuración SMTP
 * 
 * Uso:
 *   php test_email_smtp.php tu-email-test@gmail.com
 * 
 * Asegúrate de configurar primero el .env con tus credenciales SMTP
 */

require __DIR__ . '/vendor/autoload.php';

$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make(\Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\Mail;

// Obtener email de prueba desde argumentos
$testEmail = $argv[1] ?? 'tu-email-test@gmail.com';

echo "📧 Probando configuración SMTP...\n";
echo "Enviando email a: $testEmail\n\n";

try {
    Mail::raw('Este es un email de prueba desde Capachica Turismo Backend. Si recibes este email, la configuración SMTP está funcionando correctamente.', function ($message) use ($testEmail) {
        $message->to($testEmail)
                ->subject('✅ Test SMTP - Capachica Turismo');
    });
    
    echo "✅ Email enviado exitosamente!\n";
    echo "Revisa tu inbox (y spam si no aparece): $testEmail\n";
    
} catch (\Exception $e) {
    echo "❌ Error al enviar email:\n";
    echo $e->getMessage() . "\n\n";
    echo "Verifica:\n";
    echo "1. .env configurado correctamente\n";
    echo "2. Verificación en 2 pasos activada en Gmail\n";
    echo "3. Contraseña de aplicación generada\n";
    echo "4. Cache limpiado: php artisan config:clear\n";
}










