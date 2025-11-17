# 🚀 Inicio Rápido - Testing y CI/CD

Guía de 5 minutos para empezar con tests y análisis de código.

## ⚡ Setup Inicial (Una sola vez)

### 1. Instalar Dependencias
```bash
composer install
```

### 2. Configurar Permisos (Linux/Mac)
```bash
chmod +x run-tests.sh run-sonar.sh
```

### 3. Generar APP_KEY (si es necesario)
```bash
php artisan key:generate
```

## 🧪 Ejecutar Tests

### Opción 1: Script Automático (Recomendado)
```bash
# Linux/Mac
./run-tests.sh

# Windows
run-tests.bat
```

### Opción 2: Composer
```bash
# Tests básicos
composer test

# Tests con cobertura
composer test:coverage

# Tests con reportes para CI
composer test:coverage-report
```

### Opción 3: Artisan
```bash
php artisan test
```

## 📊 Análisis de SonarQube

### Paso 1: Ejecutar Tests (genera reportes)
```bash
./run-tests.sh
```

### Paso 2: Ejecutar Análisis
```bash
# Linux/Mac
./run-sonar.sh

# Windows
run-sonar.bat
```

### Configurar Variables (Opcional)
```bash
export SONAR_HOST_URL="http://tu-servidor:9000"
export SONAR_TOKEN="tu_token_aqui"
./run-sonar.sh
```

## 🎨 Verificar Estilo de Código

```bash
# Ver problemas de estilo
composer pint:test

# Corregir automáticamente
composer pint
```

## 🔍 Análisis Estático

```bash
composer analyse
```

## 🏗️ CI Completo (Local)

```bash
# Ejecutar todo: tests + estilo + análisis
composer ci
./run-sonar.sh
```

## 📦 Jenkins Setup

### 1. Crear Job en Jenkins
- Tipo: Pipeline
- SCM: Git
- Script Path: `Jenkinsfile`

### 2. Configurar Credenciales
- Agregar credential: `sonarqube-token`
- Tipo: Secret text

### 3. Variables de Entorno
```
SONAR_HOST_URL=http://docker.sonar:9000
```

### 4. Ejecutar Pipeline
¡Listo! Jenkins ejecutará todo automáticamente.

## 📂 Archivos Importantes

| Archivo | Propósito |
|---------|-----------|
| `phpunit.xml` | Configuración de PHPUnit |
| `sonar-project.properties` | Configuración de SonarQube |
| `Jenkinsfile` | Pipeline de Jenkins |
| `run-tests.sh/.bat` | Script de tests |
| `run-sonar.sh/.bat` | Script de SonarQube |
| `composer.json` | Scripts de composer |

## 📈 Ver Reportes

### Cobertura Local (HTML)
```bash
# Después de ejecutar tests con cobertura
# Linux/Mac
open coverage/html/index.html

# Windows
start coverage/html/index.html
```

### SonarQube Dashboard
```
http://docker.sonar:9000/dashboard?id=turismo-backend
```

### Jenkins
```
http://tu-jenkins/job/turismo-backend-pipeline/
```

## 🔧 Comandos de Composer

```bash
composer test                 # Tests sin cobertura
composer test:coverage        # Tests con cobertura
composer test:unit           # Solo tests unitarios
composer test:feature        # Solo tests de features
composer pint                # Corregir estilo
composer pint:test           # Verificar estilo
composer analyse             # Análisis estático
composer ci                  # CI completo
```

## 🐛 Troubleshooting Rápido

### Tests Fallan
```bash
composer dump-autoload
php artisan config:clear
php artisan cache:clear
```

### APP_KEY Missing
```bash
php artisan key:generate
```

### SonarScanner no encontrado
```bash
# Descargar de: https://docs.sonarqube.org/
# Agregar al PATH del sistema
```

### Permisos en Scripts (Linux/Mac)
```bash
chmod +x run-tests.sh run-sonar.sh
```

## ✅ Checklist Pre-Commit

- [ ] Tests pasan: `composer test`
- [ ] Estilo correcto: `composer pint:test`
- [ ] Análisis estático: `composer analyse`
- [ ] Cobertura adecuada: `composer test:coverage`

## 📚 Más Información

- **Documentación Completa**: Ver `TESTING_README.md`
- **Resumen de Setup**: Ver `TESTING_SETUP_SUMMARY.md`
- **Laravel Testing**: https://laravel.com/docs/testing
- **PHPUnit**: https://phpunit.de/
- **SonarQube**: https://docs.sonarqube.org/

## 💡 Tips

1. **Desarrollo Rápido**: Usa `composer test` (sin cobertura)
2. **Pre-Commit**: Usa `composer ci`
3. **Antes de PR**: Ejecuta `./run-tests.sh && ./run-sonar.sh`
4. **Debug Tests**: Usa `php artisan test --filter=NombreDelTest`

---

**¿Necesitas ayuda?** Revisa `TESTING_README.md` para documentación completa.

