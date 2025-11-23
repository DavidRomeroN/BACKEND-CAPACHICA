# ⚡ Instrucciones Rápidas para Nuevos Desarrolladores

Si acabas de clonar el proyecto y los **correos de verificación NO llegan**, sigue estos pasos:

## 🚨 Problema: Correos No Llegan

**Causa**: El archivo `.env` NO está en GitHub (por seguridad). Cada desarrollador debe configurar su propio correo.

## ✅ Solución Rápida (5 minutos)

### Paso 1: Crear archivo `.env`

```bash
# Si existe ENV_EJEMPLO.txt:
copy ENV_EJEMPLO.txt .env

# O crea .env manualmente
```

### Paso 2: Configurar Correo (Elige una opción)

#### Opción A: Mailtrap (Más fácil, recomendado)

1. Ve a https://mailtrap.io y crea cuenta gratis
2. Ve a tu inbox → "SMTP Settings" → "Laravel"
3. Copia las credenciales
4. Abre tu `.env` y pega esto (reemplaza con tus credenciales):

```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=tu_username_de_mailtrap
MAIL_PASSWORD=tu_password_de_mailtrap
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@capachica.com
MAIL_FROM_NAME="Capachica Turismo"
```

#### Opción B: Gmail

1. Habilita verificación en 2 pasos: https://myaccount.google.com/security
2. Genera contraseña de aplicación: https://myaccount.google.com/apppasswords
3. Abre tu `.env` y pega esto:

```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=tu-email@gmail.com
MAIL_PASSWORD=tu_contraseña_de_aplicación
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=tu-email@gmail.com
MAIL_FROM_NAME="Capachica Turismo"
```

### Paso 3: Limpiar Cache (MUY IMPORTANTE)

```bash
php artisan config:clear
```

### Paso 4: Probar

```bash
php test_email_smtp.php tu-email@ejemplo.com
```

Si ves "✅ Email enviado exitosamente!", ¡está funcionando!

---

## 📚 Documentación Completa

- **[SETUP.md](./SETUP.md)** - Configuración completa del proyecto
- **[CONFIGURACION_EMAIL.md](./CONFIGURACION_EMAIL.md)** - Guía detallada de correo

---

## ❓ ¿Aún no funciona?

1. **Verifica que `.env` existe** en la raíz del proyecto
2. **Verifica que las credenciales son correctas** (sin espacios extra)
3. **Ejecuta `php artisan config:clear`** después de cada cambio en `.env`
4. **Revisa los logs**: `storage/logs/laravel.log`
5. **Prueba con Mailtrap primero** (es más fácil de configurar)








