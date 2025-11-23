# 🔍 Guía de Diagnóstico de Errores 422

## ¿Qué es un Error 422?

Un **error 422 (Unprocessable Entity)** en Laravel significa que la petición tiene un formato válido, pero **falló la validación de datos**. Esto ocurre cuando:

- Faltan campos requeridos
- Los datos no cumplen con las reglas de validación (formato, tipo, longitud, etc.)
- Los datos no pasan las validaciones personalizadas

## 📊 Cómo Ver los Detalles del Error

### Opción 1: Ver Logs en Render (Recomendado)

Los errores de validación ahora se registran en **stderr**, que aparece en los logs de Render:

1. Ve a tu dashboard de Render
2. Selecciona el servicio `capachica-turismo-backend`
3. Abre la pestaña **"Logs"**
4. Busca líneas que contengan: `[VALIDATION ERROR 422]`

**Ejemplo de log:**
```
[VALIDATION ERROR 422] POST /api/emprendedores - Errors: {"nombre":["El campo nombre es obligatorio"]} - User: 1 - Data: {"email":"test@test.com"}
```

### Opción 2: Ver Logs de Laravel dentro del Contenedor

Si necesitas ver los logs completos de Laravel:

```bash
# Si estás ejecutando Docker localmente
docker exec -it <container_id> tail -f /var/www/html/storage/logs/laravel.log

# O ver las últimas 100 líneas
docker exec -it <container_id> tail -n 100 /var/www/html/storage/logs/laravel.log
```

### Opción 3: Ver Respuesta de la API

El error 422 incluye los detalles en la respuesta JSON:

```json
{
  "success": false,
  "message": "Error de validación",
  "errors": {
    "nombre": ["El campo nombre es obligatorio"],
    "email": ["El formato del email no es válido"]
  }
}
```

## 🔧 Endpoints Comunes que Pueden Generar 422

### 1. **POST /api/register** (Registro de usuario)
**Campos requeridos:**
- `name` (string, max:255)
- `email` (string, email, único)
- `password` (string, min:8, confirmed)

**Errores comunes:**
- Email ya existe
- Contraseña muy corta
- Contraseña sin confirmación

### 2. **POST /api/emprendedores** (Crear emprendedor)
**Campos requeridos:**
- `nombre` (string)
- `categoria` (string)
- `tipo_servicio` (string)
- `ubicacion` (string)

**Errores comunes:**
- Campos requeridos faltantes
- Formato de imágenes inválido
- IDs de relaciones inexistentes

### 3. **POST /api/reservas** (Crear reserva)
**Campos requeridos:**
- `servicios` (array, requerido)
- `servicios.*.servicio_id` (integer, existe en servicios)
- `servicios.*.fecha_inicio` (date_format:Y-m-d)
- `servicios.*.hora_inicio` (date_format:H:i:s)

**Errores comunes:**
- Array de servicios vacío
- Fechas en formato incorrecto
- IDs de servicios inexistentes

### 4. **POST /api/planes** (Crear plan)
**Campos requeridos:**
- `nombre` (string)
- `descripcion` (string)
- `capacidad` (integer, min:1)
- `duracion_dias` (integer, min:1)

**Errores comunes:**
- Capacidad menor a 1
- Duración inválida
- Fechas inconsistentes

## 🛠️ Soluciones Comunes

### Problema: "El campo X es obligatorio"
**Solución:** Asegúrate de enviar todos los campos requeridos en el body de la petición.

### Problema: "El formato del email no es válido"
**Solución:** Verifica que el email tenga formato válido (ejemplo@dominio.com).

### Problema: "El campo password debe tener al menos 8 caracteres"
**Solución:** La contraseña debe tener mínimo 8 caracteres.

### Problema: "El valor seleccionado para X no es válido"
**Solución:** El ID o valor enviado no existe en la base de datos. Verifica que el recurso exista.

### Problema: "El archivo debe ser una imagen"
**Solución:** Solo se aceptan archivos de imagen (jpg, jpeg, png, webp) y máximo 5MB.

## 📝 Ejemplo de Petición Correcta

### Crear Emprendedor (POST /api/emprendedores)

```json
{
  "nombre": "Mi Emprendimiento",
  "descripcion": "Descripción del emprendimiento",
  "categoria": "Turismo",
  "tipo_servicio": "Aventura",
  "ubicacion": "Capachica",
  "telefono": "999999999",
  "email": "emprendimiento@example.com",
  "horario_atencion": "9:00 - 18:00",
  "precio_rango": "S/. 50 - S/. 200",
  "metodos_pago": ["Efectivo", "Tarjeta"],
  "capacidad_aforo": 20,
  "estado": true
}
```

### Crear Reserva (POST /api/reservas)

```json
{
  "servicios": [
    {
      "servicio_id": 1,
      "emprendedor_id": 1,
      "fecha_inicio": "2025-12-01",
      "fecha_fin": "2025-12-01",
      "hora_inicio": "09:00:00",
      "hora_fin": "17:00:00",
      "duracion_minutos": 480,
      "cantidad": 2,
      "precio": 100.00
    }
  ]
}
```

## 🔍 Debugging Avanzado

### Ver todas las validaciones de un endpoint

1. Busca el archivo `Request` correspondiente en `app/Http/Requests/`
2. Revisa el método `rules()` para ver todas las reglas de validación

**Ejemplo:**
- `POST /api/emprendedores` → `app/Http/Requests/EmprendedorRequest.php`
- `POST /api/reservas` → `app/Http/Requests/ReservaRequest.php`
- `POST /api/register` → `app/Http/Requests/Auth/RegisterRequest.php`

### Verificar logs en tiempo real

```bash
# En Render, los logs aparecen automáticamente en la pestaña "Logs"
# Busca: [VALIDATION ERROR 422]
```

## 📞 Próximos Pasos

Si después de revisar los logs y la documentación aún no puedes resolver el error:

1. **Copia el log completo** del error 422
2. **Copia la petición** que estás enviando (sin datos sensibles)
3. **Revisa el archivo Request** correspondiente para ver las reglas de validación
4. **Compara** tu petición con los ejemplos de esta guía

## ✅ Checklist de Diagnóstico

- [ ] Revisé los logs en Render (pestaña "Logs")
- [ ] Busqué `[VALIDATION ERROR 422]` en los logs
- [ ] Verifiqué que todos los campos requeridos estén presentes
- [ ] Verifiqué que los formatos de datos sean correctos
- [ ] Verifiqué que los IDs de relaciones existan en la BD
- [ ] Comparé mi petición con los ejemplos de esta guía
- [ ] Revisé el archivo `Request` correspondiente

---

**Última actualización:** 2025-11-23
**Mejoras implementadas:** Logging mejorado a stderr para visibilidad en Render

