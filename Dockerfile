FROM php:8.2-fpm

# ===== INSTALAR DEPENDENCIAS DEL SISTEMA =====
RUN apt-get update && apt-get install -y \
      mariadb-client \
      default-libmysqlclient-dev \
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
      gettext-base \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip gd mbstring xml \
    && mkdir -p /run/php /var/log/supervisor /var/lib/nginx/body /run/nginx \
    && chown -R www-data:www-data /run/php /var/lib/nginx /run/nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# ===== COPIAR COMPOSER =====
COPY --from=composer:2.6 /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

# ===== COPIAR ARCHIVOS DEL PROYECTO =====
COPY . .

# ===== CONFIGURACIÓN DE NGINX =====
# Usaremos SOLO nginx.conf.template, Render lo procesará con envsubst
COPY ./nginx.conf.template /etc/nginx/nginx.conf.template

# ===== CONFIGURACIÓN DE SUPERVISORD =====
COPY ./supervisord.conf /etc/supervisord.conf

# ===== ENTRYPOINT =====
COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# ===== INSTALAR DEPENDENCIAS PHP =====
RUN cp .env.example .env || true
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress

# ===== ENLACE A STORAGE =====
RUN php artisan storage:link || true

# ===== PERMISOS =====
RUN chown -R www-data:www-data /var/www/html \
 && chmod -R 755 /var/www/html

# ===== EXPONER PUERTO (Render asigna $PORT dinámico) =====
EXPOSE 80

USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
