#!/usr/bin/env bash
set -e

echo "==> Entrypoint: starting..."

# 0) Asegura permisos básicos (por si Render monta algo raro)
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache || true
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache || true

# 1) Limpia caches viejos (muy importante para que no use .env local cacheado)
echo "==> Clearing caches..."
php artisan config:clear || true
php artisan cache:clear || true
php artisan route:clear || true
php artisan view:clear || true

# 2) Espera a Postgres (Free a veces tarda en responder)
echo "==> Waiting for DB..."
php -r '
$tries=30;
$url=getenv("DATABASE_URL");
$host=getenv("DB_HOST");
$port=getenv("DB_PORT") ?: 5432;
$db=getenv("DB_DATABASE");
$user=getenv("DB_USERNAME");
$pass=getenv("DB_PASSWORD");

$dsn = $url ?: "pgsql:host=$host;port=$port;dbname=$db";

while($tries--){
  try {
    new PDO($dsn, $user, $pass);
    echo "DB ready\n"; exit(0);
  } catch(Exception $e){
    echo "DB not ready, retrying...\n";
    sleep(2);
  }
}
echo "DB never became ready\n"; exit(1);
'

# 3) Corre migraciones en producción
echo "==> Running migrations..."
php artisan migrate --force

# 4) Cachea config/rutas/vistas ya con envs correctas
echo "==> Caching config/routes/views..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 5) Levanta supervisor (php-fpm + nginx)
echo "==> Starting supervisord..."
exec /usr/bin/supervisord -c /etc/supervisord.conf
