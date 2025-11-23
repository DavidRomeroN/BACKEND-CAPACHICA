@echo off
echo ====================================
echo   PRUEBA DE ENDPOINT LOCAL
echo ====================================
echo.
echo Este script probara el endpoint /api para verificar
echo que el servidor local esta funcionando correctamente
echo.
echo Presiona cualquier tecla para continuar...
pause >nul
echo.

echo Probando GET /api...
curl -X GET http://localhost:8000/api -H "Accept: application/json" -v
echo.
echo.

echo Si ves {"status":"ok"} el servidor esta funcionando correctamente
echo.
echo Para probar endpoints autenticados, necesitaras:
echo 1. Iniciar sesion con POST /api/login
echo 2. Obtener el token de la respuesta
echo 3. Usar el token en el header: Authorization: Bearer {token}
echo.
pause


