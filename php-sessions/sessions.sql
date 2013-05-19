# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.28)
# Database: sso
# Generation Time: 2013-05-19 19:08:15 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table session
# ------------------------------------------------------------

CREATE TABLE `session` (
  `s_token` varchar(256) NOT NULL DEFAULT '',
  `s_uid` int(11) NOT NULL DEFAULT '0',
  `s_data` longtext,
  `s_dateadded` int(11) DEFAULT NULL,
  `s_lastaccess` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`s_token`),
  UNIQUE KEY `uid` (`s_uid`,`s_dateadded`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;

INSERT INTO `session` (`s_token`, `s_uid`, `s_data`, `s_dateadded`, `s_lastaccess`)
VALUES
	('c7dfa93ad535928cd79891d32cdfd558a1786c4f5890835642f7ebb6c90c3edc',1,NULL,1368959653,1368959654),
	('198jvr8736k681c8ee2lngfvs4',0,'s:438:\"user|O:8:\"stdClass\":8:{s:3:\"uid\";s:1:\"2\";s:8:\"username\";s:6:\"maanas\";s:4:\"role\";a:8:{i:5;s:12:\"code manager\";i:4;s:13:\"media manager\";i:6;s:19:\"opportunity manager\";i:9;s:14:\"remote manager\";i:3;s:12:\"site manager\";i:8;s:20:\"subscription manager\";i:7;s:14:\"viewer manager\";i:2;s:18:\"authenticated user\";}s:5:\"fname\";s:6:\"Maanas\";s:5:\"lname\";s:4:\"Royy\";s:5:\"email\";s:21:\"maanas.royy@gmail.com\";s:5:\"phone\";s:11:\"12147852152\";s:4:\"said\";N;}\";',NULL,1368987544);

/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
