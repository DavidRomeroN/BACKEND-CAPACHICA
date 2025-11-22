# 🚀 Guía de Configuración Inicial

Esta guía te ayudará a configurar el proyecto después de clonarlo desde GitHub.

## 📋 Requisitos Previos

- PHP 8.1 o superior
- Composer
- MySQL o MariaDB
- Node.js y NPM (opcional, para assets)

## 🔧 Pasos de Instalación

### 1. Instalar Dependencias

```bash
composer install
```

### 2. Configurar Variables de Entorno

**⚠️ CRÍTICO**: El archivo `.env` NO está en el repositorio (por seguridad). Debes crearlo manualmente.

**Opción A**: Si existe `ENV_EJEMPLO.txt` en el repositorio:
```bash
# Windows
copy ENV_EJEMPLO.txt .env

# Linux/Mac
cp ENV_EJEMPLO.txt .env
```

**Opción B**: Crea un archivo `.env` manualmente con las siguientes variables mínimas:

```env
APP_NAME="Capachica Turismo"
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost:8000

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=capachica_turismo
DB_USERNAME=root
DB_PASSWORD=tu_password

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=tu_username
MAIL_PASSWORD=tu_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@capachica.com
MAIL_FROM_NAME="${APP_NAME}"
```

### 3. Generar Clave de Aplicación

```bash
php artisan key:generate
```

### 4. Configurar Base de Datos

1. Crea la base de datos en MySQL:
```sql
CREATE DATABASE capachica_turismo;
```

2. Actualiza las credenciales en `.env`:
```env
DB_DATABASE=capachica_turismo
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_password
```

3. Ejecuta las migraciones:
```bash
php artisan migrate
```

4. (Opcional) Ejecuta los seeders:
```bash
php artisan db:seed
```

### 5. Configurar Correo Electrónico ⚠️ CRÍTICO

**🚨 PROBLEMA COMÚN**: Si los correos de verificación NO llegan, es porque **falta configurar el correo en `.env`**.

El archivo `.env` NO se sube a GitHub por seguridad, por lo que cada desarrollador debe configurar su propio correo.

**Pasos para configurar correo**:

1. **Abre tu archivo `.env`** que acabas de crear

2. **Elige una opción**:

   **Opción A: Mailtrap (Recomendado para desarrollo)**
   - Crea cuenta gratis en: https://mailtrap.io
   - Ve a tu inbox → "SMTP Settings" → "Laravel"
   - Copia las credenciales y pégalas en `.env`:
   ```env
   MAIL_MAILER=smtp
   MAIL_HOST=smtp.mailtrap.io
   MAIL_PORT=2525
   MAIL_USERNAME=tu_username_de_mailtrap
   MAIL_PASSWORD=tu_password_de_mailtrap
   MAIL_ENCRYPTION=tls
   MAIL_FROM_ADDRESS=noreply@capachica.com
   MAIL_FROM_NAME="${APP_NAME}"
   ```

   **Opción B: Gmail (Para pruebas reales)**
   - Habilita verificación en 2 pasos: https://myaccount.google.com/security
   - Genera contraseña de aplicación: https://myaccount.google.com/apppasswords
   - Configura en `.env`:
   ```env
   MAIL_MAILER=smtp
   MAIL_HOST=smtp.gmail.com
   MAIL_PORT=587
   MAIL_USERNAME=tu-email@gmail.com
   MAIL_PASSWORD=tu_contraseña_de_aplicación_16_caracteres
   MAIL_ENCRYPTION=tls
   MAIL_FROM_ADDRESS=tu-email@gmail.com
   MAIL_FROM_NAME="${APP_NAME}"
   ```

3. **Después de configurar, limpia el cache**:
   ```bash
   php artisan config:clear
   ```

4. **Prueba el envío de correos**:
   ```bash
   php test_email_smtp.php tu-email@ejemplo.com
   ```

**Ver la guía completa en**: **[CONFIGURACION_EMAIL.md](./CONFIGURACION_EMAIL.md)**

### 6. Crear Enlace Simbólico de Storage

```bash
php artisan storage:link
```

### 7. Limpiar Cache

```bash
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear
```

### 8. Iniciar el Servidor

```bash
# Windows
start-server.bat

# Linux/Mac
php artisan serve --host=0.0.0.0 --port=8000
```

El servidor estará disponible en: `http://localhost:8000`

---

## 🧪 Verificar que Todo Funciona

### Probar el Envío de Correos

```bash
php test_email_smtp.php tu-email@ejemplo.com
```

Si todo está bien, deberías recibir un correo de prueba.

### Verificar la API

Abre en tu navegador:
- `http://localhost:8000` - Página de bienvenida
- `http://localhost:8000/api` - Documentación de la API (si está configurada)

---

## 📧 Problema Común: Correos No Llegan

Si después de clonar el proyecto los correos de verificación **no llegan**, es porque:

1. **No está configurado el servicio de correo** en `.env`
2. Por defecto, Laravel usa `MAIL_MAILER=log`, que solo guarda correos en logs

**Solución**: 
- Lee **[CONFIGURACION_EMAIL.md](./CONFIGURACION_EMAIL.md)** para configurar correo
- O verifica los logs en `storage/logs/laravel.log` si usas `MAIL_MAILER=log`

---

## 🔍 Verificar Configuración

Para ver qué configuración está usando Laravel:

```bash
php artisan tinker
```

Luego ejecuta:
```php
config('mail.default')
config('mail.mailers.smtp.host')
config('mail.from.address')
```

---

## 📚 Documentación Adicional

- **[CONFIGURACION_EMAIL.md](./CONFIGURACION_EMAIL.md)** - Configuración detallada de correo
- **[README.md](./README.md)** - Información general del proyecto

---

## 🆘 Solución de Problemas

### Error: "No application encryption key has been specified"
```bash
php artisan key:generate
```

### Error: "SQLSTATE[HY000] [1045] Access denied"
- Verifica las credenciales de la base de datos en `.env`
- Asegúrate de que MySQL esté corriendo

### Error: "Class 'PDO' not found"
- Instala la extensión PDO de PHP
- En Windows: Descomenta `extension=pdo_mysql` en `php.ini`

### Los correos no se envían
- Verifica la configuración en `.env`
- Lee **[CONFIGURACION_EMAIL.md](./CONFIGURACION_EMAIL.md)**
- Ejecuta `php artisan config:clear` después de cambiar `.env`

---

## ✅ Checklist de Configuración

- [ ] Dependencias instaladas (`composer install`)
- [ ] Archivo `.env` creado y configurado
- [ ] Clave de aplicación generada (`php artisan key:generate`)
- [ ] Base de datos creada y migraciones ejecutadas
- [ ] Correo electrónico configurado (ver CONFIGURACION_EMAIL.md)
- [ ] Enlace simbólico de storage creado
- [ ] Cache limpiado
- [ ] Servidor iniciado y funcionando
- [ ] Correo de prueba enviado exitosamente

