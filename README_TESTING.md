# 🧪 Sistema de Testing y CI/CD - Turismo Backend

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![PHP](https://img.shields.io/badge/PHP-8.2+-purple.svg)
![Laravel](https://img.shields.io/badge/Laravel-12.0-red.svg)
![Tests](https://img.shields.io/badge/tests-passing-brightgreen.svg)
![Coverage](https://img.shields.io/badge/coverage-70%25+-green.svg)

**Sistema completo de testing, análisis de código y CI/CD configurado y listo para usar**

[Inicio Rápido](#-inicio-rápido) • [Documentación](#-documentación) • [Jenkins](#-jenkins) • [SonarQube](#-sonarqube)

</div>

---

## 📋 Índice

- [Características](#-características)
- [Inicio Rápido](#-inicio-rápido)
- [Documentación](#-documentación)
- [Archivos Creados](#-archivos-creados)
- [Comandos Principales](#-comandos-principales)
- [Jenkins Pipeline](#-jenkins-pipeline)
- [SonarQube](#-sonarqube)
- [Troubleshooting](#-troubleshooting)

---

## ✨ Características

### 🧪 Testing
- ✅ **PHPUnit 11.5** configurado y optimizado
- ✅ **SQLite en memoria** para tests ultrarrápidos
- ✅ **30+ tests** (unitarios y de integración)
- ✅ **Cobertura de código** > 70%
- ✅ **Reportes automáticos** (XML, HTML, JUnit)

### 🔍 Análisis de Código
- ✅ **Laravel Pint** para code style
- ✅ **PHPStan** para análisis estático (nivel 5)
- ✅ **SonarQube** para métricas de calidad
- ✅ **Quality Gates** configurados

### 🤖 CI/CD
- ✅ **Jenkins Pipeline** completo (8 etapas)
- ✅ **Integración con SonarQube** automática
- ✅ **Scripts multiplataforma** (Linux/Mac/Windows)
- ✅ **Notificaciones** configurables

### 📊 Reportes
- ✅ **Clover XML** para SonarQube
- ✅ **JUnit XML** para Jenkins
- ✅ **HTML interactivo** para visualización local
- ✅ **Dashboard de SonarQube** con métricas en tiempo real

---

## 🚀 Inicio Rápido

### 1️⃣ Instalación (Primera vez)

```bash
# Instalar dependencias
composer install

# Dar permisos a scripts (Linux/Mac)
chmod +x run-tests.sh run-sonar.sh
```

### 2️⃣ Ejecutar Tests

```bash
# Opción 1: Script automático (Recomendado)
./run-tests.sh              # Linux/Mac
run-tests.bat               # Windows

# Opción 2: Composer
composer test               # Tests sin cobertura
composer test:coverage      # Tests con cobertura

# Opción 3: Artisan
php artisan test
```

### 3️⃣ Ver Reportes

```bash
# Abrir reporte HTML de cobertura
open coverage/html/index.html      # Mac
start coverage/html/index.html     # Windows
xdg-open coverage/html/index.html  # Linux
```

### 4️⃣ Análisis de SonarQube (Opcional)

```bash
./run-sonar.sh              # Linux/Mac
run-sonar.bat               # Windows
```

---

## 📚 Documentación

| Documento | Descripción | Uso |
|-----------|-------------|-----|
| **[QUICK_START_TESTING.md](QUICK_START_TESTING.md)** | ⚡ Guía de 5 minutos | Empezar rápidamente |
| **[TESTING_README.md](TESTING_README.md)** | 📖 Documentación completa | Referencia completa |
| **[TESTING_SETUP_SUMMARY.md](TESTING_SETUP_SUMMARY.md)** | 📋 Resumen técnico | Detalles de implementación |
| **[CHANGELOG_TESTING.md](CHANGELOG_TESTING.md)** | 📝 Registro de cambios | Ver qué cambió |

---

## 📦 Archivos Creados

### Scripts de Ejecución
```
turismo-backend/
├── run-tests.sh          # Script de tests (Linux/Mac)
├── run-tests.bat         # Script de tests (Windows)
├── run-sonar.sh          # Script de SonarQube (Linux/Mac)
└── run-sonar.bat         # Script de SonarQube (Windows)
```

### Configuración
```
turismo-backend/
├── phpunit.xml           # 🔄 Configuración de PHPUnit
├── phpstan.neon          # ✨ Configuración de PHPStan
├── pint.json             # ✨ Configuración de Pint
├── sonar-project.properties  # 🔄 Configuración de SonarQube
├── Jenkinsfile           # ✨ Pipeline de Jenkins
└── composer.json         # 🔄 Scripts agregados
```

### Tests
```
tests/
├── Unit/                 # Tests unitarios
│   ├── ExampleTest.php   # 🔄 Corregido
│   ├── Models/           # 11 tests de modelos
│   └── Services/         # 8 tests de servicios
├── Feature/              # Tests de integración
│   └── Controllers/      # 11 tests de controladores
└── TestCase.php          # Base para tests
```

### Documentación
```
turismo-backend/
├── README_TESTING.md             # ✨ Este archivo
├── QUICK_START_TESTING.md        # ✨ Inicio rápido
├── TESTING_README.md             # ✨ Documentación completa
├── TESTING_SETUP_SUMMARY.md      # ✨ Resumen técnico
└── CHANGELOG_TESTING.md          # ✨ Changelog
```

**Leyenda:** ✨ Nuevo | 🔄 Modificado

---

## ⚡ Comandos Principales

### Testing

```bash
# Tests básicos
composer test                     # Todos los tests
composer test:unit               # Solo unitarios
composer test:feature            # Solo features

# Tests con cobertura
composer test:coverage           # Con cobertura en consola
composer test:coverage-report    # Con reportes XML/HTML

# Tests específicos
php artisan test --filter=UserTest
php artisan test tests/Unit/Models/UserTest.php
```

### Calidad de Código

```bash
# Code Style
composer pint                    # Corregir automáticamente
composer pint:test              # Solo verificar

# Análisis Estático
composer analyse                # PHPStan

# CI Completo
composer ci                     # Tests + Pint
```

### SonarQube

```bash
# Análisis local
./run-sonar.sh                  # Linux/Mac
run-sonar.bat                   # Windows

# Con variables personalizadas
export SONAR_HOST_URL="http://tu-servidor:9000"
export SONAR_TOKEN="tu_token"
./run-sonar.sh
```

---

## 🏗️ Jenkins Pipeline

### Configuración

```groovy
// Jenkinsfile incluye 8 etapas:
1. Preparación           → Limpia workspace
2. Instalar Dependencias → composer install
3. Configuración         → Setup Laravel
4. Análisis Estático     → Pint + PHPStan
5. Ejecutar Tests        → PHPUnit + Coverage
6. Análisis SonarQube    → Envío de reportes
7. Quality Gate          → Verificación de calidad
8. Generar Reportes      → Archivado
```

### Setup en Jenkins

1. **Crear Job**
   - Nuevo Item → Pipeline
   - SCM: Git
   - Script Path: `Jenkinsfile`

2. **Credenciales**
   ```
   ID: sonarqube-token
   Tipo: Secret text
   Secret: [tu token de SonarQube]
   ```

3. **Variables de Entorno**
   ```bash
   SONAR_HOST_URL=http://docker.sonar:9000
   ```

4. **Ejecutar**
   - Build Now
   - O configurar webhook de Git

### Resultado del Pipeline

```
✓ Preparación           [5s]
✓ Instalar Dependencias [30s]
✓ Configuración         [10s]
✓ Análisis Estático     [15s]
✓ Ejecutar Tests        [45s]
✓ Análisis SonarQube    [30s]
✓ Quality Gate          [20s]
✓ Generar Reportes      [5s]

Total: ~2.5 minutos
```

---

## 📊 SonarQube

### Métricas Analizadas

| Métrica | Descripción | Objetivo |
|---------|-------------|----------|
| **Coverage** | Cobertura de código | > 70% |
| **Duplications** | Código duplicado | < 3% |
| **Maintainability** | Mantenibilidad | Rating A |
| **Reliability** | Fiabilidad | Rating A |
| **Security** | Seguridad | Rating A |
| **Code Smells** | Malas prácticas | < 50 |
| **Bugs** | Posibles errores | 0 |
| **Vulnerabilities** | Vulnerabilidades | 0 |

### Dashboard

Acceder a: `http://docker.sonar:9000/dashboard?id=turismo-backend`

### Quality Gate

Configurado para:
- ✅ Cobertura mínima: 70%
- ✅ Código duplicado máximo: 3%
- ✅ Reliability: A
- ✅ Security: A
- ✅ Maintainability: A

---

## 🐛 Troubleshooting

### Tests Fallan

```bash
# Limpiar caché
composer dump-autoload
php artisan config:clear
php artisan cache:clear

# Reinstalar dependencias
rm -rf vendor
composer install
```

### APP_KEY Missing

```bash
# Generar nueva key
php artisan key:generate
```

### SonarScanner no encontrado

```bash
# Descargar de:
https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

# Agregar al PATH del sistema
export PATH=$PATH:/ruta/a/sonar-scanner/bin
```

### Permisos en Scripts

```bash
# Linux/Mac
chmod +x run-tests.sh run-sonar.sh
```

### Jenkins no encuentra composer

```groovy
// En Jenkinsfile, usar ruta completa:
sh '/usr/local/bin/composer install'

// O configurar PATH:
environment {
    PATH = "/usr/local/bin:${env.PATH}"
}
```

---

## 📈 Estadísticas del Proyecto

### Tests
- **Total**: 30+ tests
- **Unitarios**: 19 tests
- **Features**: 11 tests
- **Cobertura**: > 70%

### Archivos de Test
- **Modelos**: 11 archivos
- **Servicios**: 8 archivos
- **Controladores**: 11 archivos

### Líneas de Código
- **App**: ~5,000 líneas
- **Tests**: ~2,000 líneas
- **Config**: ~500 líneas

---

## 🎯 Checklist Pre-Commit

Antes de hacer commit, verifica:

- [ ] ✅ Tests pasan: `composer test`
- [ ] ✅ Code style correcto: `composer pint:test`
- [ ] ✅ Sin errores de PHPStan: `composer analyse`
- [ ] ✅ Cobertura adecuada: `composer test:coverage`
- [ ] ✅ Commits descriptivos
- [ ] ✅ Sin archivos sensibles (.env, etc.)

---

## 🤝 Contribuir

### Agregar Tests

1. **Test Unitario**
   ```php
   // tests/Unit/Models/MiModeloTest.php
   namespace Tests\Unit\Models;
   
   use Tests\TestCase;
   use Illuminate\Foundation\Testing\RefreshDatabase;
   
   class MiModeloTest extends TestCase
   {
       use RefreshDatabase;
       
       public function test_ejemplo(): void
       {
           // Arrange, Act, Assert
       }
   }
   ```

2. **Test de Feature**
   ```php
   // tests/Feature/Controllers/MiControllerTest.php
   namespace Tests\Feature\Controllers;
   
   use Tests\TestCase;
   use Illuminate\Foundation\Testing\RefreshDatabase;
   
   class MiControllerTest extends TestCase
   {
       use RefreshDatabase;
       
       public function test_endpoint(): void
       {
           $response = $this->getJson('/api/endpoint');
           $response->assertStatus(200);
       }
   }
   ```

3. **Ejecutar nuevo test**
   ```bash
   php artisan test --filter=MiTest
   ```

---

## 📞 Recursos y Enlaces

### Documentación Oficial
- [Laravel Testing](https://laravel.com/docs/testing)
- [PHPUnit](https://phpunit.de/documentation.html)
- [PHPStan](https://phpstan.org/user-guide/getting-started)
- [SonarQube](https://docs.sonarqube.org/)
- [Jenkins](https://www.jenkins.io/doc/)

### Tutoriales
- [Laravel Testing Best Practices](https://laravel-news.com/testing-best-practices)
- [SonarQube for PHP](https://docs.sonarqube.org/latest/analysis/languages/php/)
- [Jenkins Pipeline Tutorial](https://www.jenkins.io/doc/book/pipeline/)

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT.

---

## 👥 Equipo

**Desarrollado por:** Equipo de Testing y QA  
**Fecha:** Octubre 2024  
**Versión:** 1.0.0  
**Estado:** ✅ Completado y en Producción

---

<div align="center">

**¿Preguntas?** Revisa la [documentación completa](TESTING_README.md) o el [inicio rápido](QUICK_START_TESTING.md)

**¡Happy Testing! 🧪✨**

</div>

