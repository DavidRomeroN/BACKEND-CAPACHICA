# 🔧 Guía para Probar el Backend Localmente

Esta guía te ayudará a ejecutar y probar el backend localmente para comparar con el comportamiento en la nube (Render).

## 📋 Requisitos Previos

1. **PHP 8.2+** instalado
2. **Composer** instalado
3. **Base de datos** (MySQL o PostgreSQL) configurada
4. Archivo **.env** configurado

## 🚀 Pasos para Iniciar el Servidor Local

### 1. Verificar Configuración

Ejecuta el script de verificación:

```bash
test-local.bat
```

Este script verifica:
- ✅ Archivo .env existe
- ✅ PHP está instalado
- ✅ Composer está instalado
- ✅ Dependencias están instaladas
- ✅ Cache está limpiado

### 2. Configurar Base de Datos

Asegúrate de que tu archivo `.env` tenga la configuración correcta:

```env
DB_CONNECTION=mysql  # o pgsql para PostgreSQL
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=tu_base_de_datos
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_contraseña
```

### 3. Ejecutar Migraciones

```bash
php artisan migrate
```

Si necesitas datos de prueba:

```bash
php artisan db:seed
```

### 4. Iniciar el Servidor

Ejecuta el script de inicio:

```bash
start-server.bat
```

O manualmente:

```bash
php artisan serve --host=0.0.0.0 --port=8000
```

El servidor estará disponible en: **http://localhost:8000**

## 🧪 Probar Endpoints

### Endpoint Básico (Sin autenticación)

```bash
curl http://localhost:8000/api
```

Debería retornar: `{"status":"ok"}`

### Endpoint de Login

```bash
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d "{\"email\":\"tu_email@ejemplo.com\",\"password\":\"tu_contraseña\"}"
```

### Endpoint Autenticado (Ejemplo: Crear Plan)

```bash
curl -X POST http://localhost:8000/api/planes \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer TU_TOKEN_AQUI" \
  -d "{\"nombre\":\"Plan Test\",\"descripcion\":\"Descripcion\",\"capacidad\":10,\"duracion_dias\":3}"
```

## 🔍 Ver Logs en Tiempo Real

Mientras el servidor está corriendo, puedes ver los logs en otra terminal:

### Windows PowerShell:
```powershell
Get-Content storage\logs\laravel.log -Wait -Tail 50
```

### Windows CMD:
```cmd
tail -f storage\logs\laravel.log
```

O simplemente abre el archivo:
```
storage\logs\laravel.log
```

## 📊 Comparar con la Nube

### Endpoints de Prueba

1. **Local**: `http://localhost:8000/api`
2. **Nube**: `https://backend-capachica-nphb.onrender.com/api`

### Verificar Diferencias

Cuando pruebes localmente, busca en los logs:
- ✅ `storage\logs\laravel.log` para errores de Laravel
- ✅ Mensajes de error 403, 422, 500 con detalles
- ✅ Información de autenticación/autorización
- ✅ Datos de validación recibidos

### Errores Comunes al Probar Localmente

1. **Error: "No autenticado (401)"**
   - Verifica que el token esté siendo enviado
   - Verifica el formato: `Authorization: Bearer {token}`
   - Verifica que el token no haya expirado

2. **Error: "No autorizado (403)"**
   - Verifica que el usuario tenga los permisos necesarios
   - Revisa los logs para ver qué condición falló

3. **Error: "Error de validación (422)"**
   - Revisa los logs para ver qué campos fallan
   - Verifica el formato de los datos enviados

4. **Error: "Error interno del servidor (500)"**
   - Activa el modo debug: `APP_DEBUG=true` en `.env`
   - Revisa los logs para ver el stack trace completo

## 🔧 Activar Modo Debug

Para ver más detalles de los errores, edita `.env`:

```env
APP_DEBUG=true
APP_ENV=local
LOG_LEVEL=debug
```

## 📝 Notas Importantes

- Los logs mejorados que agregamos mostrarán información detallada sobre cada error
- Compara los logs locales con los logs de Render para identificar diferencias
- Si funciona localmente pero no en la nube, puede ser un problema de:
  - Variables de entorno diferentes
  - Permisos de base de datos
  - Configuración de CORS
  - Configuración de SSL/HTTPS

## 🆘 Solución de Problemas

Si encuentras problemas, verifica:

1. **Base de datos conectada**: `php artisan db:show`
2. **Cache limpio**: `php artisan config:clear && php artisan route:clear`
3. **Permisos de storage**: `php artisan storage:link`
4. **Variables de entorno**: Verifica que `.env` tenga todos los valores necesarios


