-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 28, 2025 at 02:56 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `turismo`
--

-- --------------------------------------------------------

--
-- Table structure for table `asociaciones`
--

CREATE TABLE `asociaciones` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `municipalidad_id` bigint UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `latitud` decimal(10,7) DEFAULT NULL,
  `longitud` decimal(10,7) DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asociaciones`
--

INSERT INTO `asociaciones` (`id`, `nombre`, `descripcion`, `telefono`, `email`, `municipalidad_id`, `estado`, `created_at`, `updated_at`, `latitud`, `longitud`, `imagen`) VALUES
(1, 'Asociación de Turismo Vivencial Llachón', 'Grupo de familias que ofrecen servicios de turismo vivencial en la comunidad de Llachón.', '951234567', 'turvivllachon@gmail.com', 1, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', '-15.6450000', '-69.8345000', 'asociaciones/llachon.jpg'),
(2, 'Asociación de Artesanos de Capachica', 'Reúne a artesanos tradicionales que elaboran textiles, cerámica y otros productos artesanales.', '951987654', 'artesanoscapachica@gmail.com', 1, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', '-15.6425000', '-69.8330000', 'asociaciones/artesanos.jpg'),
(3, 'Asociación de Turismo Rural Comunitario Isla Ticonata', 'Familias que ofrecen servicios turísticos en la isla Ticonata.', '952345678', 'ticonata.trc@gmail.com', 1, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', '-15.6410000', '-69.8320000', 'asociaciones/ticonata.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel_cache_spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:58:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"user_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:9:\"user_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:11:\"user_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:11:\"user_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:11:\"role_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:9:\"role_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:11:\"role_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:11:\"role_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:15:\"permission_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:17:\"permission_assign\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:18:\"emprendedor_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:16:\"emprendedor_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:18:\"emprendedor_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:18:\"emprendedor_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:15:\"servicio_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:13:\"servicio_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:15:\"servicio_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:15:\"servicio_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:16:\"categoria_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:14:\"categoria_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:16:\"categoria_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:16:\"categoria_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:17:\"asociacion_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:15:\"asociacion_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:17:\"asociacion_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:17:\"asociacion_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:20:\"municipalidad_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:18:\"municipalidad_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:20:\"municipalidad_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:20:\"municipalidad_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:14:\"reserva_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:12:\"reserva_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:14:\"reserva_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:14:\"reserva_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:13:\"slider_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:11:\"slider_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:13:\"slider_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:13:\"slider_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:13:\"evento_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:11:\"evento_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:13:\"evento_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:13:\"evento_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:11:\"plan_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:9:\"plan_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:11:\"plan_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:11:\"plan_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:25:\"plan_manage_emprendedores\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:25:\"plan_manage_inscripciones\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:18:\"inscripcion_create\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:16:\"inscripcion_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:18:\"inscripcion_update\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:18:\"inscripcion_delete\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:21:\"inscripcion_confirmar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:20:\"inscripcion_cancelar\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:4:{i:0;i:1;i:1;i:2;i:2;i:3;i:3;i:4;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:14:\"dashboard_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:4;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:17:\"estadisticas_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:3;i:2;i:4;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:17:\"admin_planes_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:24:\"admin_inscripciones_read\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:4:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:5:\"admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:4:\"user\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:11:\"emprendedor\";s:1:\"c\";s:3:\"web\";}i:3;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:9:\"moderador\";s:1:\"c\";s:3:\"web\";}}}', 1761681652);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `icono_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `icono_url`, `created_at`, `updated_at`) VALUES
(1, 'Alojamiento', 'Diferentes opciones de hospedaje, desde casas rurales hasta ecolodges.', 'icons/alojamiento.svg', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(2, 'Alimentación', 'Restaurantes y servicios de comida tradicional de la región.', 'icons/alimentacion.svg', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(3, 'Artesanía', 'Productos hechos a mano por artesanos locales.', 'icons/artesania.svg', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(4, 'Transporte', 'Servicios de transporte terrestre y lacustre.', 'icons/transporte.svg', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(5, 'Actividades', 'Experiencias y actividades turísticas.', 'icons/actividades.svg', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(6, 'Guiado', 'Servicios de guías turísticos locales.', 'icons/guiado.svg', '2025-10-23 00:26:42', '2025-10-23 00:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `categoria_servicio`
--

CREATE TABLE `categoria_servicio` (
  `id` bigint UNSIGNED NOT NULL,
  `servicio_id` bigint UNSIGNED NOT NULL,
  `categoria_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categoria_servicio`
--

INSERT INTO `categoria_servicio` (`id`, `servicio_id`, `categoria_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(2, 2, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(3, 3, 5, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(4, 4, 2, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(5, 5, 2, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(6, 5, 5, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(7, 6, 3, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(8, 7, 3, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(9, 7, 5, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(10, 8, 4, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(11, 8, 6, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(12, 9, 4, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(13, 10, 5, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(14, 11, 5, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(15, 11, 6, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(16, 12, 1, '2025-10-27 20:40:07', '2025-10-27 20:40:07'),
(17, 12, 2, '2025-10-27 20:40:07', '2025-10-27 20:40:07'),
(18, 12, 4, '2025-10-27 20:40:07', '2025-10-27 20:40:07'),
(19, 13, 3, '2025-10-27 21:02:18', '2025-10-27 21:02:18'),
(20, 13, 6, '2025-10-27 21:02:18', '2025-10-27 21:02:18'),
(21, 14, 1, '2025-10-27 21:58:03', '2025-10-27 21:58:03'),
(22, 14, 4, '2025-10-27 21:58:03', '2025-10-27 21:58:03'),
(23, 14, 6, '2025-10-27 21:58:03', '2025-10-27 21:58:03'),
(24, 14, 5, '2025-10-27 21:58:03', '2025-10-27 21:58:03'),
(25, 15, 1, '2025-10-27 21:58:30', '2025-10-27 21:58:30'),
(26, 15, 4, '2025-10-27 21:58:30', '2025-10-27 21:58:30');

-- --------------------------------------------------------

--
-- Table structure for table `emprendedores`
--

CREATE TABLE `emprendedores` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_servicio` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pagina_web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `horario_atencion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_rango` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metodos_pago` json DEFAULT NULL,
  `capacidad_aforo` int DEFAULT NULL,
  `numero_personas_atiende` int DEFAULT NULL,
  `comentarios_resenas` text COLLATE utf8mb4_unicode_ci,
  `imagenes` json DEFAULT NULL,
  `categoria` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `certificaciones` json DEFAULT NULL,
  `idiomas_hablados` json DEFAULT NULL,
  `opciones_acceso` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facilidades_discapacidad` tinyint(1) NOT NULL DEFAULT '0',
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `asociacion_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `emprendedores`
--

INSERT INTO `emprendedores` (`id`, `nombre`, `tipo_servicio`, `descripcion`, `ubicacion`, `telefono`, `email`, `pagina_web`, `horario_atencion`, `precio_rango`, `metodos_pago`, `capacidad_aforo`, `numero_personas_atiende`, `comentarios_resenas`, `imagenes`, `categoria`, `certificaciones`, `idiomas_hablados`, `opciones_acceso`, `facilidades_discapacidad`, `estado`, `created_at`, `updated_at`, `asociacion_id`) VALUES
(1, 'Casa Hospedaje Samary', 'Alojamiento', 'Casa hospedaje familiar que ofrece habitaciones cómodas con vista al lago Titicaca y experiencia de turismo vivencial.', 'Comunidad Llachón, a 200m del muelle principal', '951222333', 'samary.llachon@gmail.com', 'https://samaryllachon.com', 'Todos los días: 7:00 am - 10:00 pm', 'S/. 50 - S/. 100', '\"[\\\"Efectivo\\\",\\\"Transferencia\\\",\\\"Yape\\\"]\"', 12, 3, 'Excelente servicio, habitaciones limpias y comida deliciosa. Muy recomendado.', '\"[\\\"samary1.jpg\\\",\\\"samary2.jpg\\\",\\\"samary3.jpg\\\"]\"', 'Alojamiento', '\"TRC MINCETUR\"', '\"Español, Inglés básico, Quechua\"', '\"A pie, en bote\"', 1, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', 1),
(2, 'Restaurante Sumaq Mijuna', 'Alimentación', 'Restaurante que ofrece platos típicos de la región elaborados con productos locales y orgánicos.', 'Plaza principal de Capachica', '954333222', 'sumaqmijuna@gmail.com', NULL, 'Lunes a Domingo: 8:00 am - 8:00 pm', 'S/. 15 - S/. 35', '\"[\\\"Efectivo\\\",\\\"Yape\\\"]\"', 30, 5, 'La trucha frita es espectacular. Ambiente familiar y precios accesibles.', '\"[\\\"sumaq1.jpg\\\",\\\"sumaq2.jpg\\\"]\"', 'Alimentación', '\"Restaurante Saludable Municipal\"', '\"Español, Quechua\"', '\"A pie, transporte p\\u00fablico, taxi\"', 0, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', NULL),
(3, 'Artesanías Titicaca', 'Artesanía', 'Taller y tienda de artesanía textil que utiliza técnicas ancestrales y tintes naturales.', 'Comunidad Escallani, a 500m de la plaza', '957888999', 'artesanias.titicaca@gmail.com', NULL, 'Lunes a Sábado: 9:00 am - 6:00 pm', 'S/. 10 - S/. 200', '\"[\\\"Efectivo\\\",\\\"Transferencia\\\"]\"', 10, 2, 'Hermosos trabajos textiles. Ofrecen demostraciones del proceso de tejido.', '\"[\\\"artesania1.jpg\\\",\\\"artesania2.jpg\\\"]\"', 'Artesanía', '\"Marca Perú\"', '\"Español, Quechua, Aymara\"', '\"A pie\"', 0, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', 2),
(4, 'Transportes Lacustres Titicaca', 'Transporte', 'Servicio de transporte en bote para visitar las islas y comunidades del lago Titicaca.', 'Muelle principal de Capachica', '956777888', 'lacustrestiticaca@gmail.com', 'https://transportestiticaca.com', 'Todos los días: 6:00 am - 5:00 pm', 'S/. 30 - S/. 150', '\"[\\\"Efectivo\\\",\\\"Transferencia\\\",\\\"Yape\\\",\\\"Tarjeta\\\"]\"', 15, 2, 'Botes en buen estado y guías conocedores. Muy seguro y puntual.', '\"[\\\"transporte1.jpg\\\",\\\"transporte2.jpg\\\"]\"', 'Transporte', '\"MTC, Capitanía de Puertos\"', '\"Español, Inglés básico\"', '\"A pie\"', 1, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', NULL),
(5, 'Aventuras Titicaca', 'Actividades', 'Empresa que ofrece kayak, bicicleta, trekking y otras actividades al aire libre.', 'Comunidad Cotos, a 1km del centro', '959666777', 'aventuras@titicaca.pe', 'https://aventurastiticaca.pe', 'Lunes a Domingo: 7:00 am - 6:00 pm', 'S/. 40 - S/. 120', '\"[\\\"Efectivo\\\",\\\"Transferencia\\\",\\\"Tarjeta\\\"]\"', 20, 4, 'Increíble experiencia de kayak al amanecer. Equipos en buen estado y guías profesionales.', '\"[\\\"aventuras1.jpg\\\",\\\"aventuras2.jpg\\\",\\\"aventuras3.jpg\\\"]\"', 'Actividades', '\"DIRCETUR, Primeros Auxilios\"', '\"Español, Inglés, Francés básico\"', '\"A pie, transporte p\\u00fablico, taxi\"', 0, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42', NULL),
(6, 'Emprendimiento de casa yachon', 'Gastronomía', 'jsksjs', 'jznNN', '9875464349', 'juan@gmail.com', 'https://test.com', '9:00 - 18:00', '100', '[\"Tarjeta de Crédito/Débito\", \"Transferencia Bancaria\"]', 20, 20, 'Comentarios de prueba', '[\"emprendedores/6/14f77aeb-097e-46fd-bf24-d977ea9b5f6b.jpg\"]', 'Gastronomía', NULL, '[\"Quechua\", \"Español\"]', 'Test access production', 1, 1, '2025-10-27 07:22:38', '2025-10-27 20:41:00', 1),
(7, 'prueba 02', 'Guía Turístico', 'prue', 'capachica', '94561235', 'david@gmail.com', 'https://test.com', '9:00 - 18:00', '100', '[\"Plin\", \"Yape\", \"Transferencia Bancaria\", \"Tarjeta de Crédito/Débito\", \"Efectivo\"]', 20, 20, 'Comentarios de prueba', '[\"emprendedores/7/5b645452-2168-418a-8c1d-aee67f2e3ac5.jpg\"]', 'Transporte', NULL, '[\"Español\", \"Quechua\", \"Aymara\", \"Inglés\"]', 'ndnsks', 1, 1, '2025-10-27 07:24:00', '2025-10-27 20:14:51', 3),
(8, 'prueba 2', 'Alimentación', 'znzn', 'ksksks', '9494647676', 'david@gmail.com', 'jsjsksks', 'de 10 a 12', '100', '[\"Yape\", \"Efectivo\"]', 15, 10, NULL, '[\"emprendedores/8/fe686f83-caff-4f40-9c98-9bc1e2e9caac.jpg\"]', 'Alojamiento', NULL, '[\"Quechua\", \"Español\"]', 'todo', 1, 1, '2025-10-27 19:23:04', '2025-10-27 21:02:47', 1),
(9, 'kskaka', 'Transporte', 'mMsms', 'kLals', '94561235', 'david@gmail.com', 'https://localhost', 'de 1 a 10', '100', '[\"Yape\"]', 15, 20, NULL, '[\"emprendedores/9/b8c04ed3-ac88-4a00-9ac6-6811a12adbc5.jpg\"]', 'Alojamiento', NULL, '[\"Español\"]', 'todo', 0, 1, '2025-10-27 20:28:43', '2025-10-27 20:30:45', 3),
(10, 'emprendedor1', 'Gastronomía', 'mslala', 'nsmsmsl', '948767673', 'emprendedor1@gmail.com', NULL, 'de 1 a 17', '20', '[\"Efectivo\", \"Yape\"]', 15, 20, NULL, '[\"emprendedores/10/0b311384-6452-44c2-8d89-2b40dedfe029.jpg\"]', 'Gastronomía', NULL, '[\"Español\"]', 'todo', 0, 1, '2025-10-27 21:56:07', '2025-10-27 21:56:07', 1),
(11, 'emprendedor2', 'Alojamiento', 'kdksls', 'jdksls', '949767679', 'emprendedor2@gmail.com', NULL, 'de 1 a 19', '30', '[\"Efectivo\", \"Yape\"]', 25, 60, NULL, '[\"emprendedores/11/82aaa5a2-e143-4e45-ad19-a67692cf5b4b.jpg\"]', 'Cultural', NULL, '[\"Español\"]', 'todo', 1, 1, '2025-10-27 21:57:12', '2025-10-27 21:57:12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `eventos`
--

CREATE TABLE `eventos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_evento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idioma_principal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_inicio` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `fecha_fin` date NOT NULL,
  `hora_fin` time NOT NULL,
  `duracion_horas` int DEFAULT NULL,
  `coordenada_x` decimal(10,6) NOT NULL,
  `coordenada_y` decimal(10,6) NOT NULL,
  `id_emprendedor` bigint UNSIGNED NOT NULL,
  `que_llevar` text COLLATE utf8mb4_unicode_ci,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `galeria` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_04_10_170132_create_personal_access_tokens_table', 1),
(5, '2025_04_10_170136_create_permission_tables', 1),
(6, '2025_04_10_170142_add_fields_to_users_table', 1),
(7, '2025_04_23_035800_create_emprendedores_table', 1),
(8, '2025_04_23_035921_create_servicios_table', 1),
(9, '2025_04_23_035931_create_categorias_table', 1),
(10, '2025_04_23_035937_create_categoria_servicio_table', 1),
(11, '2025_04_23_062128_create_municipalidades_table', 1),
(12, '2025_04_23_064553_create_sliders_table', 1),
(13, '2025_04_24_020730_create_reservas_table', 1),
(14, '2025_04_25_002545_create_reserva_detalle_table', 1),
(15, '2025_04_25_025609_create_asociaciones_table', 1),
(16, '2025_04_30_045104_create_user_emprendedor_table', 1),
(17, '2025_05_01_040721_add_google_auth_to_users', 1),
(18, '2025_05_03_050224_actualizar_estructura_servicios', 1),
(19, '2025_05_07_233727_create_eventos_table', 1),
(20, '2025_05_15_060203_create_planes_y_relaciones_table', 1),
(21, '2025_06_14_231418_create_plan_dias_table', 1),
(22, '2025_06_14_231453_create_plan_dia_servicios_table', 1),
(23, '2025_06_14_232136_add_details_to_plans_table', 1),
(24, '2025_06_14_232228_add_details_to_plan_inscripciones_table', 1),
(25, '2025_06_16_065600_create_plan_emprendedores_table', 1),
(26, '2025_10_21_163500_make_duracion_horas_nullable_in_eventos_table', 1),
(27, 'add_images_to_servicios_and_eventos', 1),
(28, '2025_01_27_000000_fix_emprendedores_column_types', 2);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 4),
(1, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(3, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(3, 'App\\Models\\User', 9),
(3, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 12);

-- --------------------------------------------------------

--
-- Table structure for table `municipalidad`
--

CREATE TABLE `municipalidad` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `red_facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `red_instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `red_youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coordenadas_x` decimal(10,7) DEFAULT NULL,
  `coordenadas_y` decimal(10,7) DEFAULT NULL,
  `frase` text COLLATE utf8mb4_unicode_ci,
  `comunidades` text COLLATE utf8mb4_unicode_ci,
  `historiafamilias` text COLLATE utf8mb4_unicode_ci,
  `historiacapachica` text COLLATE utf8mb4_unicode_ci,
  `comite` text COLLATE utf8mb4_unicode_ci,
  `mision` text COLLATE utf8mb4_unicode_ci,
  `vision` text COLLATE utf8mb4_unicode_ci,
  `valores` text COLLATE utf8mb4_unicode_ci,
  `ordenanzamunicipal` text COLLATE utf8mb4_unicode_ci,
  `alianzas` text COLLATE utf8mb4_unicode_ci,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `horariodeatencion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `municipalidad`
--

INSERT INTO `municipalidad` (`id`, `nombre`, `descripcion`, `red_facebook`, `red_instagram`, `red_youtube`, `coordenadas_x`, `coordenadas_y`, `frase`, `comunidades`, `historiafamilias`, `historiacapachica`, `comite`, `mision`, `vision`, `valores`, `ordenanzamunicipal`, `alianzas`, `correo`, `horariodeatencion`, `created_at`, `updated_at`) VALUES
(1, 'Municipalidad Distrital de Capachica', 'La Municipalidad Distrital de Capachica es una institución pública que vela por el desarrollo sostenible del distrito a través de la promoción del turismo, conservación del medio ambiente y mejora de la calidad de vida de sus pobladores.', 'https://facebook.com/municipalidadcapachica', 'https://instagram.com/municapachica', 'https://youtube.com/municapachica', '-15.6425000', '-69.8330000', '¡Bienvenidos a Capachica, Paraíso Turístico del Lago Titicaca!', 'Capachica cuenta con 16 comunidades: Llachón, Cotos, Siale, Hilata, Isañura, San Cristóbal, Escallani, Chillora, Yapura, Collasuyo, Miraflores, Villa Lago, Capano, Ccotos, Yancaco y Central.', 'Las familias de Capachica han mantenido sus tradiciones ancestrales por generaciones, dedicándose principalmente a la agricultura, pesca y ahora al turismo vivencial.', 'Capachica es una península situada en el lago Titicaca con una rica historia preinca e inca. Durante la colonia española, se establecieron haciendas que luego dieron paso a comunidades campesinas que hoy preservan su cultura y patrimonio.', 'El comité de desarrollo turístico de Capachica está formado por representantes de las comunidades, emprendedores locales y autoridades municipales.', 'Promover el desarrollo sostenible del distrito mediante la gestión eficiente de recursos, servicios públicos de calidad y promoción del turismo vivencial, respetando la identidad cultural y el medio ambiente.', 'Al 2030, ser un distrito modelo en turismo sostenible, con infraestructura adecuada, servicios de calidad y una población con mejor calidad de vida, preservando su identidad cultural y recursos naturales.', 'Honestidad, Transparencia, Respeto al medio ambiente, Identidad cultural, Trabajo en equipo, Compromiso social', 'Ordenanza Municipal N° 015-2023-MDP que regula la actividad turística y establece estándares para la prestación de servicios turísticos en el distrito.', 'Trabajamos en alianza con MINCETUR, DIRCETUR Puno, Programa TRC, PNUD, GIZ, y diversas universidades para la capacitación de emprendedores y promoción del turismo.', 'informes@municapachica.gob.pe', 'Lunes a Viernes: 8:00 am - 4:00 pm', '2025-10-23 00:26:42', '2025-10-23 00:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'user_create', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(2, 'user_read', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(3, 'user_update', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(4, 'user_delete', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(5, 'role_create', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(6, 'role_read', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(7, 'role_update', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(8, 'role_delete', 'web', '2025-10-23 00:26:40', '2025-10-23 00:26:40'),
(9, 'permission_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(10, 'permission_assign', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(11, 'emprendedor_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(12, 'emprendedor_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(13, 'emprendedor_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(14, 'emprendedor_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(15, 'servicio_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(16, 'servicio_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(17, 'servicio_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(18, 'servicio_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(19, 'categoria_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(20, 'categoria_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(21, 'categoria_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(22, 'categoria_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(23, 'asociacion_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(24, 'asociacion_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(25, 'asociacion_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(26, 'asociacion_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(27, 'municipalidad_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(28, 'municipalidad_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(29, 'municipalidad_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(30, 'municipalidad_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(31, 'reserva_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(32, 'reserva_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(33, 'reserva_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(34, 'reserva_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(35, 'slider_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(36, 'slider_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(37, 'slider_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(38, 'slider_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(39, 'evento_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(40, 'evento_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(41, 'evento_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(42, 'evento_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(43, 'plan_create', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(44, 'plan_read', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(45, 'plan_update', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(46, 'plan_delete', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(47, 'plan_manage_emprendedores', 'web', '2025-10-23 00:26:41', '2025-10-23 00:26:41'),
(48, 'plan_manage_inscripciones', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(49, 'inscripcion_create', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(50, 'inscripcion_read', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(51, 'inscripcion_update', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(52, 'inscripcion_delete', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(53, 'inscripcion_confirmar', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(54, 'inscripcion_cancelar', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(55, 'dashboard_read', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(56, 'estadisticas_read', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(57, 'admin_planes_read', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(58, 'admin_inscripciones_read', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(56, 'App\\Models\\User', 9, 'auth_token', '18e5be1d5bf0bbd1854e39c067e569b56a545378a88af36601cacef2e9b61923', '[\"*\"]', '2025-10-28 05:56:29', NULL, '2025-10-28 04:23:34', '2025-10-28 05:56:29'),
(57, 'App\\Models\\User', 12, 'auth_token', 'e442259ffb359404483ec4d21cc5de10072f4c9a42ed2cd64bfc093a5f98c53a', '[\"*\"]', '2025-10-28 07:40:15', NULL, '2025-10-28 07:34:16', '2025-10-28 07:40:15');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `que_incluye` text COLLATE utf8mb4_unicode_ci,
  `imagen_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagenes_galeria` json DEFAULT NULL,
  `capacidad` int NOT NULL DEFAULT '1',
  `duracion_dias` int NOT NULL DEFAULT '1',
  `es_publico` tinyint(1) NOT NULL DEFAULT '1',
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `creado_por_usuario_id` bigint UNSIGNED NOT NULL,
  `emprendedor_id` bigint UNSIGNED DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  `dificultad` enum('facil','moderado','dificil') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'facil',
  `requerimientos` text COLLATE utf8mb4_unicode_ci,
  `que_llevar` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `nombre`, `descripcion`, `que_incluye`, `imagen_principal`, `imagenes_galeria`, `capacidad`, `duracion_dias`, `es_publico`, `estado`, `creado_por_usuario_id`, `emprendedor_id`, `precio_total`, `dificultad`, `requerimientos`, `que_llevar`, `created_at`, `updated_at`) VALUES
(1, 'Turismo a casa de Jhan', 'Servicio a las esquinas', 'Lo que pida el cliente', NULL, NULL, 10, 1, 1, 'activo', 5, 1, '0.00', 'facil', NULL, NULL, '2025-10-23 00:48:58', '2025-10-23 00:48:58'),
(2, 'emprendedor1.insc', 'lalalal', 'mMsms', NULL, NULL, 10, 1, 1, 'activo', 5, 1, '0.00', 'facil', NULL, NULL, '2025-10-28 01:00:52', '2025-10-28 01:00:52'),
(3, 'emprendedor2.2', 'nzkslsl', 'mzlala', NULL, NULL, 2, 1, 1, 'activo', 5, 1, '0.00', 'facil', NULL, NULL, '2025-10-28 01:02:42', '2025-10-28 01:02:42'),
(4, 'prueba1', 'nNN', 'nNM', NULL, NULL, 1, 1, 1, 'activo', 5, 1, '0.00', 'facil', NULL, NULL, '2025-10-28 02:02:40', '2025-10-28 02:02:40'),
(5, 'usjsjsks', 'nznzkzz', 'jsjdjddj', 'planes/5/0618af51-b2c0-4731-83c8-00d560abe857.jpg', NULL, 10, 1, 1, 'activo', 5, 10, '300.00', 'facil', 'jzjsjs', 'hsjsjs', '2025-10-28 03:26:47', '2025-10-28 03:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `plan_dias`
--

CREATE TABLE `plan_dias` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `numero_dia` int NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `duracion_estimada_minutos` int DEFAULT NULL,
  `notas_adicionales` text COLLATE utf8mb4_unicode_ci,
  `orden` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan_dias`
--

INSERT INTO `plan_dias` (`id`, `plan_id`, `numero_dia`, `titulo`, `descripcion`, `hora_inicio`, `hora_fin`, `duracion_estimada_minutos`, `notas_adicionales`, `orden`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Día 1', 'Actividades del primer día', '08:00:00', '18:00:00', NULL, NULL, 1, '2025-10-23 00:48:58', '2025-10-23 00:48:58'),
(2, 2, 1, 'Día 1', 'Actividades del primer día', '08:00:00', '18:00:00', NULL, NULL, 1, '2025-10-28 01:00:52', '2025-10-28 01:00:52'),
(3, 3, 1, 'Día 1', 'Actividades del primer día', '08:00:00', '18:00:00', NULL, NULL, 1, '2025-10-28 01:02:42', '2025-10-28 01:02:42'),
(4, 4, 1, 'Día 1', 'Actividades del primer día', '08:00:00', '18:00:00', NULL, NULL, 1, '2025-10-28 02:02:40', '2025-10-28 02:02:40'),
(5, 5, 1, 'nsnznz', 'nsmsmsmks', '10:00:00', '11:00:00', 480, NULL, 1, '2025-10-28 03:26:47', '2025-10-28 03:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `plan_dia_servicios`
--

CREATE TABLE `plan_dia_servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_dia_id` bigint UNSIGNED NOT NULL,
  `servicio_id` bigint UNSIGNED NOT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `duracion_minutos` int DEFAULT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `orden` int NOT NULL DEFAULT '1',
  `es_opcional` tinyint(1) NOT NULL DEFAULT '0',
  `precio_adicional` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plan_emprendedores`
--

CREATE TABLE `plan_emprendedores` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `emprendedor_id` bigint UNSIGNED NOT NULL,
  `rol` enum('organizador','colaborador') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'colaborador',
  `es_organizador_principal` tinyint(1) NOT NULL DEFAULT '0',
  `descripcion_participacion` text COLLATE utf8mb4_unicode_ci,
  `porcentaje_ganancia` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan_emprendedores`
--

INSERT INTO `plan_emprendedores` (`id`, `plan_id`, `emprendedor_id`, `rol`, `es_organizador_principal`, `descripcion_participacion`, `porcentaje_ganancia`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'organizador', 1, NULL, '100.00', '2025-10-23 00:48:58', '2025-10-23 00:48:58'),
(2, 2, 1, 'organizador', 1, NULL, '100.00', '2025-10-28 01:00:52', '2025-10-28 01:00:52'),
(3, 3, 1, 'organizador', 1, NULL, '100.00', '2025-10-28 01:02:42', '2025-10-28 01:02:42'),
(4, 2, 11, 'organizador', 1, NULL, NULL, '2025-10-28 01:59:50', '2025-10-28 01:59:50'),
(5, 3, 11, 'organizador', 1, NULL, NULL, '2025-10-28 01:59:50', '2025-10-28 01:59:50'),
(6, 4, 1, 'organizador', 1, NULL, '100.00', '2025-10-28 02:02:40', '2025-10-28 02:02:40'),
(7, 5, 10, 'organizador', 1, NULL, '100.00', '2025-10-28 03:26:47', '2025-10-28 03:26:47');

-- --------------------------------------------------------

--
-- Table structure for table `plan_inscripciones`
--

CREATE TABLE `plan_inscripciones` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `estado` enum('pendiente','confirmada','cancelada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fecha_inscripcion` datetime DEFAULT NULL,
  `fecha_inicio_plan` datetime DEFAULT NULL,
  `fecha_fin_plan` datetime DEFAULT NULL,
  `notas_usuario` text COLLATE utf8mb4_unicode_ci,
  `requerimientos_especiales` text COLLATE utf8mb4_unicode_ci,
  `numero_participantes` int NOT NULL DEFAULT '1',
  `precio_pagado` decimal(10,2) DEFAULT NULL,
  `metodo_pago` enum('efectivo','transferencia','tarjeta','yape','plin') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comentarios_adicionales` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan_inscripciones`
--

INSERT INTO `plan_inscripciones` (`id`, `plan_id`, `user_id`, `estado`, `notas`, `created_at`, `updated_at`, `fecha_inscripcion`, `fecha_inicio_plan`, `fecha_fin_plan`, `notas_usuario`, `requerimientos_especiales`, `numero_participantes`, `precio_pagado`, `metodo_pago`, `comentarios_adicionales`) VALUES
(8, 5, 11, 'pendiente', NULL, '2025-10-28 04:15:35', '2025-10-28 04:15:35', '2025-10-27 23:15:35', NULL, NULL, 'Inscripción al plan: usjsjsks', NULL, 1, '300.00', 'efectivo', NULL),
(9, 4, 12, 'pendiente', NULL, '2025-10-28 07:36:08', '2025-10-28 07:36:08', '2025-10-28 02:36:08', NULL, NULL, NULL, NULL, 1, '0.00', 'efectivo', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `plan_services`
--

CREATE TABLE `plan_services` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `duracion_minutos` int NOT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `orden` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservas`
--

CREATE TABLE `reservas` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `codigo_reserva` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('en_carrito','pendiente','confirmada','cancelada','completada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `notas` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reservas`
--

INSERT INTO `reservas` (`id`, `usuario_id`, `codigo_reserva`, `estado`, `notas`, `created_at`, `updated_at`) VALUES
(1, 2, 'RES20251022001', 'confirmada', 'Primera visita a Capachica, muy emocionado por conocer la zona.', '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(2, 3, 'RES20251022002', 'pendiente', 'Viaje familiar, necesitamos servicios para niños también.', '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(3, 4, '3BB4FE251022', 'cancelada', 'Reserva creada desde el carrito', '2025-10-23 00:42:27', '2025-10-26 22:25:40'),
(4, 4, 'E6D8D9251025', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 02:42:22', '2025-10-26 02:42:22'),
(5, 4, 'E038F0251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 21:53:50', '2025-10-26 21:53:50'),
(6, 4, 'FC48A2251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 21:57:19', '2025-10-26 21:57:19'),
(7, 4, 'DDF700251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:01', '2025-10-26 22:01:01'),
(8, 4, '3C75EE251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:07', '2025-10-26 22:01:07'),
(9, 4, 'A5593F251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:14', '2025-10-26 22:01:14'),
(10, 4, 'DC9CFA251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:17', '2025-10-26 22:01:17'),
(11, 4, 'F40892251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:19', '2025-10-26 22:01:19'),
(12, 4, '08F85F251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:20', '2025-10-26 22:01:20'),
(13, 4, '240B77251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:22', '2025-10-26 22:01:22'),
(14, 4, '351BFF251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:01:23', '2025-10-26 22:01:23'),
(15, 4, 'C8F7AB251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:03:08', '2025-10-26 22:03:08'),
(16, 4, '10354A251026', 'cancelada', 'Reserva creada desde el carrito', '2025-10-26 22:04:33', '2025-10-26 22:25:33'),
(17, 4, '9118ED251026', 'cancelada', 'Reserva creada desde el carrito', '2025-10-26 22:09:13', '2025-10-26 22:24:08'),
(18, 4, '60E076251026', 'cancelada', 'Reserva creada desde el carrito', '2025-10-26 22:10:14', '2025-10-26 22:23:40'),
(19, 4, '19468B251026', 'pendiente', 'Reserva creada desde el carrito', '2025-10-26 22:42:09', '2025-10-26 22:42:09'),
(20, 5, '041027251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:03:44', '2025-10-27 21:03:44'),
(21, 5, 'F460C4251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:03:59', '2025-10-27 21:03:59'),
(22, 5, 'DE4B36251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:04:13', '2025-10-27 21:04:13'),
(23, 5, '530AB9251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:05:57', '2025-10-27 21:05:57'),
(24, 8, 'A65301251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:08:42', '2025-10-27 21:08:42'),
(25, 8, '35A48B251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:09:23', '2025-10-27 21:09:23'),
(26, 7, 'D896AD251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:27:41', '2025-10-27 21:27:41'),
(27, 6, '7148BF251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 21:33:43', '2025-10-27 21:33:43'),
(28, 11, '32B109251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:01:23', '2025-10-27 22:01:23'),
(29, 11, 'E4ADA1251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:01:34', '2025-10-27 22:01:34'),
(30, 11, '7B8CDB251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:01:43', '2025-10-27 22:01:43'),
(31, 11, '07F680251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:03:28', '2025-10-27 22:03:28'),
(32, 11, 'C55BF1251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:03:40', '2025-10-27 22:03:40'),
(33, 11, '2487F7251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:03:46', '2025-10-27 22:03:46'),
(34, 11, 'A4670E251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:05:30', '2025-10-27 22:05:30'),
(35, 11, 'F2CDB1251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:05:35', '2025-10-27 22:05:35'),
(36, 11, '04A14B251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:05:36', '2025-10-27 22:05:36'),
(37, 11, '132DC0251027', 'pendiente', 'Reserva creada desde el carrito', '2025-10-27 22:05:37', '2025-10-27 22:05:37'),
(38, 12, '246D02251028', 'pendiente', NULL, '2025-10-28 07:34:26', '2025-10-28 07:35:25'),
(39, 12, '27177F251028', 'en_carrito', NULL, '2025-10-28 07:35:30', '2025-10-28 07:35:30');

-- --------------------------------------------------------

--
-- Table structure for table `reserva_servicios`
--

CREATE TABLE `reserva_servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `reserva_id` bigint UNSIGNED NOT NULL,
  `servicio_id` bigint UNSIGNED NOT NULL,
  `emprendedor_id` bigint UNSIGNED NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `duracion_minutos` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `precio` decimal(10,2) DEFAULT NULL,
  `estado` enum('en_carrito','pendiente','confirmado','cancelado','completado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `notas_cliente` text COLLATE utf8mb4_unicode_ci,
  `notas_emprendedor` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reserva_servicios`
--

INSERT INTO `reserva_servicios` (`id`, `reserva_id`, `servicio_id`, `emprendedor_id`, `fecha_inicio`, `fecha_fin`, `hora_inicio`, `hora_fin`, `duracion_minutos`, `cantidad`, `precio`, `estado`, `notas_cliente`, `notas_emprendedor`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2025-10-27', '2025-10-29', '14:00:00', '12:00:00', 1320, 1, '80.00', 'confirmado', 'Preferimos una habitación con vista al lago si es posible.', NULL, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(2, 1, 8, 4, '2025-10-28', NULL, '08:00:00', '14:00:00', 360, 2, '140.00', 'confirmado', 'Somos dos personas, uno vegetariano.', NULL, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(3, 2, 2, 1, '2025-11-01', '2025-11-03', '14:00:00', '12:00:00', 1320, 1, '120.00', 'pendiente', 'Familia con dos niños pequeños, necesitamos cuna.', NULL, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(4, 2, 5, 2, '2025-11-02', NULL, '18:00:00', '21:00:00', 180, 4, '140.00', 'pendiente', 'Dos adultos y dos niños. Un adulto no come carne de res.', NULL, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(5, 2, 10, 5, '2025-11-03', NULL, '05:00:00', '08:00:00', 180, 2, '120.00', 'pendiente', 'Solo los adultos participarán en esta actividad.', NULL, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(6, 3, 4, 2, '2025-10-26', '2025-10-26', '13:00:00', '14:00:00', 60, 1, '25.00', 'cancelado', NULL, NULL, '2025-10-23 00:42:27', '2025-10-26 22:25:40'),
(7, 4, 7, 3, '2025-10-28', '2025-10-28', '10:05:00', '11:00:00', 55, 1, '30.00', 'pendiente', NULL, NULL, '2025-10-26 02:42:22', '2025-10-26 02:42:22'),
(8, 5, 7, 3, '2025-10-28', '2025-10-28', '10:05:00', '11:00:00', 55, 1, '30.00', 'pendiente', NULL, NULL, '2025-10-26 21:53:50', '2025-10-26 21:53:50'),
(9, 6, 11, 5, '2025-10-28', '2025-10-28', '09:00:00', '10:00:00', 60, 1, '40.00', 'pendiente', NULL, NULL, '2025-10-26 21:57:19', '2025-10-26 21:57:19'),
(10, 7, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:01', '2025-10-26 22:01:01'),
(11, 8, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:07', '2025-10-26 22:01:07'),
(12, 9, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:14', '2025-10-26 22:01:14'),
(13, 10, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:17', '2025-10-26 22:01:17'),
(14, 11, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:19', '2025-10-26 22:01:19'),
(15, 12, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:20', '2025-10-26 22:01:20'),
(16, 13, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:22', '2025-10-26 22:01:22'),
(17, 14, 8, 4, '2025-10-27', '2025-10-27', '09:00:00', '10:00:00', 60, 1, '70.00', 'pendiente', NULL, NULL, '2025-10-26 22:01:23', '2025-10-26 22:01:23'),
(18, 15, 10, 5, '2025-10-27', '2025-10-27', '06:02:00', '07:02:00', 60, 1, '60.00', 'pendiente', NULL, NULL, '2025-10-26 22:03:08', '2025-10-26 22:03:08'),
(19, 16, 5, 2, '2025-10-31', '2025-10-31', '19:00:00', '20:00:00', 60, 1, '35.00', 'cancelado', NULL, NULL, '2025-10-26 22:04:33', '2025-10-26 22:25:33'),
(20, 17, 4, 2, '2025-10-27', '2025-10-27', '13:07:00', '14:07:00', 60, 1, '25.00', 'cancelado', NULL, NULL, '2025-10-26 22:09:13', '2025-10-26 22:24:08'),
(21, 18, 6, 3, '2025-10-27', '2025-10-27', '10:09:00', '12:09:00', 120, 1, '45.00', 'cancelado', NULL, NULL, '2025-10-26 22:10:14', '2025-10-26 22:23:40'),
(22, 18, 9, 4, '2025-10-27', '2025-10-27', '07:09:00', '08:10:00', 61, 1, '30.00', 'cancelado', NULL, NULL, '2025-10-26 22:10:14', '2025-10-26 22:23:40'),
(23, 19, 9, 4, '2025-10-27', '2025-10-27', '07:00:00', '08:00:00', 60, 1, '30.00', 'cancelado', NULL, NULL, '2025-10-26 22:42:09', '2025-10-26 22:44:52'),
(24, 19, 6, 3, '2025-10-27', '2025-10-27', '09:00:00', '11:00:00', 120, 1, '45.00', 'pendiente', NULL, NULL, '2025-10-26 22:42:09', '2025-10-26 22:42:09'),
(25, 19, 4, 2, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'cancelado', NULL, NULL, '2025-10-26 22:42:09', '2025-10-26 22:44:30'),
(26, 20, 12, 6, '2025-10-27', '2025-10-27', '10:03:00', '12:00:00', 117, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:03:44', '2025-10-27 21:03:44'),
(27, 21, 12, 6, '2025-10-27', '2025-10-27', '10:03:00', '12:00:00', 117, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:03:59', '2025-10-27 21:03:59'),
(28, 22, 12, 6, '2025-10-27', '2025-10-27', '10:03:00', '12:00:00', 117, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:04:13', '2025-10-27 21:04:13'),
(29, 23, 12, 6, '2025-10-27', '2025-10-27', '10:03:00', '12:00:00', 117, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:05:57', '2025-10-27 21:05:57'),
(30, 24, 12, 6, '2025-10-27', '2025-10-27', '13:08:00', '14:00:00', 52, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:08:42', '2025-10-27 21:08:42'),
(31, 25, 13, 8, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:09:23', '2025-10-27 21:09:23'),
(32, 26, 12, 6, '2025-10-27', '2025-10-27', '14:00:00', '15:00:00', 60, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:27:41', '2025-10-27 21:27:41'),
(33, 27, 13, 8, '2025-10-27', '2025-10-27', '14:00:00', '15:00:00', 60, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:33:43', '2025-10-27 21:33:43'),
(34, 27, 12, 6, '2025-10-27', '2025-10-27', '15:00:00', '16:00:00', 60, 1, '200.00', 'pendiente', NULL, NULL, '2025-10-27 21:33:43', '2025-10-27 21:33:43'),
(35, 28, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:01:23', '2025-10-27 22:01:23'),
(36, 28, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:01:23', '2025-10-27 22:01:23'),
(37, 29, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:01:34', '2025-10-27 22:01:34'),
(38, 29, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:01:34', '2025-10-27 22:01:34'),
(39, 30, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:01:43', '2025-10-27 22:01:43'),
(40, 30, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:01:43', '2025-10-27 22:01:43'),
(41, 31, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:03:28', '2025-10-27 22:03:28'),
(42, 31, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:03:28', '2025-10-27 22:03:28'),
(43, 32, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:03:40', '2025-10-27 22:03:40'),
(44, 32, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:03:40', '2025-10-27 22:03:40'),
(45, 33, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:03:46', '2025-10-27 22:03:46'),
(46, 33, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:03:46', '2025-10-27 22:03:46'),
(47, 34, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:30', '2025-10-27 22:05:30'),
(48, 34, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:30', '2025-10-27 22:05:30'),
(49, 35, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:35', '2025-10-27 22:05:35'),
(50, 35, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:35', '2025-10-27 22:05:35'),
(51, 36, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:36', '2025-10-27 22:05:36'),
(52, 36, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:36', '2025-10-27 22:05:36'),
(53, 37, 14, 10, '2025-10-27', '2025-10-27', '13:00:00', '14:00:00', 60, 1, '25.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:37', '2025-10-27 22:05:37'),
(54, 37, 15, 11, '2025-10-27', '2025-10-27', '15:00:00', '16:01:00', 61, 1, '26.00', 'pendiente', NULL, NULL, '2025-10-27 22:05:37', '2025-10-27 22:05:37'),
(55, 38, 13, 8, '2025-11-03', '2025-11-03', '10:00:00', '11:00:00', 60, 1, '200.00', 'pendiente', 'Servicio: prueba 2', NULL, '2025-10-28 07:35:18', '2025-10-28 07:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(2, 'user', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(3, 'emprendedor', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(4, 'moderador', 'web', '2025-10-23 00:26:42', '2025-10-23 00:26:42');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(2, 2),
(12, 2),
(16, 2),
(20, 2),
(24, 2),
(28, 2),
(31, 2),
(32, 2),
(33, 2),
(36, 2),
(40, 2),
(44, 2),
(49, 2),
(50, 2),
(51, 2),
(54, 2),
(2, 3),
(12, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(20, 3),
(24, 3),
(28, 3),
(32, 3),
(33, 3),
(35, 3),
(36, 3),
(37, 3),
(38, 3),
(39, 3),
(40, 3),
(41, 3),
(42, 3),
(43, 3),
(44, 3),
(45, 3),
(46, 3),
(47, 3),
(48, 3),
(49, 3),
(50, 3),
(51, 3),
(53, 3),
(54, 3),
(56, 3),
(2, 4),
(12, 4),
(13, 4),
(16, 4),
(17, 4),
(19, 4),
(20, 4),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 4),
(27, 4),
(28, 4),
(29, 4),
(30, 4),
(32, 4),
(33, 4),
(36, 4),
(37, 4),
(40, 4),
(41, 4),
(44, 4),
(45, 4),
(50, 4),
(51, 4),
(53, 4),
(54, 4),
(55, 4),
(56, 4);

-- --------------------------------------------------------

--
-- Table structure for table `servicios`
--

CREATE TABLE `servicios` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `precio_referencial` decimal(10,2) DEFAULT NULL,
  `emprendedor_id` bigint UNSIGNED NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `latitud` decimal(10,7) DEFAULT NULL,
  `longitud` decimal(10,7) DEFAULT NULL,
  `ubicacion_referencia` text COLLATE utf8mb4_unicode_ci,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `galeria` json DEFAULT NULL,
  `capacidad` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `servicios`
--

INSERT INTO `servicios` (`id`, `nombre`, `descripcion`, `precio_referencial`, `emprendedor_id`, `estado`, `latitud`, `longitud`, `ubicacion_referencia`, `imagen`, `galeria`, `capacidad`, `created_at`, `updated_at`) VALUES
(1, 'Habitación Matrimonial', 'Habitación con cama matrimonial, baño privado y vista al lago.', '80.00', 1, 1, '-15.6428000', '-69.8334000', 'A 200m del muelle principal de Llachón', NULL, NULL, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(2, 'Habitación Familiar', 'Habitación amplia con una cama matrimonial y dos individuales, baño privado.', '120.00', 1, 1, '-15.6428000', '-69.8334000', 'A 200m del muelle principal de Llachón', NULL, NULL, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(3, 'Experiencia cultural', 'Participación en actividades tradicionales como agricultura, pesca y cocina local.', '50.00', 1, 1, '-15.6430000', '-69.8336000', 'En las chacras de la comunidad de Llachón', NULL, NULL, 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(4, 'Almuerzo típico', 'Incluye sopa, plato principal (trucha o cordero), postre y mate de hierbas.', '25.00', 2, 1, '-15.6420000', '-69.8325000', 'Plaza principal de Capachica', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(5, 'Cena de pachamanca', 'Tradicional pachamanca preparada con piedras calientes. Mínimo 4 personas.', '35.00', 2, 1, '-15.6420000', '-69.8325000', 'Plaza principal de Capachica', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(6, 'Chullo tradicional', 'Gorro tradicional tejido a mano con lana de alpaca y diseños típicos.', '45.00', 3, 1, '-15.6415000', '-69.8340000', 'Comunidad Escallani, a 500m de la plaza', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(7, 'Taller de tejido', 'Taller de 2 horas donde se enseña técnicas básicas de tejido andino.', '30.00', 3, 1, '-15.6415000', '-69.8340000', 'Comunidad Escallani, a 500m de la plaza', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(8, 'Tour a Isla Ticonata', 'Viaje en bote a la isla Ticonata con guiado incluido. Duración: 6 horas.', '70.00', 4, 1, '-15.6410000', '-69.8320000', 'Muelle principal de Capachica', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(9, 'Transporte entre comunidades', 'Servicio de transporte acuático entre las comunidades de la península.', '30.00', 4, 1, '-15.6410000', '-69.8320000', 'Muelle principal de Capachica', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(10, 'Kayak al amanecer', 'Paseo en kayak para ver el amanecer en el lago Titicaca. Incluye equipamiento y guía.', '60.00', 5, 1, '-15.6405000', '-69.8310000', 'Comunidad Cotos, a 1km del centro', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(11, 'Trekking Mirador Capachica', 'Caminata de 4 horas hasta el mirador con vistas de la península y el lago.', '40.00', 5, 1, '-15.6405000', '-69.8310000', 'Comunidad Cotos, a 1km del centro', NULL, NULL, 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(12, 'prueba 1', 'todo', '200.00', 6, 1, '-15.6438330', '-69.8323245', 'si', NULL, NULL, 15, '2025-10-27 20:40:07', '2025-10-27 20:49:36'),
(13, 'prueba 2', 'kskalal', '200.00', 8, 1, '-15.6420880', '-69.8314988', 'si', NULL, NULL, 15, '2025-10-27 21:02:18', '2025-10-27 21:02:18'),
(14, 'emprendedor1', 'dloaosk', '25.00', 10, 1, '-15.6419730', '-69.8307740', 'todo', NULL, NULL, 25, '2025-10-27 21:58:03', '2025-10-27 21:58:45'),
(15, 'emprendedor2', 'sklaoa', '26.00', 11, 1, '-15.6419730', '-69.8307740', 'todo', NULL, NULL, 12, '2025-10-27 21:58:30', '2025-10-27 21:58:30');

-- --------------------------------------------------------

--
-- Table structure for table `servicio_horarios`
--

CREATE TABLE `servicio_horarios` (
  `id` bigint UNSIGNED NOT NULL,
  `servicio_id` bigint UNSIGNED NOT NULL,
  `dia_semana` enum('lunes','martes','miercoles','jueves','viernes','sabado','domingo') COLLATE utf8mb4_unicode_ci NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `servicio_horarios`
--

INSERT INTO `servicio_horarios` (`id`, `servicio_id`, `dia_semana`, `hora_inicio`, `hora_fin`, `activo`, `created_at`, `updated_at`) VALUES
(1, 1, 'lunes', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(2, 1, 'martes', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(3, 1, 'miercoles', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(4, 1, 'jueves', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(5, 1, 'viernes', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(6, 1, 'sabado', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(7, 1, 'domingo', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(8, 2, 'lunes', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(9, 2, 'martes', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(10, 2, 'miercoles', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(11, 2, 'jueves', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(12, 2, 'viernes', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(13, 2, 'sabado', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(14, 2, 'domingo', '14:00:00', '12:00:00', 1, '2025-10-23 00:26:42', '2025-10-23 00:26:42'),
(15, 3, 'lunes', '09:00:00', '16:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(16, 3, 'miercoles', '09:00:00', '16:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(17, 3, 'viernes', '09:00:00', '16:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(18, 4, 'lunes', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(19, 4, 'martes', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(20, 4, 'miercoles', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(21, 4, 'jueves', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(22, 4, 'viernes', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(23, 4, 'sabado', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(24, 4, 'domingo', '12:00:00', '15:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(25, 5, 'viernes', '18:00:00', '21:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(26, 5, 'sabado', '18:00:00', '21:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(27, 6, 'lunes', '09:00:00', '18:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(28, 6, 'martes', '09:00:00', '18:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(29, 6, 'miercoles', '09:00:00', '18:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(30, 6, 'jueves', '09:00:00', '18:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(31, 6, 'viernes', '09:00:00', '18:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(32, 6, 'sabado', '09:00:00', '18:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(33, 7, 'martes', '10:00:00', '12:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(34, 7, 'jueves', '10:00:00', '12:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(35, 7, 'sabado', '14:00:00', '16:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(36, 8, 'lunes', '08:00:00', '14:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(37, 8, 'miercoles', '08:00:00', '14:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(38, 8, 'viernes', '08:00:00', '14:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(39, 8, 'domingo', '08:00:00', '14:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(40, 9, 'lunes', '06:00:00', '17:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(41, 9, 'martes', '06:00:00', '17:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(42, 9, 'miercoles', '06:00:00', '17:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(43, 9, 'jueves', '06:00:00', '17:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(44, 9, 'viernes', '06:00:00', '17:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(45, 9, 'sabado', '06:00:00', '17:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(46, 9, 'domingo', '08:00:00', '16:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(47, 10, 'lunes', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(48, 10, 'martes', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(49, 10, 'miercoles', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(50, 10, 'jueves', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(51, 10, 'viernes', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(52, 10, 'sabado', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(53, 10, 'domingo', '05:00:00', '08:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(54, 11, 'martes', '08:00:00', '13:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(55, 11, 'jueves', '08:00:00', '13:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(56, 11, 'sabado', '08:00:00', '13:00:00', 1, '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(65, 12, 'lunes', '09:00:00', '17:00:00', 1, '2025-10-27 20:49:36', '2025-10-27 20:49:36'),
(66, 12, 'martes', '09:00:00', '17:00:00', 1, '2025-10-27 20:49:36', '2025-10-27 20:49:36'),
(67, 13, 'lunes', '09:00:00', '17:00:00', 1, '2025-10-27 21:02:18', '2025-10-27 21:02:18'),
(69, 15, 'lunes', '09:00:00', '17:00:00', 1, '2025-10-27 21:58:30', '2025-10-27 21:58:30'),
(70, 14, 'lunes', '09:00:00', '19:00:00', 1, '2025-10-27 21:58:45', '2025-10-27 21:58:45');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint UNSIGNED NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `es_principal` tinyint(1) NOT NULL DEFAULT '0',
  `tipo_entidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad_id` bigint UNSIGNED NOT NULL,
  `orden` int NOT NULL DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `slider_descripciones`
--

CREATE TABLE `slider_descripciones` (
  `id` bigint UNSIGNED NOT NULL,
  `slider_id` bigint UNSIGNED NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferred_language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `foto_perfil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `country`, `birth_date`, `address`, `gender`, `phone`, `preferred_language`, `active`, `foto_perfil`, `last_login`, `google_id`, `avatar`) VALUES
(1, 'Administrador', 'admin@example.com', '2025-10-23 00:26:42', '$2y$12$0zdpERkmu5kI7EmSSHQpmuEAtf8mzPCe8r.5msrkj38CGOgqdOM2W', NULL, '2025-10-23 00:26:42', '2025-10-23 00:26:42', 'Perú', '1990-01-15', 'Plaza Principal s/n, Capachica, Puno', 'male', '123456789', 'es', 1, NULL, '2025-10-22 00:26:42', NULL, NULL),
(2, 'Nate', 'nate@gmail.com', '2025-10-23 00:26:42', '$2y$12$oV6OiUpJqek9RmEXdrcAieDmmBlw/MxmAMkuupcPlmzLlWJdrY9OO', NULL, '2025-10-23 00:26:42', '2025-10-23 00:26:42', 'Perú', '1995-06-20', 'Av. Arequipa 123, Lima', 'male', '987654321', 'es', 1, NULL, '2025-10-20 00:26:42', NULL, NULL),
(3, 'Emprendedor Local', 'emprendedor@example.com', '2025-10-23 00:26:42', '$2y$12$0XziIF9V5nxaZp9U3Ie8JO.ASyogSJy9XfcGLgHT9PBaSr/TvJYgG', NULL, '2025-10-23 00:26:42', '2025-10-23 00:26:42', 'Perú', '1985-12-10', 'Comunidad Llachón, Capachica, Puno', 'male', '555444333', 'es', 1, NULL, '2025-10-22 12:26:42', NULL, NULL),
(4, 'david', 'david@gmail.com', '2025-10-01 19:28:06', '$2y$12$C559cUJbi7RARqnerVyZw.NMfuo6SgP7y4SqGTdP0UFnurun3bw2m', NULL, '2025-10-23 00:27:50', '2025-10-27 21:24:02', 'Perú', '2007-10-10', 'ddsads', 'male', '94561235', 'es', 1, 'fotos_perfil/mdKyVwxtbKU6nzuJuHgHfUr5apihdiLhSjegfYGh.jpg', '2025-10-27 21:24:02', NULL, NULL),
(5, 'Jhan', 'jhan@gmail.com', '2025-10-02 19:43:54', '$2y$12$Nauuq58dI7bgoleJiz306exXRDewr2AxaymODIQHPXfUSEQv.IRqu', NULL, '2025-10-23 00:43:46', '2025-10-28 04:12:17', 'Bolivia', '2007-10-03', ',dlsa;LD,saldsa;l', 'other', '59568745', 'qu', 1, 'fotos_perfil/GjN2QCoJTMX6eSAM4hciHlYFzFNBmpm89Zhn7rpT.jpg', '2025-10-28 04:12:17', NULL, NULL),
(6, 'david2', 'david2@gmail.com', '2025-10-06 23:04:51', '$2y$12$XFXrwgJ6K0/pmS1zdfy.3u/mmGwBe6S.qP2zzlPOpdKDstkOGLqgO', NULL, '2025-10-27 04:04:38', '2025-10-27 21:28:24', 'Ecuador', '2007-10-02', 'jzjkalslsls', 'male', '967532854', 'en', 1, 'fotos_perfil/xetZ8hKL1Duw7a3WfsSeOiBmmvz6sETT8ZdhoDic.jpg', '2025-10-27 21:28:24', NULL, NULL),
(7, 'juan', 'juan@gmail.com', '2025-10-07 15:36:47', '$2y$12$96Prvn6y/BiHZpYqo3Ir4envoegylaMgT9zSUzAlB.eLtHrg.T8HG', NULL, '2025-10-27 20:36:33', '2025-10-27 21:40:12', 'Bolivia', '2007-11-06', 'kzksksls', 'male', '9875464349', 'es', 1, 'fotos_perfil/yXvwGnk1IIYIarsgWV0XXeYqtj3H3udJpYnWUPZb.jpg', '2025-10-27 21:40:12', NULL, NULL),
(8, 'ejemplo@gmail.com', 'ejemplo@gmail.com', '2025-10-20 16:07:34', '$2y$12$xFkbHQGH9xDdbZVwGSorKuCVIsbg/Uk9jEaI3OnBGSoKn7KKYMqH.', NULL, '2025-10-27 21:07:22', '2025-10-27 21:07:47', 'Perú', '2007-11-02', 'skiss', 'male', '91576767', 'es', 1, NULL, '2025-10-27 21:07:47', NULL, NULL),
(9, 'emprendedor1', 'emprendedor1@gmail.com', '2025-10-01 16:51:44', '$2y$12$sex17WYUZYgPk12Tc6iOQeRcsyBgRA6q58udmA/uqGml9Zrq0Q3ai', NULL, '2025-10-27 21:51:26', '2025-10-28 04:23:34', 'Perú', '2007-11-01', 'kdksks', 'male', '949737548', 'es', 1, 'fotos_perfil/wB1YlxOmWTlnJM8S4U9p7SH4OGv9r2NkubQvd206.jpg', '2025-10-28 04:23:34', NULL, NULL),
(10, 'emprendedor2', 'emprendedor2@gmail.com', '2025-10-01 16:52:52', '$2y$12$cjKe50oT9umyBEASI2Q95e1Kzh5krTr6Et6EtJy9w6dwKOU14TF7a', NULL, '2025-10-27 21:52:46', '2025-10-28 04:17:01', 'Bolivia', '2007-11-05', 'kdkalsls', 'male', '945767373', 'es', 1, NULL, '2025-10-28 04:17:01', NULL, NULL),
(11, 'user1', 'user1@gmail.clm', '2025-10-01 16:59:33', '$2y$12$6OKEq79jwu7baMhA.ocGAeQduEFx0UVHf6yu/OiXXExWPf7GtO1G6', NULL, '2025-10-27 21:59:27', '2025-10-28 04:15:13', 'Bolivia', '2007-11-05', 'kdlslls', 'male', '94678464', 'en', 1, NULL, '2025-10-28 04:15:13', NULL, NULL),
(12, 'user2', 'user2@gmail.com', '2025-10-16 17:00:25', '$2y$12$u2cTIltbrxPOVGppNhqlBuYw32mScjCxBUEkvhpPT60cERPIlxZJe', NULL, '2025-10-27 22:00:18', '2025-10-28 07:34:16', 'Argentina', '2007-11-01', 'kdlala', 'male', '945464646', 'es', 1, NULL, '2025-10-28 07:34:16', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_emprendedor`
--

CREATE TABLE `user_emprendedor` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `emprendedor_id` bigint UNSIGNED NOT NULL,
  `es_principal` tinyint(1) NOT NULL DEFAULT '0',
  `rol` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'administrador',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_emprendedor`
--

INSERT INTO `user_emprendedor` (`id`, `user_id`, `emprendedor_id`, `es_principal`, `rol`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 1, 'administrador', '2025-10-23 00:26:43', '2025-10-28 01:30:37'),
(2, 1, 2, 1, 'administrador', '2025-10-23 00:26:43', '2025-10-23 00:26:43'),
(3, 4, 8, 1, 'administrador', '2025-10-27 19:23:04', '2025-10-27 19:23:04'),
(4, 5, 8, 1, 'administrador', '2025-10-27 19:23:04', '2025-10-27 19:23:04'),
(5, 4, 7, 1, 'administrador', '2025-10-27 20:27:14', '2025-10-27 20:27:14'),
(6, 4, 9, 1, 'administrador', '2025-10-27 20:28:43', '2025-10-27 20:28:43'),
(7, 5, 9, 1, 'administrador', '2025-10-27 20:28:43', '2025-10-27 20:28:43'),
(8, 7, 6, 1, 'administrador', '2025-10-27 20:38:38', '2025-10-27 20:38:38'),
(9, 9, 10, 1, 'administrador', '2025-10-27 21:56:07', '2025-10-27 21:56:07'),
(10, 10, 11, 1, 'administrador', '2025-10-27 21:57:12', '2025-10-27 21:57:12'),
(11, 4, 1, 1, 'administrador', '2025-10-28 01:29:32', '2025-10-28 01:30:37'),
(12, 7, 1, 1, 'administrador', '2025-10-28 01:29:32', '2025-10-28 01:30:37'),
(13, 9, 1, 1, 'administrador', '2025-10-28 01:29:32', '2025-10-28 01:30:37'),
(14, 10, 1, 1, 'administrador', '2025-10-28 01:29:32', '2025-10-28 01:30:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asociaciones`
--
ALTER TABLE `asociaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asociaciones_municipalidad_id_foreign` (`municipalidad_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categoria_servicio`
--
ALTER TABLE `categoria_servicio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_servicio_servicio_id_foreign` (`servicio_id`),
  ADD KEY `categoria_servicio_categoria_id_foreign` (`categoria_id`);

--
-- Indexes for table `emprendedores`
--
ALTER TABLE `emprendedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emprendedores_asociacion_id_foreign` (`asociacion_id`);

--
-- Indexes for table `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `eventos_id_emprendedor_foreign` (`id_emprendedor`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `municipalidad`
--
ALTER TABLE `municipalidad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plans_creado_por_usuario_id_foreign` (`creado_por_usuario_id`),
  ADD KEY `plans_emprendedor_id_index` (`emprendedor_id`),
  ADD KEY `plans_estado_es_publico_index` (`estado`,`es_publico`);

--
-- Indexes for table `plan_dias`
--
ALTER TABLE `plan_dias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_dias_plan_id_numero_dia_unique` (`plan_id`,`numero_dia`),
  ADD KEY `plan_dias_plan_id_index` (`plan_id`),
  ADD KEY `plan_dias_plan_id_numero_dia_index` (`plan_id`,`numero_dia`),
  ADD KEY `plan_dias_plan_id_orden_index` (`plan_id`,`orden`);

--
-- Indexes for table `plan_dia_servicios`
--
ALTER TABLE `plan_dia_servicios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_dia_servicios_plan_dia_id_servicio_id_unique` (`plan_dia_id`,`servicio_id`),
  ADD KEY `plan_dia_servicios_plan_dia_id_index` (`plan_dia_id`),
  ADD KEY `plan_dia_servicios_servicio_id_index` (`servicio_id`),
  ADD KEY `plan_dia_servicios_plan_dia_id_orden_index` (`plan_dia_id`,`orden`);

--
-- Indexes for table `plan_emprendedores`
--
ALTER TABLE `plan_emprendedores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_emprendedores_plan_id_emprendedor_id_unique` (`plan_id`,`emprendedor_id`),
  ADD KEY `plan_emprendedores_plan_id_es_organizador_principal_index` (`plan_id`,`es_organizador_principal`),
  ADD KEY `plan_emprendedores_emprendedor_id_index` (`emprendedor_id`);

--
-- Indexes for table `plan_inscripciones`
--
ALTER TABLE `plan_inscripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_inscripciones_plan_id_foreign` (`plan_id`),
  ADD KEY `plan_inscripciones_user_id_foreign` (`user_id`),
  ADD KEY `plan_inscripciones_fecha_inscripcion_index` (`fecha_inscripcion`),
  ADD KEY `plan_inscripciones_fecha_inicio_plan_fecha_fin_plan_index` (`fecha_inicio_plan`,`fecha_fin_plan`),
  ADD KEY `plan_inscripciones_estado_fecha_inscripcion_index` (`estado`,`fecha_inscripcion`);

--
-- Indexes for table `plan_services`
--
ALTER TABLE `plan_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_services_plan_id_foreign` (`plan_id`),
  ADD KEY `plan_services_service_id_foreign` (`service_id`);

--
-- Indexes for table `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reservas_codigo_reserva_unique` (`codigo_reserva`),
  ADD KEY `reservas_usuario_id_foreign` (`usuario_id`);

--
-- Indexes for table `reserva_servicios`
--
ALTER TABLE `reserva_servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reserva_servicios_reserva_id_foreign` (`reserva_id`),
  ADD KEY `reserva_servicios_servicio_id_foreign` (`servicio_id`),
  ADD KEY `reserva_servicios_emprendedor_id_foreign` (`emprendedor_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servicios_emprendedor_id_foreign` (`emprendedor_id`);

--
-- Indexes for table `servicio_horarios`
--
ALTER TABLE `servicio_horarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `servicio_horarios_servicio_id_foreign` (`servicio_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sliders_tipo_entidad_entidad_id_index` (`tipo_entidad`,`entidad_id`);

--
-- Indexes for table `slider_descripciones`
--
ALTER TABLE `slider_descripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slider_descripciones_slider_id_foreign` (`slider_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_emprendedor`
--
ALTER TABLE `user_emprendedor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_emprendedor_user_id_emprendedor_id_unique` (`user_id`,`emprendedor_id`),
  ADD KEY `user_emprendedor_emprendedor_id_foreign` (`emprendedor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asociaciones`
--
ALTER TABLE `asociaciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categoria_servicio`
--
ALTER TABLE `categoria_servicio`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `emprendedores`
--
ALTER TABLE `emprendedores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `municipalidad`
--
ALTER TABLE `municipalidad`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `plan_dias`
--
ALTER TABLE `plan_dias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `plan_dia_servicios`
--
ALTER TABLE `plan_dia_servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan_emprendedores`
--
ALTER TABLE `plan_emprendedores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `plan_inscripciones`
--
ALTER TABLE `plan_inscripciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `plan_services`
--
ALTER TABLE `plan_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `reserva_servicios`
--
ALTER TABLE `reserva_servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `servicio_horarios`
--
ALTER TABLE `servicio_horarios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slider_descripciones`
--
ALTER TABLE `slider_descripciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_emprendedor`
--
ALTER TABLE `user_emprendedor`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asociaciones`
--
ALTER TABLE `asociaciones`
  ADD CONSTRAINT `asociaciones_municipalidad_id_foreign` FOREIGN KEY (`municipalidad_id`) REFERENCES `municipalidad` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categoria_servicio`
--
ALTER TABLE `categoria_servicio`
  ADD CONSTRAINT `categoria_servicio_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `categoria_servicio_servicio_id_foreign` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `emprendedores`
--
ALTER TABLE `emprendedores`
  ADD CONSTRAINT `emprendedores_asociacion_id_foreign` FOREIGN KEY (`asociacion_id`) REFERENCES `asociaciones` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_id_emprendedor_foreign` FOREIGN KEY (`id_emprendedor`) REFERENCES `emprendedores` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plans`
--
ALTER TABLE `plans`
  ADD CONSTRAINT `plans_creado_por_usuario_id_foreign` FOREIGN KEY (`creado_por_usuario_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `plans_emprendedor_id_foreign` FOREIGN KEY (`emprendedor_id`) REFERENCES `emprendedores` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `plan_dias`
--
ALTER TABLE `plan_dias`
  ADD CONSTRAINT `plan_dias_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plan_dia_servicios`
--
ALTER TABLE `plan_dia_servicios`
  ADD CONSTRAINT `plan_dia_servicios_plan_dia_id_foreign` FOREIGN KEY (`plan_dia_id`) REFERENCES `plan_dias` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_dia_servicios_servicio_id_foreign` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plan_emprendedores`
--
ALTER TABLE `plan_emprendedores`
  ADD CONSTRAINT `plan_emprendedores_emprendedor_id_foreign` FOREIGN KEY (`emprendedor_id`) REFERENCES `emprendedores` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_emprendedores_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plan_inscripciones`
--
ALTER TABLE `plan_inscripciones`
  ADD CONSTRAINT `plan_inscripciones_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_inscripciones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plan_services`
--
ALTER TABLE `plan_services`
  ADD CONSTRAINT `plan_services_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_services_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_usuario_id_foreign` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reserva_servicios`
--
ALTER TABLE `reserva_servicios`
  ADD CONSTRAINT `reserva_servicios_emprendedor_id_foreign` FOREIGN KEY (`emprendedor_id`) REFERENCES `emprendedores` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reserva_servicios_reserva_id_foreign` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reserva_servicios_servicio_id_foreign` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `servicios_emprendedor_id_foreign` FOREIGN KEY (`emprendedor_id`) REFERENCES `emprendedores` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `servicio_horarios`
--
ALTER TABLE `servicio_horarios`
  ADD CONSTRAINT `servicio_horarios_servicio_id_foreign` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `slider_descripciones`
--
ALTER TABLE `slider_descripciones`
  ADD CONSTRAINT `slider_descripciones_slider_id_foreign` FOREIGN KEY (`slider_id`) REFERENCES `sliders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_emprendedor`
--
ALTER TABLE `user_emprendedor`
  ADD CONSTRAINT `user_emprendedor_emprendedor_id_foreign` FOREIGN KEY (`emprendedor_id`) REFERENCES `emprendedores` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_emprendedor_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
