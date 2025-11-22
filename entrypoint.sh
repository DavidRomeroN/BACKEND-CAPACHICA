#!/usr/bin/env sh
set -e

echo "==> Rendering nginx.conf with PORT=$PORT"
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

echo " Ejecutando package:discover..."
php artisan package:discover --ansi || true

echo " Ejecutando migraciones..."
php artisan migrate --force || true

echo "⚡ Optimizando configuración..."
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

echo " Iniciando supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
