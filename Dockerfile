# Imagen base
FROM php:8.2-fpm

# Instalar dependencias del sistema + crear dirs necesarios
RUN apt-get update && apt-get install -y \
      default-mysql-client \
      libmysqlclient-dev \
      libpq-dev \
      libzip-dev \
      libpng-dev \
      libjpeg-dev \
      libfreetype6-dev \
      libonig-dev \
      libxml2-dev \
      nginx \
      supervisor \
      git \
      unzip \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip gd mbstring xml \
    && mkdir -p /run/php /var/log/supervisor /var/lib/nginx/body /run/nginx \
    && chown -R www-data:www-data /run/php /var/lib/nginx /run/nginx

# Copiar Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/local/bin/composer

# Crear directorio de trabajo
WORKDIR /var/www/html

# Copiar código y configs
COPY . .
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisord.conf

# Copiar entrypoint
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Prepara .env
RUN cp .env.example .env || true

# Instala dependencias Laravel
RUN composer install --optimize-autoloader --no-dev

# Generar clave y storage link
RUN php artisan key:generate \
 && php artisan storage:link

# Permisos finales
RUN chown -R www-data:www-data /var/www/html \
 && chmod -R 755 /var/www/html

# Exponer el puerto HTTP
EXPOSE 80

# Usuario root (Render lo usa)
USER root

# Usamos entrypoint personalizado
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
