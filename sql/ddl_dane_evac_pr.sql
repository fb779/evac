-- MySQL dump 10.13  Distrib 5.7.12, for Linux (x86_64)
--
-- Host: localhost    Database: dane_evac_pr
-- ------------------------------------------------------
-- Server version	5.7.12-0ubuntu1.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actiemp`
--

DROP TABLE IF EXISTS `actiemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actiemp` (
  `nordemp` mediumint(7) unsigned NOT NULL COMMENT 'Numero de orden empresa',
  `actividad` mediumint(4) unsigned NOT NULL COMMENT 'C├│digo actividad CIIU a 4 d├¡gitos',
  KEY `numero` (`nordemp`),
  KEY `activ` (`actividad`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Actividades de la empresa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auditoria`
--

DROP TABLE IF EXISTS `auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditoria` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `numemp` bigint(10) NOT NULL,
  `ciiu3` int(4) NOT NULL,
  `tipo_usuario` varchar(2) COLLATE latin1_spanish_ci NOT NULL,
  `usuario` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `fec_mod` date NOT NULL,
  `hora_mod` time NOT NULL,
  `nom_var` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  `valor_anterior` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `valor_actual` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `tabla` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2079807 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `capitulo_i`
--

DROP TABLE IF EXISTS `capitulo_i`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capitulo_i` (
  `C1_nordemp` bigint(10) unsigned NOT NULL,
  `vigencia` mediumint(4) unsigned NOT NULL,
  `i1r1c1` tinyint(1) DEFAULT NULL,
  `i1r1c2` int(11) DEFAULT '0',
  `i1r1c3` int(11) NOT NULL DEFAULT '0',
  `i1r1c4` int(11) NOT NULL DEFAULT '0',
  `i1r3c1` tinyint(1) DEFAULT NULL,
  `i1r3c2` tinyint(1) DEFAULT NULL,
  `i1r3c3` tinyint(1) DEFAULT NULL,
  `i1r3c4` tinyint(1) DEFAULT NULL,
  `i1r3c5` tinyint(1) DEFAULT NULL,
  `i1r3c6` tinyint(1) DEFAULT NULL,
  `i1r3c7` tinyint(1) DEFAULT NULL,
  `i1r3c8` tinyint(1) DEFAULT NULL,
  `i1r3c9` text COLLATE latin1_spanish_ci,
  `i1r4c1` tinyint(1) DEFAULT NULL,
  `OBSERVACIONES` text CHARACTER SET utf8 COLLATE utf8_spanish_ci,
  PRIMARY KEY (`C1_nordemp`,`vigencia`),
  KEY `nordemp` (`C1_nordemp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `capitulo_i_displab`
--

DROP TABLE IF EXISTS `capitulo_i_displab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capitulo_i_displab` (
  `id_displab` bigint(10) unsigned NOT NULL AUTO_INCREMENT,
  `C1_nordemp` bigint(10) unsigned NOT NULL,
  `vigencia` mediumint(4) unsigned NOT NULL,
  `i1r2c1` int(10) DEFAULT NULL,
  `i1r2c2` tinyint(1) DEFAULT NULL,
  `i1r2c3` tinyint(1) DEFAULT NULL,
  `i1r2c4` tinyint(1) DEFAULT NULL,
  `i1r2c5` int(10) DEFAULT NULL,
  `i1r2c6` tinyint(1) DEFAULT NULL,
  `i1r2c7` int(10) DEFAULT NULL,
  `i1r2c8` int(10) DEFAULT NULL,
  `i1r2c9` int(10) DEFAULT NULL,
  `i1r2c10` int(10) DEFAULT NULL,
  `i1r2c11` int(10) DEFAULT NULL,
  `i1r2c12` int(10) DEFAULT NULL,
  `i1r2c13` tinyint(1) DEFAULT NULL,
  `i1r2c14` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_displab`),
  KEY `nordemp` (`C1_nordemp`,`vigencia`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caratula`
--

DROP TABLE IF EXISTS `caratula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caratula` (
  `nordemp` bigint(10) unsigned NOT NULL,
  `regional` tinyint(2) unsigned NOT NULL,
  `prioridad` tinyint(1) unsigned NOT NULL,
  `tipodoc` tinyint(1) unsigned NOT NULL,
  `numdoc` bigint(12) unsigned NOT NULL,
  `dv` tinyint(1) unsigned NOT NULL,
  `registmat` tinyint(1) unsigned NOT NULL,
  `camara` mediumint(8) unsigned NOT NULL,
  `numeroreg` char(14) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `nompropie` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `sigla` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `direccion` varchar(200) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `depto` tinyint(2) unsigned NOT NULL,
  `mpio` mediumint(3) unsigned NOT NULL,
  `telefono` varchar(12) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `aa` mediumint(6) unsigned NOT NULL,
  `fax` varchar(12) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `orgju` char(7) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `dirnotifi` varchar(200) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `depnotific` tinyint(2) unsigned NOT NULL,
  `munnotific` mediumint(3) unsigned NOT NULL,
  `telenotific` varchar(12) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `faxnotific` varchar(12) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `aanotifica` mediumint(6) unsigned NOT NULL,
  `capsocin` tinyint(3) unsigned NOT NULL,
  `capsocinpu` tinyint(3) unsigned NOT NULL,
  `capsocinpr` tinyint(3) unsigned NOT NULL,
  `capsocie` tinyint(3) unsigned NOT NULL,
  `capsociepu` tinyint(3) unsigned NOT NULL,
  `capsociepr` tinyint(3) unsigned NOT NULL,
  `estagrop` tinyint(3) unsigned NOT NULL,
  `estminero` tinyint(3) unsigned NOT NULL,
  `estservpub` tinyint(3) unsigned NOT NULL,
  `estconst` tinyint(3) unsigned NOT NULL,
  `estreshot` tinyint(3) unsigned NOT NULL,
  `esttrans` tinyint(3) unsigned NOT NULL,
  `estcomunic` tinyint(3) unsigned NOT NULL,
  `estfinanc` tinyint(3) unsigned NOT NULL,
  `estservcom` tinyint(3) unsigned NOT NULL,
  `estind` tinyint(3) unsigned NOT NULL,
  `estcom` tinyint(3) unsigned NOT NULL,
  `estser` tinyint(3) unsigned NOT NULL,
  `uniaux` tinyint(3) unsigned NOT NULL,
  `otrose` tinyint(3) unsigned NOT NULL,
  `actie` mediumint(5) unsigned NOT NULL,
  `actic` mediumint(5) unsigned NOT NULL,
  `ciiu3` mediumint(4) unsigned NOT NULL,
  `fechaconst` date NOT NULL,
  `fechahasta` date NOT NULL,
  `repleg` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `responde` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `teler` bigint(12) unsigned NOT NULL,
  `estadoact` char(9) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `otro` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `emailemp` varchar(80) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `web` varchar(80) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `emailnotif` varchar(80) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `webnotif` varchar(80) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `emailres` varchar(80) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'email de la persona que diligencia el formulario',
  `lgg` char(10) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `estcart` tinyint(1) NOT NULL,
  `correlativa` mediumint(7) NOT NULL,
  `envcorr` tinyint(4) NOT NULL,
  `vericorr` tinyint(4) NOT NULL,
  `fec_correo` datetime NOT NULL,
  `activa` tinyint(1) NOT NULL COMMENT 'Indica si la empresa esta activa (1) o inactiva (2)',
  `fechadist` date DEFAULT NULL,
  `novedad` int(11) DEFAULT NULL,
  PRIMARY KEY (`nordemp`),
  KEY `regional` (`regional`),
  KEY `depto` (`depto`),
  KEY `mpio` (`mpio`),
  KEY `orgju` (`orgju`),
  KEY `depnoti` (`depnotific`),
  KEY `munoti` (`munnotific`),
  KEY `ciiu3` (`ciiu3`),
  KEY `estadoemp` (`estadoact`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casos`
--

DROP TABLE IF EXISTS `casos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casos` (
  `caso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Secuencial casos',
  `condicion` longtext COLLATE utf8_spanish_ci NOT NULL COMMENT 'formula',
  `descripcion` longtext COLLATE utf8_spanish_ci NOT NULL COMMENT 'Descripcion caso',
  PRIMARY KEY (`caso`)
) ENGINE=MyISAM AUTO_INCREMENT=260 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ciiu3`
--

DROP TABLE IF EXISTS `ciiu3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ciiu3` (
  `CODIGO` varchar(4) COLLATE latin1_spanish_ci NOT NULL DEFAULT '0',
  `DESCRIP` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`CODIGO`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `control`
--

DROP TABLE IF EXISTS `control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `control` (
  `nordemp` bigint(10) unsigned NOT NULL,
  `vigencia` mediumint(4) unsigned NOT NULL,
  `estado` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `usuario` char(8) COLLATE latin1_spanish_ci NOT NULL,
  `usuariodt` char(8) COLLATE latin1_spanish_ci NOT NULL,
  `usuarioss` char(8) COLLATE latin1_spanish_ci NOT NULL,
  `ciiu3` mediumint(4) NOT NULL DEFAULT '0',
  `m1` tinyint(1) NOT NULL DEFAULT '0',
  `m2` tinyint(1) NOT NULL DEFAULT '0',
  `m3` tinyint(1) NOT NULL DEFAULT '0',
  `m4` tinyint(1) NOT NULL DEFAULT '0',
  `m5` tinyint(1) NOT NULL DEFAULT '0',
  `m6` tinyint(1) NOT NULL DEFAULT '0',
  `m7` tinyint(1) NOT NULL DEFAULT '0',
  `rese` tinyint(1) NOT NULL DEFAULT '0',
  `prioridad` tinyint(1) NOT NULL DEFAULT '0',
  `novedad` tinyint(2) NOT NULL DEFAULT '0',
  `codsede` tinyint(2) NOT NULL DEFAULT '0',
  `fecdist` date NOT NULL,
  `fecdig` date NOT NULL,
  `fecrev` date NOT NULL,
  `fecacept` date NOT NULL,
  `aceptadc` date NOT NULL COMMENT 'Fecha acepta DANE central',
  `prio2` tinyint(1) NOT NULL DEFAULT '0',
  `acceso` char(3) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Indica a que rol se le permite acceso a modificaci├│n (FU(fuente), CR(cr├¡tico), DC(dane central))',
  PRIMARY KEY (`nordemp`,`vigencia`),
  KEY `nordemp` (`nordemp`),
  KEY `estado` (`estado`),
  KEY `usuario` (`usuario`),
  KEY `usuarioR` (`usuarioss`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `devoluciones`
--

DROP TABLE IF EXISTS `devoluciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devoluciones` (
  `vigencia` mediumint(4) NOT NULL DEFAULT '0' COMMENT 'Periodo Devoluci├│n',
  `nordemp` bigint(10) NOT NULL DEFAULT '0' COMMENT 'Numero empresa',
  `observa` longtext CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Observaci├│n de la devoluci├│n',
  `codsede` int(2) NOT NULL DEFAULT '0' COMMENT 'Sede fuente',
  `tipo` char(5) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL COMMENT '(DV)-Devuelto (RV)-Reenviado',
  `coddev` char(7) COLLATE latin1_bin NOT NULL COMMENT 'Quien devuelve el formulario',
  `codcrit` char(8) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'C├│digo de cr├¡tico',
  `fecha` date NOT NULL COMMENT 'Fecha Devoluci├│n/Reenvio',
  KEY `periodo` (`vigencia`,`nordemp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `divipola`
--

DROP TABLE IF EXISTS `divipola`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `divipola` (
  `dpto` tinyint(2) unsigned NOT NULL,
  `muni` mediumint(3) unsigned NOT NULL,
  `ndpto` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `nmuni` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`dpto`,`muni`),
  KEY `dpto` (`dpto`),
  KEY `mpio` (`muni`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edit_eam`
--

DROP TABLE IF EXISTS `edit_eam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edit_eam` (
  `nordemp` mediumint(7) NOT NULL DEFAULT '0' COMMENT 'Numero de orden',
  `novedad` mediumint(2) NOT NULL DEFAULT '0' COMMENT 'novedad',
  `pertotal` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Personal Total',
  `peraux` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Personal unidades auxiliares',
  `prodbruta` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Producci├│n bruta',
  `prodind` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Producci├│n industrial',
  `totvtas` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Total ventas',
  `vtaspais` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Ventas en el pa├¡s',
  `vtasext` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Ventas en el exterior',
  `otrosing` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Otros Ingresos',
  `oingvtas` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Otros Ing. vtas MP.....',
  `maqeq` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Maquinaria y equipo',
  `eqinfo` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Equipo de inform├ítica y telecomunicaci├│n',
  `pertot2009` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Personal total 2009',
  `pertot2010` bigint(13) NOT NULL DEFAULT '0' COMMENT 'Personal total 2010',
  `enmarcha` char(2) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Proyectos en marcha',
  `desc_novedad` char(80) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Descripci├│n novedad',
  PRIMARY KEY (`nordemp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Comparaci├│n EAMvsEDIT';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edit_eas`
--

DROP TABLE IF EXISTS `edit_eas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edit_eas` (
  `nordemp` bigint(10) NOT NULL,
  `novedad` int(2) NOT NULL COMMENT 'NOvedad Anuales',
  `personal` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Personal Abuales',
  `ingresos` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Ingresos Anuales',
  `otrosing` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Otros ingresos anuales',
  `maqyeq` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Maq. y Eq. Anuales',
  `eqinf` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Eq. Info. Anuales',
  `software` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Software Anuales',
  `pertot_edit_a1` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Personal Edit P. anterior',
  `pertot_edit_a2` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Personal Edit P. anterior',
  `vtas_edit_a1` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Vtas Edit P. Anterior',
  `pertot_edit_i1` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Personal Industria P. Anterior',
  `pertot_edit_i2` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Personal Industria P. Anterior',
  `vtas_edit_i1` text CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Vtas Edit Industria P. Anterior',
  `enmarcha` char(2) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Proyectos en marcha',
  `novant` int(2) NOT NULL COMMENT 'Novedad EDIT Anterior',
  `dirbase` char(10) NOT NULL COMMENT 'INvestigaci├│m'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadoact`
--

DROP TABLE IF EXISTS `estadoact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadoact` (
  `codigo` char(2) COLLATE latin1_spanish_ci NOT NULL,
  `estado` varchar(80) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `idestados` tinyint(2) unsigned NOT NULL,
  `desc_estado` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idestados`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fechaacepta`
--

DROP TABLE IF EXISTS `fechaacepta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fechaacepta` (
  `nordemp` bigint(9) NOT NULL,
  `acepta` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fechadig`
--

DROP TABLE IF EXISTS `fechadig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fechadig` (
  `nordemp` bigint(9) NOT NULL,
  `digita` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fecharev`
--

DROP TABLE IF EXISTS `fecharev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fecharev` (
  `nordemp` bigint(9) NOT NULL,
  `revision` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hoja_casos`
--

DROP TABLE IF EXISTS `hoja_casos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hoja_casos` (
  `nordemp` bigint(12) NOT NULL DEFAULT '0' COMMENT 'Numero de Orden',
  `C1` tinyint(1) DEFAULT NULL COMMENT 'Caso 1',
  `C2` tinyint(1) DEFAULT NULL COMMENT 'Caso 2',
  `C3` tinyint(1) DEFAULT NULL COMMENT 'Caso 3',
  `C4` tinyint(1) DEFAULT NULL COMMENT 'Caso 4',
  `C5` tinyint(1) DEFAULT NULL COMMENT 'Caso 5',
  `C6` tinyint(1) DEFAULT NULL COMMENT 'Caso 6',
  `C7` tinyint(1) DEFAULT NULL COMMENT 'Caso 7',
  `C8` tinyint(1) DEFAULT NULL COMMENT 'Caso 8',
  `C9` tinyint(1) DEFAULT NULL COMMENT 'Caso 9',
  `C10` tinyint(1) DEFAULT NULL COMMENT 'Caso 10',
  `C11` tinyint(1) DEFAULT NULL COMMENT 'Caso 11',
  `C12` tinyint(1) DEFAULT NULL COMMENT 'Caso 12',
  `C13` tinyint(1) DEFAULT NULL COMMENT 'Caso 13',
  `C14` tinyint(1) DEFAULT NULL COMMENT 'Caso 14',
  `C15` tinyint(1) DEFAULT NULL COMMENT 'Caso 15',
  `C16` tinyint(1) DEFAULT NULL COMMENT 'Caso 16',
  `C17` tinyint(1) DEFAULT NULL COMMENT 'Caso 17',
  `C18` tinyint(1) DEFAULT NULL COMMENT 'Caso 18',
  `C19` tinyint(1) DEFAULT NULL COMMENT 'Caso 19',
  `C20` tinyint(1) DEFAULT NULL COMMENT 'Caso 20',
  `C21` tinyint(1) DEFAULT NULL COMMENT 'Caso 21',
  `C22` tinyint(1) DEFAULT NULL COMMENT 'Caso 22',
  `C23` tinyint(1) DEFAULT NULL COMMENT 'Caso 23',
  `C24` tinyint(1) DEFAULT NULL COMMENT 'Caso 24',
  `C25` tinyint(1) DEFAULT NULL COMMENT 'Caso 25',
  `C26` tinyint(1) DEFAULT NULL COMMENT 'Caso 26',
  `C27` tinyint(1) DEFAULT NULL COMMENT 'Caso 27',
  `C28` tinyint(1) DEFAULT NULL COMMENT 'Caso 28',
  `C29` tinyint(1) DEFAULT NULL COMMENT 'Caso 29',
  `C30` tinyint(1) DEFAULT NULL COMMENT 'Caso 30',
  `C31` tinyint(1) DEFAULT NULL COMMENT 'Caso 31',
  `C32` tinyint(1) DEFAULT NULL COMMENT 'Caso 32',
  `C33` tinyint(1) DEFAULT NULL COMMENT 'Caso 33',
  `C34` tinyint(1) DEFAULT NULL COMMENT 'Caso 34',
  `C35` tinyint(1) DEFAULT NULL COMMENT 'Caso 35',
  `C36` tinyint(1) DEFAULT NULL COMMENT 'Caso 36',
  `C37` tinyint(1) DEFAULT NULL COMMENT 'Caso 37',
  `C38` tinyint(1) DEFAULT NULL COMMENT 'Caso 38',
  `C39` tinyint(1) DEFAULT NULL COMMENT 'Caso 39',
  `C40` tinyint(1) DEFAULT NULL COMMENT 'Caso 40',
  `C41` tinyint(1) DEFAULT NULL COMMENT 'Caso 41',
  `C42` tinyint(1) DEFAULT NULL COMMENT 'Caso 42',
  `C43` tinyint(1) DEFAULT NULL COMMENT 'Caso 43',
  `C44` tinyint(1) DEFAULT NULL COMMENT 'Caso 44',
  `C45` tinyint(1) DEFAULT NULL COMMENT 'Caso 45',
  `C46` tinyint(1) DEFAULT NULL COMMENT 'Caso 46',
  `C47` tinyint(1) DEFAULT NULL COMMENT 'Caso 47',
  `C48` tinyint(1) DEFAULT NULL COMMENT 'Caso 48',
  `C49` tinyint(1) DEFAULT NULL COMMENT 'Caso 49',
  `C50` tinyint(1) DEFAULT NULL COMMENT 'Caso 50',
  `C51` tinyint(1) DEFAULT NULL COMMENT 'Caso 51',
  `C52` tinyint(1) DEFAULT NULL COMMENT 'Caso 52',
  `C53` tinyint(1) DEFAULT NULL COMMENT 'Caso 53',
  `C54` tinyint(1) DEFAULT NULL COMMENT 'Caso 54',
  `C55` tinyint(1) DEFAULT NULL COMMENT 'Caso 55',
  `C56` tinyint(1) DEFAULT NULL COMMENT 'Caso 56',
  `C57` tinyint(1) DEFAULT NULL COMMENT 'Caso 57',
  `C58` tinyint(1) DEFAULT NULL COMMENT 'Caso 58',
  `C59` tinyint(1) DEFAULT NULL COMMENT 'Caso 59',
  `C60` tinyint(1) DEFAULT NULL COMMENT 'Caso 60',
  `C61` tinyint(1) DEFAULT NULL COMMENT 'Caso 61',
  `C62` tinyint(1) DEFAULT NULL COMMENT 'Caso 62',
  `C63` tinyint(1) DEFAULT NULL COMMENT 'Caso 63',
  `C64` tinyint(1) DEFAULT NULL COMMENT 'Caso 64',
  `C65` tinyint(1) DEFAULT NULL COMMENT 'Caso 65',
  `C66` tinyint(1) DEFAULT NULL COMMENT 'Caso 66',
  `C67` tinyint(1) DEFAULT NULL COMMENT 'Caso 67',
  `C68` tinyint(1) DEFAULT NULL COMMENT 'Caso 68',
  `C69` tinyint(1) DEFAULT NULL COMMENT 'Caso 69',
  `C70` tinyint(1) DEFAULT NULL COMMENT 'Caso 70',
  `C71` tinyint(1) DEFAULT NULL COMMENT 'Caso 71',
  `C72` tinyint(1) DEFAULT NULL COMMENT 'Caso 72',
  `C73` tinyint(1) DEFAULT NULL COMMENT 'Caso 73',
  `C74` tinyint(1) DEFAULT NULL COMMENT 'Caso 74',
  `C75` tinyint(1) DEFAULT NULL COMMENT 'Caso 75',
  `C76` tinyint(1) DEFAULT NULL COMMENT 'Caso 76',
  `C77` tinyint(1) DEFAULT NULL COMMENT 'Caso 77',
  `C78` tinyint(1) DEFAULT NULL COMMENT 'Caso 78',
  `C79` tinyint(1) DEFAULT NULL COMMENT 'Caso 79',
  `C80` tinyint(1) DEFAULT NULL COMMENT 'Caso 80',
  `C81` tinyint(1) DEFAULT NULL COMMENT 'Caso 81',
  `C82` tinyint(1) DEFAULT NULL COMMENT 'Caso 82',
  `C83` tinyint(1) DEFAULT NULL COMMENT 'Caso 83',
  `C84` tinyint(1) DEFAULT NULL COMMENT 'Caso 84',
  `C85` tinyint(1) DEFAULT NULL COMMENT 'Caso 85',
  `C86` tinyint(1) DEFAULT NULL COMMENT 'Caso 86',
  `C87` tinyint(1) DEFAULT NULL COMMENT 'Caso 87',
  `C88` tinyint(1) DEFAULT NULL COMMENT 'Caso 88',
  `C89` tinyint(1) DEFAULT NULL COMMENT 'Caso 89',
  `C90` tinyint(1) DEFAULT NULL COMMENT 'Caso 90',
  `C91` tinyint(1) DEFAULT NULL COMMENT 'Caso 91',
  `C92` tinyint(1) DEFAULT NULL COMMENT 'Caso 92',
  `C93` tinyint(1) DEFAULT NULL COMMENT 'Caso 93',
  `C94` tinyint(1) DEFAULT NULL COMMENT 'Caso 94',
  `C95` tinyint(1) DEFAULT NULL COMMENT 'Caso 95',
  `C96` tinyint(1) DEFAULT NULL COMMENT 'Caso 96',
  `C97` tinyint(1) DEFAULT NULL COMMENT 'Caso 97',
  `C98` tinyint(1) DEFAULT NULL COMMENT 'Caso 98',
  `C99` tinyint(1) DEFAULT NULL COMMENT 'Caso 99',
  `C100` tinyint(1) DEFAULT NULL COMMENT 'Caso 100',
  `C101` tinyint(1) DEFAULT NULL COMMENT 'Caso 101',
  `C102` tinyint(1) DEFAULT NULL COMMENT 'Caso 102',
  `C103` tinyint(1) DEFAULT NULL COMMENT 'Caso 103',
  `C104` tinyint(1) DEFAULT NULL COMMENT 'Caso 104',
  `C105` tinyint(1) DEFAULT NULL COMMENT 'Caso 105',
  `C106` tinyint(1) DEFAULT NULL COMMENT 'Caso 106',
  `C107` tinyint(1) DEFAULT NULL COMMENT 'Caso 107',
  `C108` tinyint(1) DEFAULT NULL COMMENT 'Caso 108',
  `C109` tinyint(1) DEFAULT NULL COMMENT 'Caso 109',
  `C110` tinyint(1) DEFAULT NULL COMMENT 'Caso 110',
  `C111` tinyint(1) DEFAULT NULL COMMENT 'Caso 111',
  `C112` tinyint(1) DEFAULT NULL COMMENT 'Caso 112',
  `C113` tinyint(1) DEFAULT NULL COMMENT 'Caso 113',
  `C114` tinyint(1) DEFAULT NULL COMMENT 'Caso 114',
  `C115` tinyint(1) DEFAULT NULL COMMENT 'Caso 115',
  `C116` tinyint(1) DEFAULT NULL COMMENT 'Caso 116',
  `C117` tinyint(1) DEFAULT NULL COMMENT 'Caso 117',
  `C118` tinyint(1) DEFAULT NULL COMMENT 'Caso 118',
  `C119` tinyint(1) DEFAULT NULL COMMENT 'Caso 119',
  `C120` tinyint(1) DEFAULT NULL COMMENT 'Caso 120',
  `C121` tinyint(1) DEFAULT NULL COMMENT 'Caso 121',
  `C122` tinyint(1) DEFAULT NULL COMMENT 'Caso 122',
  `C123` tinyint(1) DEFAULT NULL COMMENT 'Caso 123',
  `C124` tinyint(1) DEFAULT NULL COMMENT 'Caso 124',
  `C125` tinyint(1) DEFAULT NULL COMMENT 'Caso 125',
  `C126` tinyint(1) DEFAULT NULL COMMENT 'Caso 126',
  `C127` tinyint(1) DEFAULT NULL COMMENT 'Caso 127',
  `C128` tinyint(1) DEFAULT NULL COMMENT 'Caso 128',
  `C129` tinyint(1) DEFAULT NULL COMMENT 'Caso 129',
  `C130` tinyint(1) DEFAULT NULL COMMENT 'Caso 130',
  `C131` tinyint(1) DEFAULT NULL COMMENT 'Caso 131',
  `C132` tinyint(1) DEFAULT NULL COMMENT 'Caso 132',
  `C133` tinyint(1) DEFAULT NULL COMMENT 'Caso 133',
  `C134` tinyint(1) DEFAULT NULL COMMENT 'Caso 134',
  `C135` tinyint(1) DEFAULT NULL COMMENT 'Caso 135',
  `C136` tinyint(1) DEFAULT NULL COMMENT 'Caso 136',
  `C137` tinyint(1) DEFAULT NULL COMMENT 'Caso 137',
  `C138` tinyint(1) DEFAULT NULL COMMENT 'Caso 138',
  `C139` tinyint(1) DEFAULT NULL COMMENT 'Caso 139',
  `C140` tinyint(1) DEFAULT NULL COMMENT 'Caso 140',
  `C141` tinyint(1) DEFAULT NULL COMMENT 'Caso 141',
  `C142` tinyint(1) DEFAULT NULL COMMENT 'Caso 142',
  `C143` tinyint(1) DEFAULT NULL COMMENT 'Caso 143',
  `C144` tinyint(1) DEFAULT NULL COMMENT 'Caso 144',
  `C145` tinyint(1) DEFAULT NULL COMMENT 'Caso 145',
  `C146` tinyint(1) DEFAULT NULL COMMENT 'Caso 146',
  `C147` tinyint(1) DEFAULT NULL COMMENT 'Caso 147',
  `C148` tinyint(1) DEFAULT NULL COMMENT 'Caso 148',
  `C149` tinyint(1) DEFAULT NULL COMMENT 'Caso 149',
  `C150` tinyint(1) DEFAULT NULL COMMENT 'Caso 150',
  `C151` tinyint(1) DEFAULT NULL COMMENT 'Caso 151',
  `C152` tinyint(1) DEFAULT NULL COMMENT 'Caso 152',
  `C153` tinyint(1) DEFAULT NULL COMMENT 'Caso 153',
  `C154` tinyint(1) DEFAULT NULL COMMENT 'Caso 154',
  `C155` tinyint(1) DEFAULT NULL COMMENT 'Caso 155',
  `C156` tinyint(1) DEFAULT NULL COMMENT 'Caso 156',
  `C157` tinyint(1) DEFAULT NULL COMMENT 'Caso 157',
  `C158` tinyint(1) DEFAULT NULL COMMENT 'Caso 158',
  `C159` tinyint(1) DEFAULT NULL COMMENT 'Caso 159',
  `C160` tinyint(1) DEFAULT NULL COMMENT 'Caso 160',
  `C161` tinyint(1) DEFAULT NULL COMMENT 'Caso 161',
  `C162` tinyint(1) DEFAULT NULL COMMENT 'Caso 162',
  `C163` tinyint(1) DEFAULT NULL COMMENT 'Caso 163',
  `C164` tinyint(1) DEFAULT NULL COMMENT 'Caso 164',
  `C165` tinyint(1) DEFAULT NULL COMMENT 'Caso 165',
  `C166` tinyint(1) DEFAULT NULL COMMENT 'Caso 166',
  `C167` tinyint(1) DEFAULT NULL COMMENT 'Caso 167',
  `C168` tinyint(1) DEFAULT NULL COMMENT 'Caso 168',
  `C169` tinyint(1) DEFAULT NULL COMMENT 'Caso 169',
  `C170` tinyint(1) DEFAULT NULL COMMENT 'Caso 170',
  `C171` tinyint(1) DEFAULT NULL COMMENT 'Caso 171',
  `C172` tinyint(1) DEFAULT NULL COMMENT 'Caso 172',
  `C173` tinyint(1) DEFAULT NULL COMMENT 'Caso 173',
  `C174` tinyint(1) DEFAULT NULL COMMENT 'Caso 174',
  `C175` tinyint(1) DEFAULT NULL COMMENT 'Caso 175',
  `C176` tinyint(1) DEFAULT NULL COMMENT 'Caso 176',
  `C177` tinyint(1) DEFAULT NULL COMMENT 'Caso 177',
  `C178` tinyint(1) DEFAULT NULL COMMENT 'Caso 178',
  `C179` tinyint(1) DEFAULT NULL COMMENT 'Caso 179',
  `C180` tinyint(1) DEFAULT NULL COMMENT 'Caso 180',
  `C181` tinyint(1) DEFAULT NULL COMMENT 'Caso 181',
  `C182` tinyint(1) DEFAULT NULL COMMENT 'Caso 182',
  `C183` tinyint(1) DEFAULT NULL COMMENT 'Caso 183',
  `C184` tinyint(1) DEFAULT NULL COMMENT 'Caso 184',
  `C185` tinyint(1) DEFAULT NULL COMMENT 'Caso 185',
  `C186` tinyint(1) DEFAULT NULL COMMENT 'Caso 186',
  `C187` tinyint(1) DEFAULT NULL COMMENT 'Caso 187',
  `C188` tinyint(1) DEFAULT NULL COMMENT 'Caso 188',
  `C189` tinyint(1) DEFAULT NULL COMMENT 'Caso 189',
  `C190` tinyint(1) DEFAULT NULL COMMENT 'Caso 190',
  `C191` tinyint(1) DEFAULT NULL COMMENT 'Caso 191',
  `C192` tinyint(1) DEFAULT NULL COMMENT 'Caso 192',
  `C193` tinyint(1) DEFAULT NULL COMMENT 'Caso 193',
  `C194` tinyint(1) DEFAULT NULL COMMENT 'Caso 194',
  `C195` tinyint(1) DEFAULT NULL COMMENT 'Caso 195',
  `C196` tinyint(1) DEFAULT NULL COMMENT 'Caso 196',
  `C197` tinyint(1) DEFAULT NULL COMMENT 'Caso 197',
  `C198` tinyint(1) DEFAULT NULL COMMENT 'Caso 198',
  `C199` tinyint(1) DEFAULT NULL COMMENT 'Caso 199',
  `C200` tinyint(1) DEFAULT NULL COMMENT 'Caso 200',
  `C201` tinyint(1) DEFAULT NULL COMMENT 'Caso 201',
  `C202` tinyint(1) DEFAULT NULL COMMENT 'Caso 202',
  `C203` tinyint(1) DEFAULT NULL COMMENT 'Caso 203',
  `C204` tinyint(1) DEFAULT NULL COMMENT 'Caso 204',
  `C205` tinyint(1) DEFAULT NULL COMMENT 'Caso 205',
  `C206` tinyint(1) DEFAULT NULL COMMENT 'Caso 206',
  `C207` tinyint(1) DEFAULT NULL COMMENT 'Caso 207',
  `C208` tinyint(1) DEFAULT NULL COMMENT 'Caso 208',
  `C209` tinyint(1) DEFAULT NULL COMMENT 'Caso 209',
  `C210` tinyint(1) DEFAULT NULL COMMENT 'Caso 210',
  `C211` tinyint(1) DEFAULT NULL COMMENT 'Caso 211',
  `C212` tinyint(1) DEFAULT NULL COMMENT 'Caso 212',
  `C213` tinyint(1) DEFAULT NULL COMMENT 'Caso 213',
  `C214` tinyint(1) DEFAULT NULL COMMENT 'Caso 214',
  `C215` tinyint(1) DEFAULT NULL COMMENT 'Caso 215',
  `C216` tinyint(1) DEFAULT NULL COMMENT 'Caso 216',
  `C217` tinyint(1) DEFAULT NULL COMMENT 'Caso 217',
  `C218` tinyint(1) DEFAULT NULL COMMENT 'Caso 218',
  `C219` tinyint(1) DEFAULT NULL COMMENT 'Caso 219',
  `C220` tinyint(1) DEFAULT NULL COMMENT 'Caso 220',
  PRIMARY KEY (`nordemp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `novedades`
--

DROP TABLE IF EXISTS `novedades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `novedades` (
  `idnovedades` tinyint(2) unsigned NOT NULL,
  `desc_novedad` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`idnovedades`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `observaciones`
--

DROP TABLE IF EXISTS `observaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observaciones` (
  `vigencia` mediumint(4) NOT NULL COMMENT 'Periodo',
  `nordemp` bigint(8) NOT NULL COMMENT 'Nro de Orden',
  `usuario` char(8) COLLATE utf8_spanish_ci NOT NULL COMMENT 'usuario que ingresa la observacion',
  `capitulo` tinyint(1) NOT NULL COMMENT 'capitulo',
  `observacion` longtext COLLATE utf8_spanish_ci NOT NULL COMMENT 'Observacion',
  `fecha` date NOT NULL COMMENT 'Fecha observacion',
  KEY `nordemp` (`nordemp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `organiza`
--

DROP TABLE IF EXISTS `organiza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organiza` (
  `codigo` char(7) COLLATE latin1_spanish_ci NOT NULL,
  `nombre` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `periodoActivo`
--

DROP TABLE IF EXISTS `periodoActivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodoActivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codperiodo` varchar(45) NOT NULL,
  `estperiodo` varchar(45) NOT NULL,
  `nomperiodo` varchar(45) NOT NULL,
  `numperiodo` int(11) NOT NULL,
  `anioperiodo` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recvtas`
--

DROP TABLE IF EXISTS `recvtas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recvtas` (
  `nordemp` bigint(10) NOT NULL,
  `I3R1C1` bigint(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regionales`
--

DROP TABLE IF EXISTS `regionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regionales` (
  `dpto` int(2) unsigned NOT NULL,
  `codis` tinyint(2) unsigned NOT NULL,
  `nombre` char(30) COLLATE latin1_spanish_ci NOT NULL,
  `activo` tinyint(1) unsigned NOT NULL,
  `codireg` int(2) unsigned NOT NULL,
  `asistente` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `telefono` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `direccion` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `correo` char(80) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`codis`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `soportes`
--

DROP TABLE IF EXISTS `soportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soportes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numemp` bigint(10) NOT NULL,
  `soporte_binario` mediumblob NOT NULL,
  `soporte_nombre` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `soporte_peso` varchar(15) COLLATE latin1_spanish_ci NOT NULL,
  `soporte_tipo` varchar(25) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4733 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `soportesb`
--

DROP TABLE IF EXISTS `soportesb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soportesb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numemp` bigint(10) NOT NULL,
  `soporte_binario` mediumblob NOT NULL,
  `soporte_nombre` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
  `soporte_peso` varchar(15) COLLATE latin1_spanish_ci NOT NULL,
  `soporte_tipo` varchar(25) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1744 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipoPeriodo`
--

DROP TABLE IF EXISTS `tipoPeriodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoPeriodo` (
  `idperiodo` int(11) NOT NULL AUTO_INCREMENT,
  `codPeriodo` varchar(45) NOT NULL,
  `descperiodo` varchar(45) NOT NULL,
  PRIMARY KEY (`idperiodo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `ident` char(20) COLLATE latin1_spanish_ci NOT NULL,
  `nombre` varchar(80) COLLATE latin1_spanish_ci NOT NULL,
  `tipo` char(2) COLLATE latin1_spanish_ci NOT NULL,
  `numemp` bigint(10) NOT NULL,
  `clave` char(16) COLLATE latin1_spanish_ci NOT NULL,
  `fcrea` date NOT NULL,
  `fexpi` date NOT NULL,
  `primera` tinyint(1) NOT NULL,
  `region` tinyint(2) NOT NULL,
  `ciiu3` mediumint(4) NOT NULL,
  `email` varchar(80) COLLATE latin1_spanish_ci NOT NULL,
  KEY `ident` (`ident`),
  KEY `numemp` (`numemp`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-10 19:52:35