#!/bin/bash

# Script para verificar que el backend está funcionando correctamente
# Útil después de actualizar el backend

BASE_URL="${1:-https://capachica-turismo-backend.onrender.com}"

echo "🔍 Verificando backend en: $BASE_URL"
echo ""

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para verificar endpoint
check_endpoint() {
    local endpoint=$1
    local name=$2
    
    echo -n "Verificando $name... "
    response=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL$endpoint")
    
    if [ "$response" = "200" ] || [ "$response" = "401" ]; then
        echo -e "${GREEN}✓${NC} (HTTP $response)"
        return 0
    else
        echo -e "${RED}✗${NC} (HTTP $response)"
        return 1
    fi
}

# Verificar endpoints principales
echo "📡 Endpoints de API:"
check_endpoint "/api/emprendedores" "Emprendedores"
check_endpoint "/api/eventos" "Eventos"
check_endpoint "/api/planes" "Planes"
check_endpoint "/api/servicios" "Servicios"
check_endpoint "/api/asociaciones" "Asociaciones"

echo ""
echo "🔐 Endpoints de Autenticación:"
check_endpoint "/api/login" "Login"
check_endpoint "/api/register" "Register"

echo ""
echo "📊 Verificando salud del servidor..."
health=$(curl -s "$BASE_URL/api/health" 2>/dev/null || echo "ERROR")

if [ "$health" != "ERROR" ]; then
    echo -e "${GREEN}✓${NC} Servidor respondiendo"
else
    echo -e "${YELLOW}⚠${NC}  Endpoint /api/health no disponible (puede ser normal)"
fi

echo ""
echo "✅ Verificación completada"
echo ""
echo "💡 Si algún endpoint falla:"
echo "   1. Revisa los logs en Render Dashboard"
echo "   2. Verifica que las migraciones estén aplicadas"
echo "   3. Verifica que APP_DEBUG=false en producción"




