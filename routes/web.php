<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\StorageController;
use Illuminate\Http\Request;
use App\Http\Controllers\API\Auth\AuthController;

Route::get('/', function () {
    return view('welcome');
});

// Ruta para servir archivos del storage (soporta subcarpetas)
Route::get('/storage-files/{path}', [StorageController::class, 'serveFile'])
    ->where('path', '.*')
    ->name('storage.local');

// Proxy web para verificación de email (redirecciona a la ruta API firmada)
Route::get('/verify-email', function (Request $request) {
    $id = $request->query('id');
    $hash = $request->query('hash');
    $expires = $request->query('expires');
    $signature = $request->query('signature');
    
    if (!$id || !$hash || !$expires || !$signature) {
        return response()->view('emails.email-verified', [
            'success' => false,
            'message' => 'El enlace de verificación está incompleto.'
        ], 400);
    }
    
    $qs = http_build_query([
        'expires' => $expires,
        'signature' => $signature,
    ]);
    
    return redirect("/api/email/verify/{$id}/{$hash}?{$qs}");
})->name('verification.verify.web');

// Ruta WEB directa para verificación (procesa y muestra vista)
Route::get('/email/verify/{id}/{hash}', [AuthController::class, 'verifyEmailWeb'])
    ->middleware(['signed', 'throttle:6,1'])
    ->name('verification.verify.web.direct');
