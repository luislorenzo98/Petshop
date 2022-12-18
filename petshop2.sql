-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-12-2022 a las 03:22:55
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `petshop2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(90) NOT NULL,
  `url_categoria` varchar(90) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `url_categoria`) VALUES
(1, 'COMIDAS', 'food.png'),
(2, 'ACCESORIOS', 'accesories.png'),
(3, 'JUGUETES', 'toy.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `usuario` int(11) NOT NULL,
  `producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(90) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `precio` double NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `url_producto` varchar(90) NOT NULL,
  `favorito` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `id_categoria`, `url_producto`, `favorito`) VALUES
(1, 'AUTHORITY SALUD INTESTINAL ALIMENTO PARA GATOS ADULTOS', 'Comida para gatos de buena calidad con salmón y arroz como ingredientes. 6 KG', 25, 1, 'authority1.png', 0),
(2, 'ROYAL CANIN', 'Alimento para gatos adultos para ayudar al cuidado de la piel y el pelo. 6 KG', 20, 1, 'royal-canin1.png', 0),
(3, 'TK-PET IRIS DELUXE CUNA AZUL PARA PERROS', 'La cama para perros TK-Pet Iris tipo cuna es un accesorio de gran calidad ideal para los animales más frioleros a los que les gusta dormir acurrucados.', 40, 2, 'camaperro.png', 0),
(4, 'MELLERWARE PETTO COMEDERO AUTOMÁTICO BLANCO PARA MASCOTAS', 'Con PETTO Eat solo tienes que establecer un plan de alimentación diario o semanal y el comedero automático se encargará del resto, asegurando unos horarios de comida con precisión y regularidad totalmente personalizables.', 80, 2, 'comedero.png', 0),
(5, 'THE CAT BAND SPARKLING BALL JUGUETE PARA GATO', 'Las pelotas de The Cat Band son uno de los juguetes favoritos para tu gato, porque le proporciona mucha actividad física, juego y diversión.', 4, 3, 'bolas.png', 0),
(6, 'TK-PET SANTI SET DE JUGUETES AZUL PARA GATOS', 'TK-Pet Santi se trata de un set surtido con pelotas de diferentes texturas y formas y ratones de peluche.', 10, 3, 'juguete.png', 0),
(7, 'PRO PLAN MEDIUM ADULT OPTIBALANCE POLLO PIENSO PARA PERROS', 'Contiene nutrientes clave como los ácidos grasos omega 3 y 6, para mantener una piel salud. 3KG', 18, 1, 'pienso-purina.png', 0),
(8, 'DOGZILLA ADULT POLLO Y ARROZ PIENSO', 'El pienso diario de pollo y arroz El alimento para perros Dogzilla Adult con pollo es un pienso específicamente diseñado para perros adultos de cualquier raza. 3KG', 20, 1, 'dogzilla.png', 0),
(9, 'CATSHION PATROL RASCADOR PARA GATOS', 'Catshion tiene para tu felino un innovador rascador de cartón con la forma de patrulla felina, su lúdica forma de un gato atrapará la atención de tu querida mascota. Y, por supuesto podrá posarse o tomar sus siestas de manera placida.', 16, 2, 'rascadorgatos.png', 0),
(10, 'TK-PET LIMPIADOR MULTIUSOS BIOLÓGICO PARA EL HOGAR', 'El limpiador multiusos biológico TK-Pet Home está diseñado para poder limpiar la casa de forma profunda y combatir los malos olores.', 5, 2, 'limpiador.png', 0),
(11, 'SUMMER VIBES PATATAS FRITAS DE PELUCHE PARA PERROS', 'Summer Vibes es un juguete que le aportará horas de mucha diversión y compañía a tu perro. Es revestido con felpa, un tejido de calidad muy resistente a las mordidas y jalones. ', 6, 3, 'peluche.png', 0),
(12, 'FRISBEE EASYGLIDE PARA PERROS COLOR VARIADO', 'te presentamos este magnífico frisbee para perros con el cual podrás jugar junto a tu mascota el tiempo que quieras y ambos os divertireis mucho.', 13, 3, 'frisbee.png', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(191) DEFAULT NULL,
  `rol` smallint(1) NOT NULL,
  `id_administrador` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `foto` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `correo`, `contrasena`, `rol`, `id_administrador`, `id_usuario`, `foto`) VALUES
(64, 'paco@gmail.com', '$2y$10$qxdMez6rfIXh6n1xaV6hWOvpzThAaWdopKk6B2VcND7srz2lBXaES', 2, NULL, 0, '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD KEY `fk_favorito_producto` (`producto`),
  ADD KEY `fk_favorito_usuario` (`usuario`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `fk_favorito_producto` FOREIGN KEY (`producto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_favorito_usuario` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
