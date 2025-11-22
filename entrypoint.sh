#!/usr/bin/env sh
set -e

echo " Ejecutando migraciones..."
php artisan migrate --force || true

echo "⚡ Optimizando configuración..."
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

echo " Iniciando supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
