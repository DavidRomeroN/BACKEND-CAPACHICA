#!/usr/bin/env sh
set -e

echo " Ejecutando package:discover..."
php artisan package:discover --ansi || true

echo " Ejecutando migraciones..."
php artisan migrate --force || echo "⚠️  Error en migraciones (continuando...)"

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
