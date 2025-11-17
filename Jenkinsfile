pipeline {
    agent any
    
    environment {
        // Variables de entorno para el proyecto
        APP_NAME = 'turismo-backend'
        APP_ENV = 'testing'
        
        // SonarQube
        SONAR_HOST_URL = 'http://docker.sonar:9000'
        SONAR_TOKEN = credentials('sonarqube-token')
        
        // PHP y Composer
        PHP_VERSION = '8.2'
        COMPOSER_HOME = "${WORKSPACE}/.composer"
        
        // Base de datos de prueba
        DB_CONNECTION = 'sqlite'
        DB_DATABASE = ':memory:'
        
        // Directorios
        COVERAGE_DIR = 'coverage'
        REPORTS_DIR = 'reports'
    }
    
    options {
        // Mantener solo los últimos 10 builds
        buildDiscarder(logRotator(numToKeepStr: '10'))
        
        // Timeout del pipeline
        timeout(time: 30, unit: 'MINUTES')
        
        // Deshabilitar concurrent builds
        disableConcurrentBuilds()
        
        // Timestamps en logs
        timestamps()
    }
    
    stages {
        stage('Preparación') {
            steps {
                echo '========================================='
                echo 'Etapa: Preparación del entorno'
                echo '========================================='
                
                script {
                    // Mostrar información del entorno
                    sh '''
                        echo "Workspace: ${WORKSPACE}"
                        echo "Build Number: ${BUILD_NUMBER}"
                        echo "Git Branch: ${GIT_BRANCH}"
                        php --version
                        composer --version
                    '''
                }
                
                // Limpiar workspace anterior
                sh 'rm -rf coverage/ reports/ .phpunit.cache/ || true'
                
                // Crear directorios necesarios
                sh 'mkdir -p coverage reports'
            }
        }
        
        stage('Instalar Dependencias') {
            steps {
                echo '========================================='
                echo 'Etapa: Instalación de dependencias'
                echo '========================================='
                
                script {
                    // Instalar dependencias de Composer
                    sh '''
                        composer install \
                            --no-interaction \
                            --prefer-dist \
                            --optimize-autoloader \
                            --no-progress \
                            --no-suggest
                    '''
                }
            }
        }
        
        stage('Configuración') {
            steps {
                echo '========================================='
                echo 'Etapa: Configuración de Laravel'
                echo '========================================='
                
                script {
                    // Crear archivo .env si no existe
                    sh '''
                        if [ ! -f .env ]; then
                            cp .env.example .env || echo "No .env.example found"
                        fi
                    '''
                    
                    // Generar APP_KEY
                    sh 'php artisan key:generate --no-interaction --force || true'
                    
                    // Configurar permisos
                    sh '''
                        chmod -R 775 storage bootstrap/cache 2>/dev/null || true
                        chown -R ${USER}:${USER} storage bootstrap/cache 2>/dev/null || true
                    '''
                }
            }
        }
        
        stage('Análisis de Código Estático') {
            parallel {
                stage('Laravel Pint') {
                    steps {
                        echo 'Ejecutando Laravel Pint (Code Style)...'
                        script {
                            sh '''
                                if [ -f vendor/bin/pint ]; then
                                    vendor/bin/pint --test || echo "Pint encontró issues"
                                else
                                    echo "Pint no instalado, omitiendo..."
                                fi
                            ''' 
                        }
                    }
                }
                
                stage('PHPStan') {
                    steps {
                        echo 'Ejecutando PHPStan (Static Analysis)...'
                        script {
                            sh '''
                                if [ -f vendor/bin/phpstan ]; then
                                    vendor/bin/phpstan analyse --memory-limit=2G || echo "PHPStan encontró issues"
                                else
                                    echo "PHPStan no instalado, omitiendo..."
                                fi
                            '''
                        }
                    }
                }
            }
        }
        
        stage('Ejecutar Tests') {
            steps {
                echo '========================================='
                echo 'Etapa: Ejecución de Tests'
                echo '========================================='
                
                script {
                    // Ejecutar tests con cobertura de código
                    sh '''
                        php artisan test \
                            --coverage \
                            --min=0 \
                            --coverage-clover=coverage/clover.xml \
                            --log-junit=coverage/junit.xml \
                            || (echo "Tests fallaron" && exit 1)
                    '''
                }
            }
            
            post {
                always {
                    // Publicar resultados de tests
                    junit allowEmptyResults: true, testResults: 'coverage/junit.xml'
                    
                    // Archivar reportes de cobertura
                    archiveArtifacts artifacts: 'coverage/**/*', allowEmptyArchive: true
                }
            }
        }
        
        stage('Análisis SonarQube') {
            steps {
                echo '========================================='
                echo 'Etapa: Análisis con SonarQube'
                echo '========================================='
                
                script {
                    // Ejecutar análisis de SonarQube
                    withSonarQubeEnv('SonarQube') {
                        sh '''
                            if command -v sonar-scanner &> /dev/null; then
                                sonar-scanner \
                                    -Dsonar.projectKey=turismo-backend \
                                    -Dsonar.sources=. \
                                    -Dsonar.host.url=${SONAR_HOST_URL} \
                                    -Dsonar.login=${SONAR_TOKEN}
                            else
                                echo "SonarScanner no encontrado, omitiendo análisis..."
                            fi
                        '''
                    }
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                echo '========================================='
                echo 'Etapa: Quality Gate'
                echo '========================================='
                
                script {
                    // Esperar por el resultado del Quality Gate
                    timeout(time: 5, unit: 'MINUTES') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            echo "Quality Gate falló: ${qg.status}"
                            // No fallar el build, solo advertir
                            unstable(message: "Quality Gate falló: ${qg.status}")
                        } else {
                            echo "Quality Gate pasó exitosamente"
                        }
                    }
                }
            }
        }
        
        stage('Generar Reportes') {
            steps {
                echo '========================================='
                echo 'Etapa: Generación de reportes'
                echo '========================================='
                
                script {
                    // Generar reporte HTML de cobertura si existe
                    sh '''
                        if [ -f coverage/clover.xml ]; then
                            echo "Reportes de cobertura generados en coverage/"
                            ls -lah coverage/
                        fi
                    '''
                }
            }
        }
    }
    
    post {
        always {
            echo '========================================='
            echo 'Pipeline completado'
            echo '========================================='
            
            // Limpiar workspace si es necesario
            cleanWs(
                deleteDirs: true,
                patterns: [
                    [pattern: 'vendor/**', type: 'INCLUDE'],
                    [pattern: 'node_modules/**', type: 'INCLUDE'],
                    [pattern: '.phpunit.cache/**', type: 'INCLUDE']
                ]
            )
        }
        
        success {
            echo '✓ Build exitoso'
            
            // Notificación de éxito (opcional)
            // mail to: 'equipo@example.com',
            //      subject: "Build Exitoso: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
            //      body: "El build fue exitoso. Ver: ${env.BUILD_URL}"
        }
        
        failure {
            echo '✗ Build falló'
            
            // Notificación de fallo (opcional)
            // mail to: 'equipo@example.com',
            //      subject: "Build Falló: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
            //      body: "El build falló. Ver: ${env.BUILD_URL}"
        }
        
        unstable {
            echo '⚠ Build inestable'
        }
    }
}

