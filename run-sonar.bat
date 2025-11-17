@echo off
REM Script para ejecutar analisis de SonarQube localmente o en Jenkins

echo ==================================
echo Iniciando analisis de SonarQube
echo ==================================

REM 1. Verificar que existan los reportes de coverage
if not exist "coverage\clover.xml" (
    echo [WARN] No se encontro el reporte de cobertura coverage\clover.xml
    echo [INFO] Ejecutando tests primero para generar reportes...
    
    if exist "run-tests.bat" (
        call run-tests.bat
    ) else (
        echo [ERROR] No se encontro el script run-tests.bat
        exit /b 1
    )
)

REM 2. Verificar que sonar-scanner este instalado
where sonar-scanner >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] sonar-scanner no esta instalado
    echo [INFO] Descarga desde: https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/
    exit /b 1
)

echo [INFO] sonar-scanner encontrado

REM 3. Verificar que exista el archivo de configuracion
if not exist "sonar-project.properties" (
    echo [ERROR] No se encontro el archivo sonar-project.properties
    exit /b 1
)

REM 4. Leer configuracion de SonarQube desde variables de entorno o usar defaults
if not defined SONAR_HOST_URL set SONAR_HOST_URL=http://docker.sonar:9000
if not defined SONAR_TOKEN (
    echo [WARN] SONAR_TOKEN no esta configurado
    echo [INFO] Se usara la configuracion del archivo sonar-project.properties
)

REM 5. Mostrar informacion del proyecto
for /f "tokens=2 delims==" %%a in ('findstr "sonar.projectKey=" sonar-project.properties') do set PROJECT_KEY=%%a
for /f "tokens=2 delims==" %%a in ('findstr "sonar.projectVersion=" sonar-project.properties') do set PROJECT_VERSION=%%a

echo [INFO] Proyecto: %PROJECT_KEY%
echo [INFO] Version: %PROJECT_VERSION%
echo [INFO] Host SonarQube: %SONAR_HOST_URL%

REM 6. Ejecutar sonar-scanner
echo [INFO] Ejecutando analisis de SonarQube...

if defined SONAR_TOKEN (
    REM Con token de autenticacion
    sonar-scanner -Dsonar.host.url=%SONAR_HOST_URL% -Dsonar.login=%SONAR_TOKEN%
) else (
    REM Sin token usar configuracion del archivo
    sonar-scanner
)

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] El analisis de SonarQube fallo
    exit /b %ERRORLEVEL%
)

REM 7. Verificar resultado
echo.
echo [INFO] Analisis de SonarQube completado exitosamente
echo [INFO] Revisa los resultados en: %SONAR_HOST_URL%/dashboard?id=turismo-backend

echo ==================================
echo [INFO] Proceso completado
echo ==================================

exit /b 0

