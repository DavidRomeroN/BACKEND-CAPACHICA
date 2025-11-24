#!/usr/bin/env sh
set -e

echo " Ejecutando package:discover..."
php artisan package:discover --ansi || true

echo " Ejecutando migraciones..."
php artisan migrate --force || echo "⚠️  Error en migraciones (continuando...)"

# ✅ Asegurar que los roles básicos existan (crítico para el funcionamiento)
echo "🔐 Verificando roles básicos..."
php artisan tinker --execute="
use Spatie\Permission\Models\Role;
try {
    Role::firstOrCreate(['name' => 'admin', 'guard_name' => 'web']);
    Role::firstOrCreate(['name' => 'user', 'guard_name' => 'web']);
    Role::firstOrCreate(['name' => 'emprendedor', 'guard_name' => 'web']);
    Role::firstOrCreate(['name' => 'moderador', 'guard_name' => 'web']);
    echo '✅ Roles verificados/creados correctamente';
} catch (\Exception \$e) {
    echo '⚠️  Error verificando roles: ' . \$e->getMessage();
}
" || echo "⚠️  Error verificando roles (continuando...)"

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
