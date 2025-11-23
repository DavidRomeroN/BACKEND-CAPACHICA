@echo off
echo ====================================
echo   PRUEBA DE CONEXION DEL BACKEND
echo ====================================
echo.
echo Probando endpoints del backend local...
echo.

echo [1] Probando GET http://localhost:8000/api
curl -X GET http://localhost:8000/api -v
echo.
echo.

echo [2] Probando GET http://127.0.0.1:8000/api
curl -X GET http://127.0.0.1:8000/api -v
echo.
echo.

echo [3] Probando desde la perspectiva del emulador (10.0.2.2:8000)
echo NOTA: Esto solo funciona desde dentro del emulador
echo.
echo Si estas usando el emulador, la URL correcta es: http://10.0.2.2:8000
echo.
pause


