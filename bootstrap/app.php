<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful;
use Spatie\Permission\Middleware\PermissionMiddleware;
use Spatie\Permission\Middleware\RoleMiddleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        // Middleware de Sanctum para API stateful
        $middleware->statefulApi();

        // Aliases para Spatie
        $middleware->alias([
            'permission' => PermissionMiddleware::class,
            'role' => RoleMiddleware::class,
        ]);

        // Middleware adicional para el grupo API
        $middleware->group('api', [
            EnsureFrontendRequestsAreStateful::class,

        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        // No autenticado (token inválido o no enviado)
        $exceptions->render(function (\Illuminate\Auth\AuthenticationException $e, $request) {
            // Log del error 401
            \Log::warning('No autenticado (401)', [
                'message' => $e->getMessage(),
                'request_url' => $request->fullUrl(),
                'request_method' => $request->method(),
                'authorization_header' => $request->header('Authorization') ? 'present' : 'missing',
            ]);
            
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No autenticado. El token es inválido o no fue proporcionado.',
                ], 401);
            }
        });
        
        // No autorizado (authorize() retornó false en FormRequest)
        $exceptions->render(function (\Illuminate\Auth\Access\AuthorizationException $e, $request) {
            // Log detallado del error 403 de autorización
            \Log::warning('No autorizado (403) - authorize() falló', [
                'message' => $e->getMessage(),
                'user_id' => \Auth::id(),
                'user_authenticated' => \Auth::check(),
                'request_url' => $request->fullUrl(),
                'request_method' => $request->method(),
                'route_name' => $request->route()?->getName(),
                'route_action' => $request->route()?->getActionName(),
                'request_data' => $request->except(['password', 'password_confirmation', 'current_password']),
                'headers' => [
                    'content-type' => $request->header('Content-Type'),
                    'accept' => $request->header('Accept'),
                    'authorization' => $request->header('Authorization') ? 'present' : 'missing',
                ],
            ]);
            
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No tienes autorización para realizar esta acción.',
                ], 403);
            }
        });
    
        // Error de validación
        $exceptions->render(function (\Illuminate\Validation\ValidationException $e, $request) {
            // Log de errores de validación (a archivo)
            \Log::warning('Error de validación (422)', [
                'url' => $request->fullUrl(),
                'method' => $request->method(),
                'errors' => $e->errors(),
                'user_id' => \Auth::id(),
                'request_data' => $request->except(['password', 'password_confirmation', 'current_password']),
                'headers' => [
                    'content-type' => $request->header('Content-Type'),
                    'accept' => $request->header('Accept'),
                    'authorization' => $request->header('Authorization') ? 'present' : 'missing',
                ],
            ]);
            
            // ✅ NUEVO: También escribir a stderr para que aparezca en logs de Render/Docker
            $logMessage = sprintf(
                "[VALIDATION ERROR 422] %s %s - Errors: %s - User: %s - Data: %s",
                $request->method(),
                $request->fullUrl(),
                json_encode($e->errors()),
                \Auth::id() ?? 'guest',
                json_encode($request->except(['password', 'password_confirmation', 'current_password']))
            );
            error_log($logMessage);
            
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Error de validación',
                    'errors' => $e->errors(),
                ], 422);
            }
        });
    
        // Usuario no tiene permiso o rol (Spatie Permission)
        $exceptions->render(function (\Spatie\Permission\Exceptions\UnauthorizedException $e, $request) {
            // Log detallado del error 403 de permisos
            \Log::warning('Acceso denegado (403) - Sin permisos/rol', [
                'message' => $e->getMessage(),
                'user_id' => \Auth::id(),
                'user_authenticated' => \Auth::check(),
                'user_roles' => \Auth::check() ? \Auth::user()->roles->pluck('name')->toArray() : [],
                'user_permissions' => \Auth::check() ? \Auth::user()->getAllPermissions()->pluck('name')->toArray() : [],
                'request_url' => $request->fullUrl(),
                'request_method' => $request->method(),
                'route_name' => $request->route()?->getName(),
                'headers' => [
                    'authorization' => $request->header('Authorization') ? 'present' : 'missing',
                ],
            ]);
            
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No tienes permisos para realizar esta acción',
                ], 403);
            }
        });
    
        // Recurso no encontrado
        $exceptions->render(function (\Symfony\Component\HttpKernel\Exception\NotFoundHttpException $e, $request) {
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Recurso no encontrado',
                ], 404);
            }
        });
    
        // Error interno (sólo muestra el mensaje si estás en debug)
        // ✅ MEJORADO: Ocultar detalles técnicos en producción
        $exceptions->render(function (\Throwable $e, $request) {
            // Log del error antes de responder
            \Log::error('Error no manejado: ' . $e->getMessage(), [
                'exception' => get_class($e),
                'file' => $e->getFile(),
                'line' => $e->getLine(),
                'trace' => $e->getTraceAsString(),
                'request_url' => $request->fullUrl(),
                'request_method' => $request->method(),
                'request_data' => $request->except(['password', 'password_confirmation']),
            ]);
            
            if ($request->expectsJson()) {
                // En producción (APP_DEBUG=false), nunca exponer detalles técnicos
                $isDebug = config('app.debug', false);
                
                return response()->json([
                    'success' => false,
                    'message' => 'Error interno del servidor',
                    // Solo incluir detalles en desarrollo
                    ...($isDebug ? ['error' => $e->getMessage(), 'file' => $e->getFile(), 'line' => $e->getLine()] : []),
                ], 500);
            }
        });
        $exceptions->render(function (\Illuminate\Database\Eloquent\ModelNotFoundException $e, $request) {
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Recurso no encontrado',
                ], 404);
            }
        });
        
    })
    
    
    ->create();
