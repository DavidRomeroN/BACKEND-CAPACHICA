@echo off
echo ====================================
echo   VERIFICACION LOCAL - Backend Capachica
echo ====================================
echo.

echo [1/5] Verificando archivo .env...
if not exist .env (
    echo ❌ ERROR: No existe archivo .env
    echo    Crea uno basado en ENV_EJEMPLO.txt
    pause
    exit /b 1
)
echo ✅ Archivo .env existe
echo.

echo [2/5] Verificando PHP...
php --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: PHP no esta instalado o no esta en PATH
    pause
    exit /b 1
)
echo ✅ PHP instalado
echo.

echo [3/5] Verificando Composer...
composer --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Composer no esta instalado o no esta en PATH
    pause
    exit /b 1
)
echo ✅ Composer instalado
echo.

echo [4/5] Verificando dependencias...
if not exist vendor (
    echo ⚠️  ADVERTENCIA: Directorio vendor no existe
    echo    Ejecutando: composer install
    composer install
)
echo ✅ Dependencias instaladas
echo.

echo [5/5] Limpiando cache...
php artisan config:clear
php artisan route:clear
php artisan cache:clear
echo ✅ Cache limpiado
echo.

echo ====================================
echo   LISTO PARA INICIAR EL SERVIDOR
echo ====================================
echo.
echo Para iniciar el servidor local, ejecuta:
echo   start-server.bat
echo.
echo O manualmente:
echo   php artisan serve --host=0.0.0.0 --port=8000
echo.
echo El servidor estara disponible en: http://localhost:8000
echo.
pause


