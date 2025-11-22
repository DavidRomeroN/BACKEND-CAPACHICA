#!/bin/bash

# Script para ejecutar migraciones en producción (Render)
# Este script se puede ejecutar desde Render Shell o como parte del deploy

echo "🔄 Ejecutando migraciones de base de datos..."

# Verificar que estamos en producción
if [ "$APP_ENV" != "production" ]; then
    echo "⚠️  ADVERTENCIA: APP_ENV no es 'production'"
    read -p "¿Continuar de todos modos? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Ejecutar migraciones
php artisan migrate --force

# Verificar estado
if [ $? -eq 0 ]; then
    echo "✅ Migraciones ejecutadas correctamente"
    php artisan migrate:status
else
    echo "❌ Error al ejecutar migraciones"
    exit 1
fi





