# 📧 Configuración de Correo Electrónico

Este documento explica cómo configurar el envío de correos electrónicos en el backend de Capachica Turismo.

## ⚠️ Problema Común

**Si los correos de verificación NO llegan después de clonar el proyecto**, es porque:

1. **El archivo `.env` NO está en el repositorio** (por seguridad)
2. **Cada desarrollador debe crear su propio `.env`** con sus credenciales de correo
3. **Por defecto, Laravel usa `MAIL_MAILER=log`**, que solo guarda correos en logs, NO los envía

**Solución**: Configura las variables de correo en tu archivo `.env` local siguiendo esta guía.

---

## 🔧 Soluciones

### Opción 1: Usar Mailtrap (Recomendado para Desarrollo)

**Mailtrap** es un servicio gratuito que captura todos los correos enviados para pruebas.

1. **Crear cuenta en Mailtrap**: https://mailtrap.io (gratis)

2. **Obtener credenciales SMTP**:
   - Ve a tu inbox en Mailtrap
   - Selecciona "SMTP Settings" → "Laravel"
   - Copia las credenciales

3. **Abre tu archivo `.env`** (si no existe, créalo copiando `ENV_EJEMPLO.txt`)

4. **Agrega o actualiza estas líneas en `.env`**:
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

5. **Limpiar cache** (MUY IMPORTANTE después de cambiar `.env`):
```bash
php artisan config:clear
```

6. **Probar el envío**:
```bash
php test_email_smtp.php tu-email@ejemplo.com
```

---

### Opción 2: Usar Gmail (Para Producción/Pruebas Reales)

**⚠️ Requisitos**: Necesitas una "Contraseña de aplicación" de Google.

1. **Habilitar verificación en 2 pasos** en tu cuenta de Google:
   - https://myaccount.google.com/security
   - Activa "Verificación en 2 pasos"

2. **Generar contraseña de aplicación**:
   - https://myaccount.google.com/apppasswords
   - Selecciona "Correo" y "Otro (nombre personalizado)"
   - Ingresa "Capachica Backend"
   - Copia la contraseña generada (16 caracteres)

3. **Abre tu archivo `.env`** (si no existe, créalo copiando `ENV_EJEMPLO.txt`)

4. **Agrega o actualiza estas líneas en `.env`**:
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

5. **Limpiar cache** (MUY IMPORTANTE después de cambiar `.env`):
```bash
php artisan config:clear
```

6. **Probar el envío**:
```bash
php test_email_smtp.php tu-email@ejemplo.com
```

---

### Opción 3: Ver Correos en Logs (Solo para Desarrollo Local)

Si solo necesitas **verificar que el correo se está generando** (sin enviarlo realmente):

1. **Abre tu archivo `.env`** y agrega:
```env
MAIL_MAILER=log
```

2. **Limpiar cache**:
```bash
php artisan config:clear
```

3. **Los correos se guardarán en**:
```
storage/logs/laravel.log
```

3. **Ver el último correo enviado**:
```bash
# Windows
type storage\logs\laravel.log | findstr /C:"Verificación de correo"

# Linux/Mac
tail -f storage/logs/laravel.log | grep "Verificación de correo"
```

**⚠️ Nota**: Con esta opción, los correos **NO se envían realmente**, solo se guardan en el log.

---

## 🧪 Probar la Configuración

Después de configurar, prueba el envío de correos:

```bash
php test_email_smtp.php tu-email@ejemplo.com
```

Si todo está bien, verás:
```
✅ Email enviado exitosamente!
Revisa tu inbox (y spam si no aparece): tu-email@ejemplo.com
```

---

## 🔍 Verificar Configuración Actual

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

## 📝 Variables de Entorno Requeridas

Asegúrate de tener estas variables en tu archivo `.env`:

```env
# Configuración de Correo
MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=tu_username
MAIL_PASSWORD=tu_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@capachica.com
MAIL_FROM_NAME="Capachica Turismo"
```

---

## 🚨 Solución de Problemas

### Error: "Connection could not be established"
- Verifica que `MAIL_HOST` y `MAIL_PORT` sean correctos
- Verifica tu conexión a internet
- Si usas Gmail, asegúrate de usar una **contraseña de aplicación**, no tu contraseña normal

### Error: "Authentication failed"
- Verifica `MAIL_USERNAME` y `MAIL_PASSWORD`
- Si usas Gmail, asegúrate de haber generado una **contraseña de aplicación**

### Los correos no llegan
- Revisa la carpeta de **spam**
- Verifica que `MAIL_FROM_ADDRESS` sea válido
- Si usas Mailtrap, revisa tu inbox en https://mailtrap.io

### Los correos van a logs pero no se envían
- Verifica que `MAIL_MAILER` no sea `log`
- Ejecuta `php artisan config:clear` después de cambiar `.env`

---

## 📚 Recursos Adicionales

- [Documentación de Laravel Mail](https://laravel.com/docs/mail)
- [Mailtrap - Servicio de Pruebas](https://mailtrap.io)
- [Gmail App Passwords](https://support.google.com/accounts/answer/185833)

