FROM php:8.2-fpm

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
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip gd mbstring xml \
    && mkdir -p /run/php /var/log/supervisor /var/lib/nginx/body /run/nginx \
    && chown -R www-data:www-data /run/php /var/lib/nginx /run/nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2.6 /usr/bin/composer /usr/local/bin/composer
WORKDIR /var/www/html

COPY . .
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisord.conf

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN cp .env.example .env || true
RUN composer install --optimize-autoloader --no-dev

RUN php artisan storage:link || true

RUN chown -R www-data:www-data /var/www/html \
 && chmod -R 755 /var/www/html

EXPOSE 80
USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
