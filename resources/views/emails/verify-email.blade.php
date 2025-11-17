@component('mail::message')
@php
    $appName = config('app.name', 'TUMICRAFT');
    $teamName = env('APP_TEAM_NAME', $appName);
@endphp

# ✅ Verificación de Correo Electrónico

Hola {{ $user->name }},

¡Gracias por registrarte en **{{ $appName }}**! 🎉

Para completar tu registro y poder acceder a todos los servicios, necesitas verificar tu dirección de correo electrónico. Es muy fácil, solo haz clic en el botón de abajo:

@component('mail::button', ['url' => $verificationUrl, 'color' => 'success'])
✅ Verificar Mi Correo Electrónico
@endcomponent

**¿Por qué verifico mi email?**
- ✅ Protege tu cuenta y datos personales
- ✅ Te permite acceder a todas las funcionalidades
- ✅ Recibirás notificaciones importantes sobre tus reservas y planes

**⏱️ Tiempo de verificación:**
Tienes 60 minutos para verificar tu correo. Si el enlace expira, puedes solicitar uno nuevo desde la aplicación.

**🔒 Seguridad:**
Si no creaste esta cuenta, puedes ignorar este mensaje de forma segura.

---

**¿No funciona el botón?**
Copia y pega este enlace en tu navegador:
{{ $verificationUrl }}

---

Saludos cordiales,<br>
**Equipo de {{ $teamName }}**
@endcomponent