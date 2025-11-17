@echo off
REM Script para ejecutar tests en Windows (local o Jenkins)

echo ==================================
echo Iniciando ejecucion de tests
echo ==================================

REM 1. Verificar que composer este instalado
where composer >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Composer no esta instalado
    exit /b 1
)

echo [INFO] Composer encontrado

REM 2. Instalar/actualizar dependencias
if not exist "vendor\" (
    echo [INFO] Instalando dependencias de Composer...
    call composer install --no-interaction --prefer-dist --optimize-autoloader
) else (
    echo [INFO] Actualizando dependencias de Composer...
    call composer update --no-interaction --prefer-dist --optimize-autoloader
)

REM 3. Verificar archivo .env
if not exist ".env" (
    echo [WARN] Archivo .env no encontrado, copiando desde .env.example
    copy .env.example .env
)

REM 4. Generar clave de aplicación si no existe
findstr /C:"APP_KEY=base64:" .env >nul
if %ERRORLEVEL% NEQ 0 (
    echo [INFO] Generando APP_KEY...
    php artisan key:generate --no-interaction
)

REM 5. Crear directorio para reportes de cobertura
echo [INFO] Creando directorio de coverage...
if not exist "coverage\" mkdir coverage

REM 6. Limpiar cache de tests anteriores
echo [INFO] Limpiando cache de tests...
if exist ".phpunit.cache\" rmdir /s /q .phpunit.cache

REM 7. Ejecutar Laravel Pint (code style)
if exist "vendor\bin\pint.bat" (
    echo [INFO] Ejecutando Laravel Pint...
    call vendor\bin\pint --test
)

REM 8. Ejecutar tests con PHPUnit
echo [INFO] Ejecutando tests con PHPUnit...
if defined CI (
    REM En CI/Jenkins: ejecutar con cobertura de codigo
    echo [INFO] Modo CI detectado - Ejecutando con cobertura de codigo...
    php artisan test --coverage --min=0 --coverage-clover=coverage/clover.xml --log-junit=coverage/junit.xml
) else (
    REM En desarrollo: ejecutar sin cobertura para mayor velocidad
    echo [INFO] Modo desarrollo - Ejecutando sin cobertura...
    php artisan test
)

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Los tests fallaron
    exit /b %ERRORLEVEL%
)

REM 9. Verificar que los reportes se generaron correctamente
if exist "coverage\clover.xml" (
    if exist "coverage\junit.xml" (
        echo [INFO] Reportes de cobertura generados correctamente:
        echo [INFO]   - coverage/clover.xml
        echo [INFO]   - coverage/junit.xml
    )
)

echo.
echo ==================================
echo [INFO] Tests completados exitosamente
echo ==================================

exit /b 0

