-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zabbix
-- ------------------------------------------------------
-- Server version	10.1.41-MariaDB-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `action` int(11) NOT NULL DEFAULT '0',
  `old_severity` int(11) NOT NULL DEFAULT '0',
  `new_severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT '0',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `esc_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1h',
  `def_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `def_longdata` text COLLATE utf8_bin NOT NULL,
  `r_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `r_longdata` text COLLATE utf8_bin NOT NULL,
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pause_suppressed` int(11) NOT NULL DEFAULT '1',
  `ack_shortdata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ack_longdata` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`actionid`),
  UNIQUE KEY `actions_2` (`name`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `subject` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` text COLLATE utf8_bin NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `alerttype` int(11) NOT NULL DEFAULT '0',
  `p_eventid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  KEY `alerts_7` (`p_eventid`),
  KEY `c_alerts_6` (`acknowledgeid`),
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_5` FOREIGN KEY (`p_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_6` FOREIGN KEY (`acknowledgeid`) REFERENCES `acknowledges` (`acknowledgeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_discovery`
--

DROP TABLE IF EXISTS `application_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_discovery` (
  `application_discoveryid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`application_discoveryid`),
  KEY `application_discovery_1` (`applicationid`),
  KEY `application_discovery_2` (`application_prototypeid`),
  CONSTRAINT `c_application_discovery_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_discovery_2` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_discovery`
--

LOCK TABLES `application_discovery` WRITE;
/*!40000 ALTER TABLE `application_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_prototype`
--

DROP TABLE IF EXISTS `application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_prototype` (
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`application_prototypeid`),
  KEY `application_prototype_1` (`itemid`),
  KEY `application_prototype_2` (`templateid`),
  CONSTRAINT `c_application_prototype_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_prototype_2` FOREIGN KEY (`templateid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_prototype`
--

LOCK TABLES `application_prototype` WRITE;
/*!40000 ALTER TABLE `application_prototype` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_template`
--

DROP TABLE IF EXISTS `application_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_template` (
  `application_templateid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`application_templateid`),
  UNIQUE KEY `application_template_1` (`applicationid`,`templateid`),
  KEY `application_template_2` (`templateid`),
  CONSTRAINT `c_application_template_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_template_2` FOREIGN KEY (`templateid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_template`
--

LOCK TABLES `application_template` WRITE;
/*!40000 ALTER TABLE `application_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `application_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `applicationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `applications_2` (`hostid`,`name`),
  CONSTRAINT `c_applications_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `auditid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `details` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resourcename` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  CONSTRAINT `c_auditlog_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog_details`
--

DROP TABLE IF EXISTS `auditlog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog_details` (
  `auditdetailid` bigint(20) unsigned NOT NULL,
  `auditid` bigint(20) unsigned NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oldvalue` text COLLATE utf8_bin NOT NULL,
  `newvalue` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`auditdetailid`),
  KEY `auditlog_details_1` (`auditid`),
  CONSTRAINT `c_auditlog_details_1` FOREIGN KEY (`auditid`) REFERENCES `auditlog` (`auditid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog_details`
--

LOCK TABLES `auditlog_details` WRITE;
/*!40000 ALTER TABLE `auditlog_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`host`),
  KEY `autoreg_host_2` (`proxy_hostid`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configid` bigint(20) unsigned NOT NULL,
  `refresh_unsupported` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '10m',
  `work_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1-5,09:00-18:00',
  `alert_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `default_theme` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'blue-theme',
  `authentication_type` int(11) NOT NULL DEFAULT '0',
  `ldap_host` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_port` int(11) NOT NULL DEFAULT '389',
  `ldap_base_dn` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_bind_dn` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_bind_password` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ldap_search_attribute` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dropdown_first_entry` int(11) NOT NULL DEFAULT '1',
  `dropdown_first_remember` int(11) NOT NULL DEFAULT '1',
  `discovery_groupid` bigint(20) unsigned NOT NULL,
  `max_in_table` int(11) NOT NULL DEFAULT '50',
  `search_limit` int(11) NOT NULL DEFAULT '1000',
  `severity_color_0` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '97AAB3',
  `severity_color_1` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '7499FF',
  `severity_color_2` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'FFC859',
  `severity_color_3` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'FFA059',
  `severity_color_4` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'E97659',
  `severity_color_5` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'E45959',
  `severity_name_0` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Not classified',
  `severity_name_1` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Information',
  `severity_name_2` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Warning',
  `severity_name_3` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Average',
  `severity_name_4` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'High',
  `severity_name_5` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT 'Disaster',
  `ok_period` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '5m',
  `blink_period` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '2m',
  `problem_unack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'CC0000',
  `problem_ack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT 'CC0000',
  `ok_unack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009900',
  `ok_ack_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009900',
  `problem_unack_style` int(11) NOT NULL DEFAULT '1',
  `problem_ack_style` int(11) NOT NULL DEFAULT '1',
  `ok_unack_style` int(11) NOT NULL DEFAULT '1',
  `ok_ack_style` int(11) NOT NULL DEFAULT '1',
  `snmptrap_logging` int(11) NOT NULL DEFAULT '1',
  `server_check_interval` int(11) NOT NULL DEFAULT '10',
  `hk_events_mode` int(11) NOT NULL DEFAULT '1',
  `hk_events_trigger` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_events_internal` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_events_discovery` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_events_autoreg` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '1d',
  `hk_services_mode` int(11) NOT NULL DEFAULT '1',
  `hk_services` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_audit_mode` int(11) NOT NULL DEFAULT '1',
  `hk_audit` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_sessions_mode` int(11) NOT NULL DEFAULT '1',
  `hk_sessions` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `hk_history_mode` int(11) NOT NULL DEFAULT '1',
  `hk_history_global` int(11) NOT NULL DEFAULT '0',
  `hk_history` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '90d',
  `hk_trends_mode` int(11) NOT NULL DEFAULT '1',
  `hk_trends_global` int(11) NOT NULL DEFAULT '0',
  `hk_trends` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `default_inventory_mode` int(11) NOT NULL DEFAULT '-1',
  `custom_color` int(11) NOT NULL DEFAULT '0',
  `http_auth_enabled` int(11) NOT NULL DEFAULT '0',
  `http_login_form` int(11) NOT NULL DEFAULT '0',
  `http_strip_domains` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `http_case_sensitive` int(11) NOT NULL DEFAULT '1',
  `ldap_configured` int(11) NOT NULL DEFAULT '0',
  `ldap_case_sensitive` int(11) NOT NULL DEFAULT '1',
  `db_extension` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`configid`),
  KEY `config_1` (`alert_usrgrpid`),
  KEY `config_2` (`discovery_groupid`),
  CONSTRAINT `c_config_1` FOREIGN KEY (`alert_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_config_2` FOREIGN KEY (`discovery_groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'10m','1-5,09:00-18:00',NULL,'blue-theme',0,'',389,'','','','',1,1,5,50,1000,'97AAB3','7499FF','FFC859','FFA059','E97659','E45959','Not classified','Information','Warning','Average','High','Disaster','5m','2m','CC0000','CC0000','009900','009900',1,1,1,1,1,10,1,'365d','1d','1d','1d',1,'365d',1,'365d',1,'365d',1,0,'90d',1,0,'365d',-1,0,0,0,'',1,0,1,'');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition`
--

DROP TABLE IF EXISTS `corr_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_1` (`correlationid`),
  CONSTRAINT `c_corr_condition_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition`
--

LOCK TABLES `corr_condition` WRITE;
/*!40000 ALTER TABLE `corr_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_group`
--

DROP TABLE IF EXISTS `corr_condition_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_group` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '0',
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`corr_conditionid`),
  KEY `corr_condition_group_1` (`groupid`),
  CONSTRAINT `c_corr_condition_group_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE,
  CONSTRAINT `c_corr_condition_group_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_group`
--

LOCK TABLES `corr_condition_group` WRITE;
/*!40000 ALTER TABLE `corr_condition_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tag`
--

DROP TABLE IF EXISTS `corr_condition_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tag` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tag_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tag`
--

LOCK TABLES `corr_condition_tag` WRITE;
/*!40000 ALTER TABLE `corr_condition_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagpair`
--

DROP TABLE IF EXISTS `corr_condition_tagpair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagpair` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `oldtag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `newtag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagpair_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagpair`
--

LOCK TABLES `corr_condition_tagpair` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagpair` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagpair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_condition_tagvalue`
--

DROP TABLE IF EXISTS `corr_condition_tagvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_condition_tagvalue` (
  `corr_conditionid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`corr_conditionid`),
  CONSTRAINT `c_corr_condition_tagvalue_1` FOREIGN KEY (`corr_conditionid`) REFERENCES `corr_condition` (`corr_conditionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_condition_tagvalue`
--

LOCK TABLES `corr_condition_tagvalue` WRITE;
/*!40000 ALTER TABLE `corr_condition_tagvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_condition_tagvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corr_operation`
--

DROP TABLE IF EXISTS `corr_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corr_operation` (
  `corr_operationid` bigint(20) unsigned NOT NULL,
  `correlationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`corr_operationid`),
  KEY `corr_operation_1` (`correlationid`),
  CONSTRAINT `c_corr_operation_1` FOREIGN KEY (`correlationid`) REFERENCES `correlation` (`correlationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corr_operation`
--

LOCK TABLES `corr_operation` WRITE;
/*!40000 ALTER TABLE `corr_operation` DISABLE KEYS */;
/*!40000 ALTER TABLE `corr_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `correlation`
--

DROP TABLE IF EXISTS `correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `correlation` (
  `correlationid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`correlationid`),
  UNIQUE KEY `correlation_2` (`name`),
  KEY `correlation_1` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `correlation`
--

LOCK TABLES `correlation` WRITE;
/*!40000 ALTER TABLE `correlation` DISABLE KEYS */;
/*!40000 ALTER TABLE `correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard` (
  `dashboardid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dashboardid`),
  KEY `c_dashboard_1` (`userid`),
  CONSTRAINT `c_dashboard_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_user`
--

DROP TABLE IF EXISTS `dashboard_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_user` (
  `dashboard_userid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`dashboard_userid`),
  UNIQUE KEY `dashboard_user_1` (`dashboardid`,`userid`),
  KEY `c_dashboard_user_2` (`userid`),
  CONSTRAINT `c_dashboard_user_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_user`
--

LOCK TABLES `dashboard_user` WRITE;
/*!40000 ALTER TABLE `dashboard_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_usrgrp`
--

DROP TABLE IF EXISTS `dashboard_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard_usrgrp` (
  `dashboard_usrgrpid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`dashboard_usrgrpid`),
  UNIQUE KEY `dashboard_usrgrp_1` (`dashboardid`,`usrgrpid`),
  KEY `c_dashboard_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_dashboard_usrgrp_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE,
  CONSTRAINT `c_dashboard_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_usrgrp`
--

LOCK TABLES `dashboard_usrgrp` WRITE;
/*!40000 ALTER TABLE `dashboard_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbversion`
--

DROP TABLE IF EXISTS `dbversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbversion` (
  `mandatory` int(11) NOT NULL DEFAULT '0',
  `optional` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbversion`
--

LOCK TABLES `dbversion` WRITE;
/*!40000 ALTER TABLE `dbversion` DISABLE KEYS */;
INSERT INTO `dbversion` VALUES (4020000,4020001);
/*!40000 ALTER TABLE `dbversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_community` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ports` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_source` int(11) NOT NULL DEFAULT '1',
  `name_source` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`,`host_source`,`name_source`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `iprange` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1h',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`druleid`),
  UNIQUE KEY `drules_2` (`name`),
  KEY `drules_1` (`proxy_hostid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `itemid` bigint(20) unsigned DEFAULT NULL,
  `acknowledgeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`escalationid`),
  UNIQUE KEY `escalations_1` (`triggerid`,`itemid`,`escalationid`),
  KEY `escalations_2` (`eventid`),
  KEY `escalations_3` (`nextcheck`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_recovery`
--

DROP TABLE IF EXISTS `event_recovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_recovery` (
  `eventid` bigint(20) unsigned NOT NULL,
  `r_eventid` bigint(20) unsigned NOT NULL,
  `c_eventid` bigint(20) unsigned DEFAULT NULL,
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`eventid`),
  KEY `event_recovery_1` (`r_eventid`),
  KEY `event_recovery_2` (`c_eventid`),
  CONSTRAINT `c_event_recovery_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_recovery_3` FOREIGN KEY (`c_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_recovery`
--

LOCK TABLES `event_recovery` WRITE;
/*!40000 ALTER TABLE `event_recovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_recovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_suppress`
--

DROP TABLE IF EXISTS `event_suppress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_suppress` (
  `event_suppressid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `suppress_until` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`event_suppressid`),
  UNIQUE KEY `event_suppress_1` (`eventid`,`maintenanceid`),
  KEY `event_suppress_2` (`suppress_until`),
  KEY `event_suppress_3` (`maintenanceid`),
  CONSTRAINT `c_event_suppress_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_event_suppress_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_suppress`
--

LOCK TABLES `event_suppress` WRITE;
/*!40000 ALTER TABLE `event_suppress` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_suppress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_tag`
--

DROP TABLE IF EXISTS `event_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_tag` (
  `eventtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`eventtagid`),
  KEY `event_tag_1` (`eventid`),
  CONSTRAINT `c_event_tag_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_tag`
--

LOCK TABLES `event_tag` WRITE;
/*!40000 ALTER TABLE `event_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `name` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`source`,`object`,`objectid`,`clock`),
  KEY `events_2` (`source`,`object`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT '0',
  `exp_delimiter` varchar(1) COLLATE utf8_bin NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES (1,1,'^(btrfs|ext2|ext3|ext4|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|apfs|refs|ntfs|fat32|zfs)$',3,',',0),(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),(5,4,'^(MMCSS|gupdate|SysmonLog|clr_optimization_v2.0.50727_32|clr_optimization_v4.0.30319_32)$',4,',',1),(6,5,'^(automatic|automatic delayed)$',3,',',1),(7,2,'^Software Loopback Interface',4,',',1),(8,2,'^(In)?[Ll]oop[Bb]ack[0-9._]*$',4,',',1),(9,2,'^NULL[0-9.]*$',4,',',1),(10,2,'^[Ll]o[0-9.]*$',4,',',1),(11,2,'^[Ss]ystem$',4,',',1),(12,2,'^Nu[0-9.]*$',4,',',1);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `name` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '',
  `parameter` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`name`,`parameter`),
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`globalmacroid`),
  UNIQUE KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES (2,'{$SNMP_COMMUNITY}','public');
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalvars` (
  `globalvarid` bigint(20) unsigned NOT NULL,
  `snmp_lastsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`globalvarid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_discovery` (
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`graphid`),
  KEY `graph_discovery_1` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `theme` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `graphcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gridcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maingridcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gridbordercolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `textcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `highlightcolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `leftpercentilecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `rightpercentilecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `nonworktimecolor` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `colorpalette` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`graphthemeid`),
  UNIQUE KEY `graph_theme_1` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '900',
  `height` int(11) NOT NULL DEFAULT '200',
  `yaxismin` double(16,4) NOT NULL DEFAULT '0.0000',
  `yaxismax` double(16,4) NOT NULL DEFAULT '100.0000',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT '1',
  `show_triggers` int(11) NOT NULL DEFAULT '1',
  `graphtype` int(11) NOT NULL DEFAULT '0',
  `show_legend` int(11) NOT NULL DEFAULT '1',
  `show_3d` int(11) NOT NULL DEFAULT '0',
  `percent_left` double(16,4) NOT NULL DEFAULT '0.0000',
  `percent_right` double(16,4) NOT NULL DEFAULT '0.0000',
  `ymin_type` int(11) NOT NULL DEFAULT '0',
  `ymax_type` int(11) NOT NULL DEFAULT '0',
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`graphid`),
  KEY `graphs_1` (`name`),
  KEY `graphs_2` (`templateid`),
  KEY `graphs_3` (`ymin_itemid`),
  KEY `graphs_4` (`ymax_itemid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT '0',
  `calc_fnc` int(11) NOT NULL DEFAULT '2',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_discovery`
--

DROP TABLE IF EXISTS `group_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_discovery` (
  `groupid` bigint(20) unsigned NOT NULL,
  `parent_group_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `c_group_discovery_2` (`parent_group_prototypeid`),
  CONSTRAINT `c_group_discovery_1` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_discovery_2` FOREIGN KEY (`parent_group_prototypeid`) REFERENCES `group_prototype` (`group_prototypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_discovery`
--

LOCK TABLES `group_discovery` WRITE;
/*!40000 ALTER TABLE `group_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_prototype`
--

DROP TABLE IF EXISTS `group_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_prototype` (
  `group_prototypeid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_prototypeid`),
  KEY `group_prototype_1` (`hostid`),
  KEY `c_group_prototype_2` (`groupid`),
  KEY `c_group_prototype_3` (`templateid`),
  CONSTRAINT `c_group_prototype_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`),
  CONSTRAINT `c_group_prototype_3` FOREIGN KEY (`templateid`) REFERENCES `group_prototype` (`group_prototypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_prototype`
--

LOCK TABLES `group_prototype` WRITE;
/*!40000 ALTER TABLE `group_prototype` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_log` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_bin NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_log_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_str_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_text` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` text COLLATE utf8_bin NOT NULL,
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_text_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_uint_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_discovery`
--

DROP TABLE IF EXISTS `host_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_discovery` (
  `hostid` bigint(20) unsigned NOT NULL,
  `parent_hostid` bigint(20) unsigned DEFAULT NULL,
  `parent_itemid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hostid`),
  KEY `c_host_discovery_2` (`parent_hostid`),
  KEY `c_host_discovery_3` (`parent_itemid`),
  CONSTRAINT `c_host_discovery_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_discovery_2` FOREIGN KEY (`parent_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_host_discovery_3` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_discovery`
--

LOCK TABLES `host_discovery` WRITE;
/*!40000 ALTER TABLE `host_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  `type` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type_full` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `alias` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os_full` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `os_short` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `serialno_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `serialno_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tag` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `asset_tag` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hardware` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hardware_full` text COLLATE utf8_bin NOT NULL,
  `software` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_full` text COLLATE utf8_bin NOT NULL,
  `software_app_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_c` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_d` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `software_app_e` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contact` text COLLATE utf8_bin NOT NULL,
  `location` text COLLATE utf8_bin NOT NULL,
  `location_lat` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `location_lon` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `notes` text COLLATE utf8_bin NOT NULL,
  `chassis` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `model` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hw_arch` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `vendor` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `contract_number` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `installer_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `deployment_status` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_a` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_b` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url_c` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_networks` text COLLATE utf8_bin NOT NULL,
  `host_netmask` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_router` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `oob_router` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_a` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_b` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_address_c` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_city` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_state` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_country` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_zip` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_rack` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `site_notes` text COLLATE utf8_bin NOT NULL,
  `poc_1_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_1_notes` text COLLATE utf8_bin NOT NULL,
  `poc_2_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `poc_2_notes` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_tag`
--

DROP TABLE IF EXISTS `host_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_tag` (
  `hosttagid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`hosttagid`),
  KEY `host_tag_1` (`hostid`),
  CONSTRAINT `c_host_tag_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_tag`
--

LOCK TABLES `host_tag` WRITE;
/*!40000 ALTER TABLE `host_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `disable_until` int(11) NOT NULL DEFAULT '0',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `errors_from` int(11) NOT NULL DEFAULT '0',
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `ipmi_authtype` int(11) NOT NULL DEFAULT '-1',
  `ipmi_privilege` int(11) NOT NULL DEFAULT '2',
  `ipmi_username` varchar(16) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ipmi_disable_until` int(11) NOT NULL DEFAULT '0',
  `ipmi_available` int(11) NOT NULL DEFAULT '0',
  `snmp_disable_until` int(11) NOT NULL DEFAULT '0',
  `snmp_available` int(11) NOT NULL DEFAULT '0',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT '0',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `maintenance_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_errors_from` int(11) NOT NULL DEFAULT '0',
  `snmp_errors_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `jmx_disable_until` int(11) NOT NULL DEFAULT '0',
  `jmx_available` int(11) NOT NULL DEFAULT '0',
  `jmx_errors_from` int(11) NOT NULL DEFAULT '0',
  `jmx_error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `tls_connect` int(11) NOT NULL DEFAULT '1',
  `tls_accept` int(11) NOT NULL DEFAULT '1',
  `tls_issuer` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_subject` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_psk_identity` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `tls_psk` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `proxy_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `auto_compress` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxy_hostid`),
  KEY `hosts_4` (`name`),
  KEY `hosts_5` (`maintenanceid`),
  KEY `c_hosts_3` (`templateid`),
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`),
  CONSTRAINT `c_hosts_3` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (10001,NULL,'Template OS Linux',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux',0,NULL,'',1,1,'','','','','',1),(10050,NULL,'Template App Zabbix Agent',3,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Agent',0,NULL,'',1,1,'','','','','',1),(10265,NULL,'Zabbix Agent Linux',0,1568738938,'Received empty response from Zabbix Agent at [10.0.0.102]. Assuming that agent dropped connection because of access permissions.',2,1568736015,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Zabbix Agent Linux',0,NULL,'',1,1,'','','','','',1);
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES (4,10001,10050),(239,10265,10001);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hstgrp`
--

DROP TABLE IF EXISTS `hstgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hstgrp` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `internal` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `hstgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hstgrp`
--

LOCK TABLES `hstgrp` WRITE;
/*!40000 ALTER TABLE `hstgrp` DISABLE KEYS */;
INSERT INTO `hstgrp` VALUES (5,'',0,0);
/*!40000 ALTER TABLE `hstgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT '0',
  `url` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timeout` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '15s',
  `posts` text COLLATE utf8_bin NOT NULL,
  `required` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status_codes` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `post_type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep_field`
--

DROP TABLE IF EXISTS `httpstep_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep_field` (
  `httpstep_fieldid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`httpstep_fieldid`),
  KEY `httpstep_field_1` (`httpstepid`),
  CONSTRAINT `c_httpstep_field_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep_field`
--

LOCK TABLES `httpstep_field` WRITE;
/*!40000 ALTER TABLE `httpstep_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE,
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `applicationid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `delay` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '1m',
  `status` int(11) NOT NULL DEFAULT '0',
  `agent` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT 'Zabbix',
  `authentication` int(11) NOT NULL DEFAULT '0',
  `http_user` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `http_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `http_proxy` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `retries` int(11) NOT NULL DEFAULT '1',
  `ssl_cert_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestid`),
  UNIQUE KEY `httptest_2` (`hostid`,`name`),
  KEY `httptest_1` (`applicationid`),
  KEY `httptest_3` (`status`),
  KEY `httptest_4` (`templateid`),
  CONSTRAINT `c_httptest_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`),
  CONSTRAINT `c_httptest_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptest_3` FOREIGN KEY (`templateid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest_field`
--

DROP TABLE IF EXISTS `httptest_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest_field` (
  `httptest_fieldid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`httptest_fieldid`),
  KEY `httptest_field_1` (`httptestid`),
  CONSTRAINT `c_httptest_field_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest_field`
--

LOCK TABLES `httptest_field` WRITE;
/*!40000 ALTER TABLE `httptest_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_1` (`httptestid`,`itemid`),
  KEY `httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  UNIQUE KEY `icon_map_1` (`name`),
  KEY `icon_map_2` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `expression` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `field_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
INSERT INTO `ids` VALUES ('proxy_autoreg_host','autoreg_host_lastid',27);
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `useip` int(11) NOT NULL DEFAULT '1',
  `ip` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '10050',
  `bulk` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES (3,10265,1,1,1,'10.0.0.102','','10050',1);
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_discovery`
--

DROP TABLE IF EXISTS `interface_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface_discovery` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `parent_interfaceid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`interfaceid`),
  KEY `c_interface_discovery_2` (`parent_interfaceid`),
  CONSTRAINT `c_interface_discovery_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE,
  CONSTRAINT `c_interface_discovery_2` FOREIGN KEY (`parent_interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_discovery`
--

LOCK TABLES `interface_discovery` WRITE;
/*!40000 ALTER TABLE `interface_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `interface_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_application_prototype`
--

DROP TABLE IF EXISTS `item_application_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_application_prototype` (
  `item_application_prototypeid` bigint(20) unsigned NOT NULL,
  `application_prototypeid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`item_application_prototypeid`),
  UNIQUE KEY `item_application_prototype_1` (`application_prototypeid`,`itemid`),
  KEY `item_application_prototype_2` (`itemid`),
  CONSTRAINT `c_item_application_prototype_1` FOREIGN KEY (`application_prototypeid`) REFERENCES `application_prototype` (`application_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_application_prototype_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_application_prototype`
--

LOCK TABLES `item_application_prototype` WRITE;
/*!40000 ALTER TABLE `item_application_prototype` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_application_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_condition`
--

DROP TABLE IF EXISTS `item_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_condition` (
  `item_conditionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `operator` int(11) NOT NULL DEFAULT '8',
  `macro` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`item_conditionid`),
  KEY `item_condition_1` (`itemid`),
  CONSTRAINT `c_item_condition_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_condition`
--

LOCK TABLES `item_condition` WRITE;
/*!40000 ALTER TABLE `item_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned NOT NULL,
  `key_` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `item_discovery_2` (`parent_itemid`),
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_preproc`
--

DROP TABLE IF EXISTS `item_preproc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_preproc` (
  `item_preprocid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `params` text COLLATE utf8_bin NOT NULL,
  `error_handler` int(11) NOT NULL DEFAULT '0',
  `error_handler_params` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`item_preprocid`),
  KEY `item_preproc_1` (`itemid`,`step`),
  CONSTRAINT `c_item_preproc_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_preproc`
--

LOCK TABLES `item_preproc` WRITE;
/*!40000 ALTER TABLE `item_preproc` DISABLE KEYS */;
INSERT INTO `item_preproc` VALUES (6533,28685,1,10,'',0,''),(6534,28689,1,10,'',0,'');
/*!40000 ALTER TABLE `item_preproc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `snmp_community` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmp_oid` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `key_` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `history` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '90d',
  `trends` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '365d',
  `status` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `trapper_hosts` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `units` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securityname` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `formula` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `logtimefmt` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `params` text COLLATE utf8_bin NOT NULL,
  `ipmi_sensor` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` text COLLATE utf8_bin NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `lifetime` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '30d',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `jmx_endpoint` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_itemid` bigint(20) unsigned DEFAULT NULL,
  `timeout` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '3s',
  `url` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `query_fields` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `posts` text COLLATE utf8_bin NOT NULL,
  `status_codes` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '200',
  `follow_redirects` int(11) NOT NULL DEFAULT '1',
  `post_type` int(11) NOT NULL DEFAULT '0',
  `http_proxy` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `headers` text COLLATE utf8_bin NOT NULL,
  `retrieve_mode` int(11) NOT NULL DEFAULT '0',
  `request_method` int(11) NOT NULL DEFAULT '0',
  `output_format` int(11) NOT NULL DEFAULT '0',
  `ssl_cert_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_file` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `ssl_key_password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `verify_peer` int(11) NOT NULL DEFAULT '0',
  `verify_host` int(11) NOT NULL DEFAULT '0',
  `allow_traps` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`),
  UNIQUE KEY `items_1` (`hostid`,`key_`),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `items_6` (`interfaceid`),
  KEY `items_7` (`master_itemid`),
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`),
  CONSTRAINT `c_items_5` FOREIGN KEY (`master_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (28677,0,'','',10265,'','agent.hostname','1h','90d','365d',0,1,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28678,0,'','',10265,'','agent.ping','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28679,0,'','',10265,'','agent.version','1h','90d','365d',0,1,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28680,0,'','',10265,'','kernel.maxfiles','1h','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28681,0,'','',10265,'','kernel.maxproc','1h','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28682,0,'','',10265,'','proc.num[,,run]','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28683,0,'','',10265,'','proc.num[]','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28684,0,'','',10265,'','system.boottime','10m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28685,0,'','',10265,'','system.cpu.intr','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28686,0,'','',10265,'','system.cpu.load[percpu,avg15]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28687,0,'','',10265,'','system.cpu.load[percpu,avg1]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28688,0,'','',10265,'','system.cpu.load[percpu,avg5]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28689,0,'','',10265,'','system.cpu.switches','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28690,0,'','',10265,'','system.cpu.util[,guest]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28691,0,'','',10265,'','system.cpu.util[,guest_nice]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28692,0,'','',10265,'','system.cpu.util[,idle]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28693,0,'','',10265,'','system.cpu.util[,interrupt]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28694,0,'','',10265,'','system.cpu.util[,iowait]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28695,0,'','',10265,'','system.cpu.util[,nice]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28696,0,'','',10265,'','system.cpu.util[,softirq]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28697,0,'','',10265,'','system.cpu.util[,steal]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28698,0,'','',10265,'','system.cpu.util[,system]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28699,0,'','',10265,'','system.cpu.util[,user]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28700,0,'','',10265,'','system.hostname','1h','90d','365d',0,1,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28701,0,'','',10265,'','system.localtime','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28702,0,'','',10265,'','system.swap.size[,free]','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28703,0,'','',10265,'','system.swap.size[,pfree]','1m','90d','365d',0,0,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28704,0,'','',10265,'','system.swap.size[,total]','1h','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28705,0,'','',10265,'','system.uname','1h','90d','365d',0,1,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28706,0,'','',10265,'','system.uptime','10m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28707,0,'','',10265,'','system.users.num','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28708,0,'','',10265,'','vfs.file.cksum[/etc/passwd]','1h','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28709,0,'','',10265,'','vm.memory.size[available]','1m','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28710,0,'','',10265,'','vm.memory.size[total]','1h','90d','365d',0,3,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,0,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28711,0,'','',10265,'','net.if.discovery','1h','90d','365d',0,4,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,1,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0),(28712,0,'','',10265,'','vfs.fs.discovery','1h','90d','365d',0,4,'','','',0,'','','','',0,'',NULL,NULL,'','',0,'','','','',0,1,3,'','',0,'30d',0,0,0,'',0,'',NULL,'3s','','','','200',1,0,'','',0,0,0,'','','',0,0,0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_applications`
--

DROP TABLE IF EXISTS `items_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_applications` (
  `itemappid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`itemappid`),
  UNIQUE KEY `items_applications_1` (`applicationid`,`itemid`),
  KEY `items_applications_2` (`itemid`),
  CONSTRAINT `c_items_applications_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_applications_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_applications`
--

LOCK TABLES `items_applications` WRITE;
/*!40000 ALTER TABLE `items_applications` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lld_macro_path`
--

DROP TABLE IF EXISTS `lld_macro_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lld_macro_path` (
  `lld_macro_pathid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `lld_macro` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `path` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`lld_macro_pathid`),
  UNIQUE KEY `lld_macro_path_1` (`itemid`,`lld_macro`),
  CONSTRAINT `c_lld_macro_path_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lld_macro_path`
--

LOCK TABLES `lld_macro_path` WRITE;
/*!40000 ALTER TABLE `lld_macro_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `lld_macro_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_tag`
--

DROP TABLE IF EXISTS `maintenance_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_tag` (
  `maintenancetagid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `operator` int(11) NOT NULL DEFAULT '2',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`maintenancetagid`),
  KEY `maintenance_tag_1` (`maintenanceid`),
  CONSTRAINT `c_maintenance_tag_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_tag`
--

LOCK TABLES `maintenance_tag` WRITE;
/*!40000 ALTER TABLE `maintenance_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `description` text COLLATE utf8_bin NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT '0',
  `active_till` int(11) NOT NULL DEFAULT '0',
  `tags_evaltype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maintenanceid`),
  UNIQUE KEY `maintenances_2` (`name`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mappings`
--

DROP TABLE IF EXISTS `mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mappings` (
  `mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `newvalue` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`mappingid`),
  KEY `mappings_1` (`valuemapid`),
  CONSTRAINT `c_mappings_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mappings`
--

LOCK TABLES `mappings` WRITE;
/*!40000 ALTER TABLE `mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '63',
  `period` varchar(1024) COLLATE utf8_bin NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_server` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `smtp_email` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `exec_path` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `username` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `passwd` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `smtp_port` int(11) NOT NULL DEFAULT '25',
  `smtp_security` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_peer` int(11) NOT NULL DEFAULT '0',
  `smtp_verify_host` int(11) NOT NULL DEFAULT '0',
  `smtp_authentication` int(11) NOT NULL DEFAULT '0',
  `exec_params` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `maxsessions` int(11) NOT NULL DEFAULT '1',
  `maxattempts` int(11) NOT NULL DEFAULT '3',
  `attempt_interval` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '10s',
  `content_type` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`mediatypeid`),
  UNIQUE KEY `media_type_1` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `scriptid` bigint(20) unsigned DEFAULT NULL,
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opcommand_1` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT '0',
  `esc_period` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT '1',
  `esc_step_to` int(11) NOT NULL DEFAULT '1',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `recovery` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opinventory`
--

DROP TABLE IF EXISTS `opinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opinventory` (
  `operationid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  CONSTRAINT `c_opinventory_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opinventory`
--

LOCK TABLES `opinventory` WRITE;
/*!40000 ALTER TABLE `opinventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `opinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `message` text COLLATE utf8_bin NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opmessage_1` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE,
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `r_clock` int(11) NOT NULL DEFAULT '0',
  `r_ns` int(11) NOT NULL DEFAULT '0',
  `correlationid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `problem_1` (`source`,`object`,`objectid`),
  KEY `problem_2` (`r_clock`),
  KEY `problem_3` (`r_eventid`),
  CONSTRAINT `c_problem_1` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_problem_2` FOREIGN KEY (`r_eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_tag`
--

DROP TABLE IF EXISTS `problem_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem_tag` (
  `problemtagid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`problemtagid`),
  KEY `problem_tag_1` (`eventid`,`tag`,`value`),
  CONSTRAINT `c_problem_tag_1` FOREIGN KEY (`eventid`) REFERENCES `problem` (`eventid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_tag`
--

LOCK TABLES `problem_tag` WRITE;
/*!40000 ALTER TABLE `problem_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `problem_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `source` varchar(96) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `host` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_metadata` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
INSERT INTO `proxy_autoreg_host` VALUES (1,1568734088,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(2,1568734208,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(3,1568734328,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(4,1568734448,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(5,1568734568,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(6,1568734688,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(7,1568734808,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(8,1568734928,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(9,1568735048,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(10,1568735168,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(11,1568735288,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(12,1568735408,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(13,1568735528,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(14,1568735648,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(15,1568736068,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(16,1568736188,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(17,1568736308,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(18,1568736428,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(19,1568736548,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(20,1568736668,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(21,1568736788,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(22,1568736908,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(23,1568737028,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(24,1568738492,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(25,1568738612,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(26,1568738732,'Zabbix Proxy','127.0.0.1',10050,'localhost',''),(27,1568738852,'Zabbix Proxy','127.0.0.1',10050,'localhost','');
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `druleid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_dhistory_1` (`clock`),
  KEY `proxy_dhistory_2` (`druleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` longtext COLLATE utf8_bin NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `proxy_history_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `test_string` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`regexpid`),
  UNIQUE KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES (1,'File systems for discovery',''),(2,'Network interfaces for discovery',''),(3,'Storage devices for SNMP discovery',''),(4,'Windows service names for discovery',''),(5,'Windows service startup states for discovery','');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_user`
--

DROP TABLE IF EXISTS `screen_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_user` (
  `screenuserid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenuserid`),
  UNIQUE KEY `screen_user_1` (`screenid`,`userid`),
  KEY `c_screen_user_2` (`userid`),
  CONSTRAINT `c_screen_user_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_user`
--

LOCK TABLES `screen_user` WRITE;
/*!40000 ALTER TABLE `screen_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen_usrgrp`
--

DROP TABLE IF EXISTS `screen_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screen_usrgrp` (
  `screenusrgrpid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`screenusrgrpid`),
  UNIQUE KEY `screen_usrgrp_1` (`screenid`,`usrgrpid`),
  KEY `c_screen_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_screen_usrgrp_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_screen_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen_usrgrp`
--

LOCK TABLES `screen_usrgrp` WRITE;
/*!40000 ALTER TABLE `screen_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `screen_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens` (
  `screenid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `hsize` int(11) NOT NULL DEFAULT '1',
  `vsize` int(11) NOT NULL DEFAULT '1',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`screenid`),
  KEY `screens_1` (`templateid`),
  KEY `c_screens_3` (`userid`),
  CONSTRAINT `c_screens_1` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_screens_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens_items`
--

DROP TABLE IF EXISTS `screens_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens_items` (
  `screenitemid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '320',
  `height` int(11) NOT NULL DEFAULT '200',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `colspan` int(11) NOT NULL DEFAULT '1',
  `rowspan` int(11) NOT NULL DEFAULT '1',
  `elements` int(11) NOT NULL DEFAULT '25',
  `valign` int(11) NOT NULL DEFAULT '0',
  `halign` int(11) NOT NULL DEFAULT '0',
  `style` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `dynamic` int(11) NOT NULL DEFAULT '0',
  `sort_triggers` int(11) NOT NULL DEFAULT '0',
  `application` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `max_columns` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`screenitemid`),
  KEY `screens_items_1` (`screenid`),
  CONSTRAINT `c_screens_items_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens_items`
--

LOCK TABLES `screens_items` WRITE;
/*!40000 ALTER TABLE `screens_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `screens_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `host_access` int(11) NOT NULL DEFAULT '2',
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `confirmation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`scriptid`),
  UNIQUE KEY `scripts_3` (`name`),
  KEY `scripts_1` (`usrgrpid`),
  KEY `scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `algorithm` int(11) NOT NULL DEFAULT '0',
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `showsla` int(11) NOT NULL DEFAULT '0',
  `goodsla` double(16,4) NOT NULL DEFAULT '99.9000',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`triggerid`),
  CONSTRAINT `c_services_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  `soft` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_times`
--

DROP TABLE IF EXISTS `services_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_times` (
  `timeid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ts_from` int(11) NOT NULL DEFAULT '0',
  `ts_to` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`timeid`),
  KEY `services_times_1` (`serviceid`,`type`,`ts_from`,`ts_to`),
  CONSTRAINT `c_services_times_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_times`
--

LOCK TABLES `services_times` WRITE;
/*!40000 ALTER TABLE `services_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`,`lastaccess`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slides`
--

DROP TABLE IF EXISTS `slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slides` (
  `slideid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `delay` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideid`),
  KEY `slides_1` (`slideshowid`),
  KEY `slides_2` (`screenid`),
  CONSTRAINT `c_slides_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slides_2` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slides`
--

LOCK TABLES `slides` WRITE;
/*!40000 ALTER TABLE `slides` DISABLE KEYS */;
/*!40000 ALTER TABLE `slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_user`
--

DROP TABLE IF EXISTS `slideshow_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_user` (
  `slideshowuserid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowuserid`),
  UNIQUE KEY `slideshow_user_1` (`slideshowid`,`userid`),
  KEY `c_slideshow_user_2` (`userid`),
  CONSTRAINT `c_slideshow_user_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_user`
--

LOCK TABLES `slideshow_user` WRITE;
/*!40000 ALTER TABLE `slideshow_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshow_usrgrp`
--

DROP TABLE IF EXISTS `slideshow_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshow_usrgrp` (
  `slideshowusrgrpid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`slideshowusrgrpid`),
  UNIQUE KEY `slideshow_usrgrp_1` (`slideshowid`,`usrgrpid`),
  KEY `c_slideshow_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_slideshow_usrgrp_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE,
  CONSTRAINT `c_slideshow_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshow_usrgrp`
--

LOCK TABLES `slideshow_usrgrp` WRITE;
/*!40000 ALTER TABLE `slideshow_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshow_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshows`
--

DROP TABLE IF EXISTS `slideshows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshows` (
  `slideshowid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `delay` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '30s',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`slideshowid`),
  UNIQUE KEY `slideshows_1` (`name`),
  KEY `c_slideshows_3` (`userid`),
  CONSTRAINT `c_slideshows_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshows`
--

LOCK TABLES `slideshows` WRITE;
/*!40000 ALTER TABLE `slideshows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_trigger`
--

DROP TABLE IF EXISTS `sysmap_element_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_trigger` (
  `selement_triggerid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`selement_triggerid`),
  UNIQUE KEY `sysmap_element_trigger_1` (`selementid`,`triggerid`),
  KEY `c_sysmap_element_trigger_2` (`triggerid`),
  CONSTRAINT `c_sysmap_element_trigger_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_element_trigger_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_trigger`
--

LOCK TABLES `sysmap_element_trigger` WRITE;
/*!40000 ALTER TABLE `sysmap_element_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_shape`
--

DROP TABLE IF EXISTS `sysmap_shape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_shape` (
  `sysmap_shapeid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `text` text COLLATE utf8_bin NOT NULL,
  `font` int(11) NOT NULL DEFAULT '9',
  `font_size` int(11) NOT NULL DEFAULT '11',
  `font_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `text_halign` int(11) NOT NULL DEFAULT '0',
  `text_valign` int(11) NOT NULL DEFAULT '0',
  `border_type` int(11) NOT NULL DEFAULT '0',
  `border_width` int(11) NOT NULL DEFAULT '1',
  `border_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `background_color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '',
  `zindex` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmap_shapeid`),
  KEY `sysmap_shape_1` (`sysmapid`),
  CONSTRAINT `c_sysmap_shape_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_shape`
--

LOCK TABLES `sysmap_shape` WRITE;
/*!40000 ALTER TABLE `sysmap_shape` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_shape` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_bin NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_user`
--

DROP TABLE IF EXISTS `sysmap_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_user` (
  `sysmapuserid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapuserid`),
  UNIQUE KEY `sysmap_user_1` (`sysmapid`,`userid`),
  KEY `c_sysmap_user_2` (`userid`),
  CONSTRAINT `c_sysmap_user_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_user_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_user`
--

LOCK TABLES `sysmap_user` WRITE;
/*!40000 ALTER TABLE `sysmap_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_usrgrp`
--

DROP TABLE IF EXISTS `sysmap_usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_usrgrp` (
  `sysmapusrgrpid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`sysmapusrgrpid`),
  UNIQUE KEY `sysmap_usrgrp_1` (`sysmapid`,`usrgrpid`),
  KEY `c_sysmap_usrgrp_2` (`usrgrpid`),
  CONSTRAINT `c_sysmap_usrgrp_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmap_usrgrp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_usrgrp`
--

LOCK TABLES `sysmap_usrgrp` WRITE;
/*!40000 ALTER TABLE `sysmap_usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '600',
  `height` int(11) NOT NULL DEFAULT '400',
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT '2',
  `label_location` int(11) NOT NULL DEFAULT '0',
  `highlight` int(11) NOT NULL DEFAULT '1',
  `expandproblem` int(11) NOT NULL DEFAULT '1',
  `markelements` int(11) NOT NULL DEFAULT '0',
  `show_unack` int(11) NOT NULL DEFAULT '0',
  `grid_size` int(11) NOT NULL DEFAULT '50',
  `grid_show` int(11) NOT NULL DEFAULT '1',
  `grid_align` int(11) NOT NULL DEFAULT '1',
  `label_format` int(11) NOT NULL DEFAULT '0',
  `label_type_host` int(11) NOT NULL DEFAULT '2',
  `label_type_hostgroup` int(11) NOT NULL DEFAULT '2',
  `label_type_trigger` int(11) NOT NULL DEFAULT '2',
  `label_type_map` int(11) NOT NULL DEFAULT '2',
  `label_type_image` int(11) NOT NULL DEFAULT '2',
  `label_string_host` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_map` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_string_image` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT '0',
  `severity_min` int(11) NOT NULL DEFAULT '0',
  `userid` bigint(20) unsigned NOT NULL,
  `private` int(11) NOT NULL DEFAULT '1',
  `show_suppressed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapid`),
  UNIQUE KEY `sysmaps_1` (`name`),
  KEY `sysmaps_2` (`backgroundid`),
  KEY `sysmaps_3` (`iconmapid`),
  KEY `c_sysmaps_3` (`userid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`),
  CONSTRAINT `c_sysmaps_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label_location` int(11) NOT NULL DEFAULT '-1',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT '0',
  `areatype` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `viewtype` int(11) NOT NULL DEFAULT '0',
  `use_iconmap` int(11) NOT NULL DEFAULT '1',
  `application` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`selementid`),
  KEY `sysmaps_elements_1` (`sysmapid`),
  KEY `sysmaps_elements_2` (`iconid_off`),
  KEY `sysmaps_elements_3` (`iconid_on`),
  KEY `sysmaps_elements_4` (`iconid_disabled`),
  KEY `sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '000000',
  `label` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`linkid`),
  KEY `sysmaps_links_1` (`sysmapid`),
  KEY `sysmaps_links_2` (`selementid1`),
  KEY `sysmaps_links_3` (`selementid2`),
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_filter`
--

DROP TABLE IF EXISTS `tag_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_filter` (
  `tag_filterid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`tag_filterid`),
  KEY `c_tag_filter_1` (`usrgrpid`),
  KEY `c_tag_filter_2` (`groupid`),
  CONSTRAINT `c_tag_filter_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_tag_filter_2` FOREIGN KEY (`groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_filter`
--

LOCK TABLES `tag_filter` WRITE;
/*!40000 ALTER TABLE `tag_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `ttl` int(11) NOT NULL DEFAULT '0',
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`taskid`),
  KEY `task_1` (`status`,`proxy_hostid`),
  KEY `c_task_1` (`proxy_hostid`),
  CONSTRAINT `c_task_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_acknowledge`
--

DROP TABLE IF EXISTS `task_acknowledge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_acknowledge` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_acknowledge_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_acknowledge`
--

LOCK TABLES `task_acknowledge` WRITE;
/*!40000 ALTER TABLE `task_acknowledge` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_acknowledge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_check_now`
--

DROP TABLE IF EXISTS `task_check_now`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_check_now` (
  `taskid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_check_now_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_check_now`
--

LOCK TABLES `task_check_now` WRITE;
/*!40000 ALTER TABLE `task_check_now` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_check_now` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_close_problem`
--

DROP TABLE IF EXISTS `task_close_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_close_problem` (
  `taskid` bigint(20) unsigned NOT NULL,
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_close_problem_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_close_problem`
--

LOCK TABLES `task_close_problem` WRITE;
/*!40000 ALTER TABLE `task_close_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_close_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command`
--

DROP TABLE IF EXISTS `task_remote_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_remote_command` (
  `taskid` bigint(20) unsigned NOT NULL,
  `command_type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` int(11) NOT NULL DEFAULT '0',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `password` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `publickey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `privatekey` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `command` text COLLATE utf8_bin NOT NULL,
  `alertid` bigint(20) unsigned DEFAULT NULL,
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command`
--

LOCK TABLES `task_remote_command` WRITE;
/*!40000 ALTER TABLE `task_remote_command` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_remote_command_result`
--

DROP TABLE IF EXISTS `task_remote_command_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_remote_command_result` (
  `taskid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `parent_taskid` bigint(20) unsigned NOT NULL,
  `info` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`taskid`),
  CONSTRAINT `c_task_remote_command_result_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`taskid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_remote_command_result`
--

LOCK TABLES `task_remote_command_result` WRITE;
/*!40000 ALTER TABLE `task_remote_command_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_remote_command_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT '0',
  `every` int(11) NOT NULL DEFAULT '1',
  `month` int(11) NOT NULL DEFAULT '0',
  `dayofweek` int(11) NOT NULL DEFAULT '0',
  `day` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_avg` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_max` double(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_discovery` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerid`),
  KEY `trigger_discovery_1` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_tag`
--

DROP TABLE IF EXISTS `trigger_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_tag` (
  `triggertagid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`triggertagid`),
  KEY `trigger_tag_1` (`triggerid`),
  CONSTRAINT `c_trigger_tag_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_tag`
--

LOCK TABLES `trigger_tag` WRITE;
/*!40000 ALTER TABLE `trigger_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `lastchange` int(11) NOT NULL DEFAULT '0',
  `comments` text COLLATE utf8_bin NOT NULL,
  `error` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `recovery_mode` int(11) NOT NULL DEFAULT '0',
  `recovery_expression` varchar(2048) COLLATE utf8_bin NOT NULL DEFAULT '',
  `correlation_mode` int(11) NOT NULL DEFAULT '0',
  `correlation_tag` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `manual_close` int(11) NOT NULL DEFAULT '0',
  `details` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`,`lastchange`),
  KEY `triggers_3` (`templateid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `alias` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `surname` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT '0',
  `autologout` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '15m',
  `lang` varchar(5) COLLATE utf8_bin NOT NULL DEFAULT 'en_GB',
  `refresh` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '30s',
  `type` int(11) NOT NULL DEFAULT '1',
  `theme` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT '0',
  `attempt_ip` varchar(39) COLLATE utf8_bin NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT '0',
  `rows_per_page` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`userid`),
  UNIQUE KEY `users_1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT '0',
  `users_status` int(11) NOT NULL DEFAULT '0',
  `debug_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usrgrpid`),
  UNIQUE KEY `usrgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemaps`
--

DROP TABLE IF EXISTS `valuemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuemaps` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  UNIQUE KEY `valuemaps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemaps`
--

LOCK TABLES `valuemaps` WRITE;
/*!40000 ALTER TABLE `valuemaps` DISABLE KEYS */;
/*!40000 ALTER TABLE `valuemaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget`
--

DROP TABLE IF EXISTS `widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget` (
  `widgetid` bigint(20) unsigned NOT NULL,
  `dashboardid` bigint(20) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '1',
  `height` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`widgetid`),
  KEY `widget_1` (`dashboardid`),
  CONSTRAINT `c_widget_1` FOREIGN KEY (`dashboardid`) REFERENCES `dashboard` (`dashboardid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget_field`
--

DROP TABLE IF EXISTS `widget_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget_field` (
  `widget_fieldid` bigint(20) unsigned NOT NULL,
  `widgetid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `value_groupid` bigint(20) unsigned DEFAULT NULL,
  `value_hostid` bigint(20) unsigned DEFAULT NULL,
  `value_itemid` bigint(20) unsigned DEFAULT NULL,
  `value_graphid` bigint(20) unsigned DEFAULT NULL,
  `value_sysmapid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`widget_fieldid`),
  KEY `widget_field_1` (`widgetid`),
  KEY `widget_field_2` (`value_groupid`),
  KEY `widget_field_3` (`value_hostid`),
  KEY `widget_field_4` (`value_itemid`),
  KEY `widget_field_5` (`value_graphid`),
  KEY `widget_field_6` (`value_sysmapid`),
  CONSTRAINT `c_widget_field_1` FOREIGN KEY (`widgetid`) REFERENCES `widget` (`widgetid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_2` FOREIGN KEY (`value_groupid`) REFERENCES `hstgrp` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_3` FOREIGN KEY (`value_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_4` FOREIGN KEY (`value_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_5` FOREIGN KEY (`value_graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_widget_field_6` FOREIGN KEY (`value_sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget_field`
--

LOCK TABLES `widget_field` WRITE;
/*!40000 ALTER TABLE `widget_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `widget_field` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-17 16:48:25
