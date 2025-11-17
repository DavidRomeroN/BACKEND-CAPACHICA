<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Verificado - {{ config('app.name') }}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 100%;
            padding: 40px;
            text-align: center;
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: #10b981;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }
        
        .success-icon::after {
            content: '✓';
            color: white;
            font-size: 50px;
            font-weight: bold;
        }
        
        h1 {
            color: #1f2937;
            font-size: 28px;
            margin-bottom: 15px;
        }
        
        p {
            color: #6b7280;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        
        .info-box {
            background: #f3f4f6;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .info-box h2 {
            color: #374151;
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        .info-box p {
            color: #6b7280;
            font-size: 14px;
            margin: 0;
        }
        
        .button {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            margin-top: 20px;
            transition: transform 0.2s;
        }
        
        .button:hover {
            transform: translateY(-2px);
        }
        
        .footer {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
            color: #9ca3af;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon"></div>
        
        @if(isset($success) && $success)
            <h1>¡Email Verificado! ✅</h1>
            
            <p>
                Tu correo electrónico ha sido verificado correctamente. 
                Ya puedes acceder a todas las funcionalidades de <strong>{{ config('app.name') }}</strong>.
            </p>
            
            <div class="info-box">
                <h2>📱 Próximos pasos:</h2>
                <p>
                    Esta ventana se cerrará automáticamente. Vuelve a la aplicación móvil y podrás iniciar sesión sin problemas.
                </p>
            </div>
            <script>
                // Intentar redirigir a un deep link si existe
                (function() {
                    var deepLink = "{{ env('APP_DEEPLINK_URL', '') }}";
                    if (deepLink) {
                        try { window.location.href = deepLink; } catch(e) {}
                    }
                    // Como fallback, intentar cerrar la ventana si el navegador lo permite
                    setTimeout(function(){ try { window.close(); } catch(e) {} }, 1500);
                })();
            </script>
        @else
            <div class="success-icon" style="background: #ef4444;">
                <style>
                    .success-icon::after {
                        content: '✗';
                    }
                </style>
            </div>
            
            <h1>Error al Verificar ❌</h1>
            
            <p>
                {{ $message ?? 'El enlace de verificación no es válido o ha expirado.' }}
            </p>
            
            <div class="info-box">
                <h2>💡 ¿Qué hacer?</h2>
                <p>
                    Vuelve a la aplicación móvil y solicita un nuevo enlace de verificación.
                </p>
            </div>
        @endif
        
        <div class="footer">
            <p>© {{ date('Y') }} {{ config('app.name') }}. Todos los derechos reservados.</p>
        </div>
    </div>
</body>
</html>

