@echo off
echo ====================================
echo   Iniciando Servidor Laravel
echo ====================================
echo.

echo [1/3] Sincronizando fotos de perfil...
php artisan storage:sync-photos
echo.

echo [2/3] Limpiando cache...
php artisan config:clear
php artisan route:clear
echo.

echo [3/3] Iniciando servidor en http://0.0.0.0:8000
echo ====================================
echo   Servidor iniciado correctamente
echo   Presiona Ctrl+C para detener
echo ====================================
echo.

php artisan serve --host=0.0.0.0 --port=8000










