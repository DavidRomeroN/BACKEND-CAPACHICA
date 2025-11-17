#!/bin/bash
# Script para ejecutar tests en Jenkins o local

set -e

echo "=================================="
echo "Iniciando ejecución de tests"
echo "=================================="

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir con color
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 1. Verificar que composer esté instalado
if ! command -v composer &> /dev/null; then
    print_error "Composer no está instalado"
    exit 1
fi

print_info "Composer encontrado: $(composer --version)"

# 2. Instalar dependencias si no existen
if [ ! -d "vendor" ]; then
    print_info "Instalando dependencias de Composer..."
    composer install --no-interaction --prefer-dist --optimize-autoloader
else
    print_info "Actualizando dependencias de Composer..."
    composer update --no-interaction --prefer-dist --optimize-autoloader
fi

# 3. Verificar archivo .env
if [ ! -f ".env" ]; then
    print_warn "Archivo .env no encontrado, copiando desde .env.example"
    cp .env.example .env
fi

# 4. Generar clave de aplicación si no existe
if ! grep -q "APP_KEY=base64:" .env; then
    print_info "Generando APP_KEY..."
    php artisan key:generate --no-interaction
fi

# 5. Crear directorio para reportes de cobertura
print_info "Creando directorio de coverage..."
mkdir -p coverage

# 6. Limpiar caché de tests anteriores
print_info "Limpiando caché de tests..."
if [ -d ".phpunit.cache" ]; then
    rm -rf .phpunit.cache
fi

# 7. Ejecutar análisis de código con PHP CS Fixer (opcional)
if command -v php-cs-fixer &> /dev/null; then
    print_info "Ejecutando PHP CS Fixer..."
    php-cs-fixer fix --dry-run --diff --verbose || true
fi

# 8. Ejecutar Laravel Pint (code style)
if [ -f "vendor/bin/pint" ]; then
    print_info "Ejecutando Laravel Pint..."
    vendor/bin/pint --test || print_warn "Pint encontró problemas de estilo"
fi

# 9. Ejecutar tests con PHPUnit
print_info "Ejecutando tests con PHPUnit..."
if [ "$CI" = "true" ] || [ "$JENKINS_HOME" != "" ]; then
    # En CI/Jenkins: ejecutar con cobertura de código
    print_info "Modo CI detectado - Ejecutando con cobertura de código..."
    php artisan test --coverage --min=0 --coverage-clover=coverage/clover.xml --log-junit=coverage/junit.xml
else
    # En desarrollo: ejecutar sin cobertura para mayor velocidad
    print_info "Modo desarrollo - Ejecutando sin cobertura..."
    php artisan test
fi

# 10. Verificar que los reportes se generaron correctamente
if [ -f "coverage/clover.xml" ] && [ -f "coverage/junit.xml" ]; then
    print_info "Reportes de cobertura generados correctamente:"
    print_info "  - coverage/clover.xml"
    print_info "  - coverage/junit.xml"
else
    print_warn "Algunos reportes de cobertura no se generaron"
fi

# 11. Mostrar resumen de cobertura (si existe)
if [ -f "coverage/clover.xml" ]; then
    print_info "Procesando resultados de cobertura..."
    # Parsear XML para obtener estadísticas básicas
    if command -v xmllint &> /dev/null; then
        total_elements=$(xmllint --xpath "string(//metrics/@elements)" coverage/clover.xml 2>/dev/null || echo "0")
        covered_elements=$(xmllint --xpath "string(//metrics/@coveredelements)" coverage/clover.xml 2>/dev/null || echo "0")
        if [ "$total_elements" != "0" ]; then
            coverage_percent=$(awk "BEGIN {printf \"%.2f\", ($covered_elements/$total_elements)*100}")
            print_info "Cobertura de código: ${coverage_percent}%"
        fi
    fi
fi

echo ""
echo "=================================="
print_info "Tests completados exitosamente"
echo "=================================="

exit 0

