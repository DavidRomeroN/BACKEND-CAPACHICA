#!/usr/bin/env sh
set -e

echo " Ejecutando package:discover..."
php artisan package:discover --ansi || true

echo " Ejecutando migraciones..."
php artisan migrate --force || echo "⚠️  Error en migraciones (continuando...)"

# ✅ Ejecutar seeders para crear roles, permisos y datos iniciales
echo "🌱 Ejecutando seeders (roles, permisos, etc)..."
php artisan db:seed --force || echo "⚠️  Error en seeders (continuando...)"

# ✅ Asegurar que el rol admin tenga TODOS los permisos (por si el seeder falló parcialmente)
echo "🔐 Verificando permisos del rol admin..."
php artisan tinker --execute="
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
try {
    \$adminRole = Role::where('name', 'admin')->where('guard_name', 'web')->first();
    if (\$adminRole && Permission::count() > 0) {
        // Asegurar que el rol admin tenga TODOS los permisos existentes
        \$adminRole->syncPermissions(Permission::all());
        echo '✅ Permisos del rol admin verificados (' . Permission::count() . ' permisos)';
    } else {
        echo '⚠️  Rol admin o permisos no encontrados';
    }
} catch (\Exception \$e) {
    echo '⚠️  Error verificando permisos: ' . \$e->getMessage();
}
" || echo "⚠️  Error verificando permisos (continuando...)"

# 🧹 Limpiar cache de permisos para asegurar que los cambios se reflejen
echo "🧹 Limpiando cache de permisos..."
php artisan tinker --execute="
try {
    app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
    echo '✅ Cache de permisos limpiado correctamente';
} catch (\Exception \$e) {
    echo '⚠️  Error limpiando cache de permisos: ' . \$e->getMessage();
}
" || echo "⚠️  Error limpiando cache de permisos (continuando...)"
php artisan cache:clear || echo "⚠️  Error limpiando cache general (continuando...)"

# 🔧 TEMPORAL: Re-asignar rol admin al usuario ID 7 usando métodos de Spatie
echo "🔧 Re-asignando rol admin al usuario ID 7..."
php artisan tinker --execute="
use App\Models\User;
use Spatie\Permission\Models\Role;
try {
    app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
    \$user = User::find(7);
    if (\$user) {
        // Remover todos los roles existentes
        \$user->roles()->detach();
        // Asignar el rol admin usando Spatie (esto es lo correcto)
        \$user->assignRole('admin');
        echo '✅ Rol admin re-asignado correctamente al usuario ID 7';
    } else {
        echo '⚠️  Usuario ID 7 no encontrado';
    }
} catch (\Exception \$e) {
    echo '⚠️  Error re-asignando rol: ' . \$e->getMessage();
}
" || echo "⚠️  Error re-asignando rol (continuando...)"

echo "⚡ Optimizando configuración..."
php artisan config:cache || echo "⚠️  Error en config:cache (continuando...)"
php artisan route:cache || echo "⚠️  Error en route:cache (continuando...)"
php artisan view:cache || echo "⚠️  Error en view:cache (continuando...)"

# Crear directorios de logs si no existen
mkdir -p /var/www/html/storage/logs
chmod -R 775 /var/www/html/storage/logs
chown -R www-data:www-data /var/www/html/storage/logs

echo "✅ Servidor listo para recibir peticiones"

echo " Iniciando supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
