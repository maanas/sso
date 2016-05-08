# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 192.168.100.100 (MySQL 5.5.49-0ubuntu0.14.04.1)
# Database: sso
# Generation Time: 2016-05-08 18:01:44 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table api
# ------------------------------------------------------------

DROP TABLE IF EXISTS `api`;

CREATE TABLE `api` (
  `api_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `api_app` varchar(100) NOT NULL DEFAULT '',
  `api_ip` varchar(100) NOT NULL DEFAULT '',
  `api_desc` varchar(500) DEFAULT NULL,
  `api_key` varchar(500) NOT NULL DEFAULT '',
  `api_dateadded` int(11) NOT NULL,
  `api_lastmodified` int(11) NOT NULL,
  PRIMARY KEY (`api_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Dump of table app
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app`;

CREATE TABLE `app` (
  `ap_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ap_app` varchar(25) NOT NULL DEFAULT '',
  `ap_enabled` int(1) NOT NULL DEFAULT '0',
  `ap_token_duration` int(11) DEFAULT NULL,
  `ap_dateadded` int(11) NOT NULL,
  `ap_addedby` int(11) DEFAULT NULL,
  `ap_lastmodified` int(11) DEFAULT NULL,
  `ap_lastmodifiedby` int(11) DEFAULT NULL,
  `ap_deleted` int(1) NOT NULL DEFAULT '0',
  `ap_datedeleted` int(11) DEFAULT NULL,
  `ap_deletedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`ap_id`),
  UNIQUE KEY `id` (`ap_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table app_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_user`;

CREATE TABLE `app_user` (
  `au_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `au_apid` int(11) NOT NULL,
  `au_uid` int(11) NOT NULL,
  `au_enabled` int(1) NOT NULL DEFAULT '0',
  `au_dateadded` int(11) DEFAULT NULL,
  `au_addedby` int(11) DEFAULT NULL,
  `au_lastmodified` int(11) DEFAULT NULL,
  `au_modifiedby` int(11) DEFAULT NULL,
  `au_deleted` int(1) NOT NULL DEFAULT '0',
  `au_datedeleted` int(11) DEFAULT NULL,
  `au_deletedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`au_id`),
  UNIQUE KEY `app_user` (`au_apid`,`au_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table error
# ------------------------------------------------------------

DROP TABLE IF EXISTS `error`;

CREATE TABLE `error` (
  `e_id` int(11) NOT NULL AUTO_INCREMENT,
  `e_ip` varchar(45) DEFAULT NULL,
  `e_key` varchar(45) DEFAULT NULL,
  `e_value` varchar(45) DEFAULT NULL,
  `e_details` mediumtext,
  `e_reftable` varchar(45) DEFAULT NULL,
  `e_refid` varchar(45) DEFAULT NULL,
  `e_uid` varchar(45) DEFAULT NULL,
  `e_dateadded` int(11) DEFAULT NULL,
  `e_lastmodified` int(11) DEFAULT NULL,
  PRIMARY KEY (`e_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table filter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `filter`;

CREATE TABLE `filter` (
  `fl_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fl_source` varchar(25) NOT NULL DEFAULT '' COMMENT 'admin, auto',
  `fl_type` varchar(50) NOT NULL DEFAULT '' COMMENT 'ip, subnet, host',
  `fl_access` varchar(25) NOT NULL DEFAULT '' COMMENT 'allow, deny',
  `fl_value` varchar(50) NOT NULL DEFAULT '',
  `fl_app` int(11) DEFAULT NULL COMMENT 'app = ap_id, app = 0 Universal',
  `fl_note` varchar(500) DEFAULT NULL,
  `fl_dateadded` int(11) NOT NULL,
  `fl_addedby` int(11) DEFAULT NULL,
  `fl_lastmodified` int(11) DEFAULT NULL,
  `fl_modifiedby` int(11) DEFAULT NULL,
  `fl_deleted` int(11) NOT NULL DEFAULT '0',
  `fl_deletedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`fl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `filter` WRITE;
/*!40000 ALTER TABLE `filter` DISABLE KEYS */;

INSERT INTO `filter` (`fl_id`, `fl_source`, `fl_type`, `fl_access`, `fl_value`, `fl_app`, `fl_note`, `fl_dateadded`, `fl_addedby`, `fl_lastmodified`, `fl_modifiedby`, `fl_deleted`, `fl_deletedby`)
VALUES
  (1,'admin','IP','disabled','5.5.5.5',NULL,NULL,1440644381,0,NULL,NULL,0,NULL),
  (2,'admin','Own Host','enabled','10.0.0.0',0,NULL,1440644690,0,1440644884,NULL,0,NULL);

/*!40000 ALTER TABLE `filter` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `l_id` int(11) NOT NULL AUTO_INCREMENT,
  `l_ip` varchar(45) DEFAULT NULL,
  `l_uid` int(11) DEFAULT NULL,
  `l_apid` int(11) DEFAULT NULL,
  `l_sid` varchar(50) DEFAULT NULL,
  `l_tid` varchar(50) DEFAULT NULL,
  `l_type` varchar(60) DEFAULT NULL,
  `l_value` varchar(250) DEFAULT NULL,
  `l_details` mediumtext,
  `l_browser` varchar(100) DEFAULT NULL,
  `l_dateadded` int(11) DEFAULT NULL,
  `l_lastmodified` int(11) DEFAULT NULL,
  PRIMARY KEY (`l_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table session
# ------------------------------------------------------------

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
  `s_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_token` varchar(256) NOT NULL,
  `s_uid` int(11) NOT NULL DEFAULT '0',
  `s_persistent` int(1) NOT NULL DEFAULT '0',
  `s_data` longtext,
  `s_dateadded` int(11) DEFAULT NULL,
  `s_lastaccess` int(11) unsigned DEFAULT NULL,
  `s_dateexpire` int(11) DEFAULT NULL,
  PRIMARY KEY (`s_id`),
  UNIQUE KEY `unique_token` (`s_token`),
  UNIQUE KEY `uid` (`s_uid`,`s_dateadded`),
  KEY `token` (`s_token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table token
# ------------------------------------------------------------

DROP TABLE IF EXISTS `token`;

CREATE TABLE `token` (
  `t_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_token` varchar(256) NOT NULL,
  `t_sid` varchar(256) DEFAULT NULL,
  `t_uid` int(11) NOT NULL DEFAULT '0',
  `t_app` varchar(50) DEFAULT NULL,
  `t_data` longtext,
  `t_dateadded` int(11) DEFAULT NULL,
  `t_lastaccess` int(11) unsigned DEFAULT NULL,
  `t_dateexpire` int(11) DEFAULT NULL,
  PRIMARY KEY (`t_id`),
  UNIQUE KEY `unique_token` (`t_token`),
  UNIQUE KEY `uid` (`t_uid`,`t_dateadded`),
  KEY `token` (`t_token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table trail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `trail`;

CREATE TABLE `trail` (
  `t_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_ip` varchar(45) DEFAULT NULL,
  `t_key` varchar(45) DEFAULT NULL,
  `t_value` varchar(45) DEFAULT NULL,
  `t_details` mediumtext,
  `t_reftable` varchar(45) DEFAULT NULL,
  `t_refid` varchar(50) DEFAULT NULL,
  `t_uid` int(11) DEFAULT NULL,
  `t_browser` varchar(100) DEFAULT NULL,
  `t_dateadded` int(11) DEFAULT NULL,
  `t_lastmodified` int(11) DEFAULT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `u_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `u_email` varchar(100) NOT NULL DEFAULT '',
  `u_username` varchar(50) NOT NULL DEFAULT '',
  `u_hash` varchar(256) NOT NULL DEFAULT '',
  `u_firstname` varchar(100) NOT NULL DEFAULT '',
  `u_lastname` varchar(100) NOT NULL DEFAULT '',
  `u_enabled` int(1) NOT NULL DEFAULT '1',
  `u_session_duration` int(11) DEFAULT NULL,
  `u_last_attempt` int(11) DEFAULT NULL,
  `u_failed_count` int(11) DEFAULT NULL,
  `u_delay_duration` int(11) DEFAULT NULL,
  `u_dateadded` int(11) NOT NULL,
  `u_addedby` int(11) NOT NULL,
  `u_lastmodified` int(11) DEFAULT NULL,
  `u_modifiedby` int(11) DEFAULT NULL,
  `u_deleted` int(1) NOT NULL DEFAULT '0',
  `u_datedeleted` int(11) DEFAULT NULL,
  `u_deletedby` int(11) DEFAULT NULL,
  PRIMARY KEY (`u_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`u_id`, `u_email`, `u_username`, `u_hash`, `u_firstname`, `u_lastname`, `u_enabled`, `u_session_duration`, `u_last_attempt`, `u_failed_count`, `u_delay_duration`, `u_dateadded`, `u_addedby`, `u_lastmodified`, `u_modifiedby`, `u_deleted`, `u_datedeleted`, `u_deletedby`)
VALUES
  (1,'maanas@maanas.co','maanas','d1b817b5a2d6e4bd4fa36af357d05f8e94fd0d0d6efe6c7d809e6dc18a66aad0','Maanas','Royy',1,NULL,NULL,NULL,NULL,1357456127,0,1439353445,NULL,0,NULL,NULL),
  (2,'test@maanas.co','test','d1b817b5a2d6e4bd4fa36af357d05f8e94fd0d0d6efe6c7d809e6dc18a66aad0','Test','User',1,NULL,NULL,NULL,NULL,1440641839,0,1441071709,0,0,NULL,NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
