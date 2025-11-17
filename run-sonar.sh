#!/bin/bash
# Script para ejecutar análisis de SonarQube localmente o en Jenkins

set -e

echo "=================================="
echo "Iniciando análisis de SonarQube"
echo "=================================="

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 1. Verificar que existan los reportes de coverage
if [ ! -f "coverage/clover.xml" ]; then
    print_warn "No se encontró el reporte de cobertura (coverage/clover.xml)"
    print_info "Ejecutando tests primero para generar reportes..."
    
    if [ -f "run-tests.sh" ]; then
        bash run-tests.sh
    else
        print_error "No se encontró el script run-tests.sh"
        exit 1
    fi
fi

# 2. Verificar que sonar-scanner esté instalado
if ! command -v sonar-scanner &> /dev/null; then
    print_error "sonar-scanner no está instalado"
    print_info "Descarga desde: https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/"
    exit 1
fi

print_info "sonar-scanner encontrado: $(sonar-scanner --version | head -n 1)"

# 3. Verificar que exista el archivo de configuración
if [ ! -f "sonar-project.properties" ]; then
    print_error "No se encontró el archivo sonar-project.properties"
    exit 1
fi

# 4. Leer configuración de SonarQube desde variables de entorno o usar defaults
SONAR_HOST_URL=${SONAR_HOST_URL:-"http://docker.sonar:9000"}
SONAR_TOKEN=${SONAR_TOKEN:-""}

if [ -z "$SONAR_TOKEN" ]; then
    print_warn "SONAR_TOKEN no está configurado"
    print_info "Se usará la configuración del archivo sonar-project.properties"
fi

# 5. Mostrar información del proyecto
print_info "Proyecto: $(grep 'sonar.projectKey=' sonar-project.properties | cut -d'=' -f2)"
print_info "Versión: $(grep 'sonar.projectVersion=' sonar-project.properties | cut -d'=' -f2)"
print_info "Host SonarQube: $SONAR_HOST_URL"

# 6. Ejecutar sonar-scanner
print_info "Ejecutando análisis de SonarQube..."

if [ -n "$SONAR_TOKEN" ]; then
    # Con token de autenticación
    sonar-scanner \
        -Dsonar.host.url="$SONAR_HOST_URL" \
        -Dsonar.login="$SONAR_TOKEN"
else
    # Sin token (usar configuración del archivo)
    sonar-scanner
fi

# 7. Verificar resultado
if [ $? -eq 0 ]; then
    echo ""
    print_info "Análisis de SonarQube completado exitosamente"
    print_info "Revisa los resultados en: ${SONAR_HOST_URL}/dashboard?id=turismo-backend"
else
    print_error "El análisis de SonarQube falló"
    exit 1
fi

echo "=================================="
print_info "Proceso completado"
echo "=================================="

exit 0

