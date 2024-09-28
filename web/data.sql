-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: data
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `data`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `data` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `data`;

--
-- Table structure for table `airline_company`
--

DROP TABLE IF EXISTS `airline_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline_company` (
  `airline_company_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `airline_company_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `airline_company_introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`airline_company_id`),
  KEY `idx_airline_company_person_id` (`person_id`),
  CONSTRAINT `airline_company_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline_company`
--

LOCK TABLES `airline_company` WRITE;
/*!40000 ALTER TABLE `airline_company` DISABLE KEYS */;
INSERT INTO `airline_company` VALUES (1,3,'中华人民共和国广东省广州市','南方航空（英语：China Southern Airlines，港交所：1055、上交所：600029），简称南航，是中国大陆三大国有航空公司之一，总部设在广东省广州市，主要提供中国大陆境内、两岸四地和国际航空客运、货运及邮运服务。旗下设有新疆、四川、北方、北京、深圳、海南、西安、黑龙江、吉林、大连、湖北、湖南、广西、上海以及珠海直升机等分公司和厦门航空、汕头航空、贵州航空、珠海航空、重庆航空、南航河南航空等6家附属公司。'),(2,5,'瑞士巴塞尔','瑞士国际航空（英语：Swiss International Air Lines AG），简称瑞航（SWISS）是瑞士的国家航空公司，总部设于巴塞尔，枢纽机场为苏黎世机场。瑞士国际航空是汉莎航空集团的子公司，并且为星空联盟的成员。');
/*!40000 ALTER TABLE `airline_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `airport_id` int NOT NULL,
  `city_id` int DEFAULT NULL,
  `airport_introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `airport_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `airportx` int DEFAULT NULL,
  `airporty` int DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`airport_id`),
  KEY `idx_airport_city_id` (`city_id`),
  KEY `idx_airport_name` (`airport_name`),
  CONSTRAINT `airport_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES (1,1,'北京大兴国际机场（Beijing Daxing International Airport，IATA：PKX，ICAO：ZBAD），位于中国北京市大兴区榆垡镇、礼贤镇和河北省廊坊市广阳区之间，北距天安门46千米、北距北京首都国际机场67千米、南距雄安新区55千米、西距北京南郊机场约640米（围场距离），为4F级国际机场、世界级航空枢纽、国家发展新动力源。','大兴国际机场（北京）',30,60,'正常运营'),(2,2,'上海浦东国际机场（Shanghai Pudong International Airport，IATA代码：PVG，ICAO代码：ZSPD），位于中国上海市浦东新区，距上海市中心约30公里，为4F级民用机场，是中国三大门户复合枢纽之一、长三角地区国际航空货运枢纽群成员、华东机场群成员、华东区域第一大枢纽机场、门户机场。','浦东国际机场（上海）',31,121,'正常运营'),(3,3,'西安咸阳国际机场（Xi\'an Xianyang International Airport，IATA：XIY，ICAO：ZLXY），位于中国陕西省咸阳市渭城区底张街道，距西安市区25公里，为4F级民用国际机场，是中国八大区域枢纽机场之一、国际定期航班机场、世界前百位主要机场。2014年6月成为西北第一个、中国第八个实行72小时过境免签政策的航空口岸。','咸阳国际机场（西安）',34,108,'正常运营'),(4,4,'约翰·菲茨杰拉德·肯尼迪国际机场（英语：John Fitzgerald Kennedy International Airport，IATA：JFK，ICAO：KJFK，FAA：JFK），简写作“JFKIA”，也称爱德怀德机场（Idlewild Airport），中国常简称“纽约肯尼迪国际机场”，位于美利坚合众国纽约州纽约市皇后区爱德怀德，西北距纽约市中心约21千米，为4F级国际机场、美国门户级国际航空枢纽。','肯尼迪国际机场（纽约）',40,-73,'正常运营'),(5,5,'圣弗朗西斯科国际机场（San Francisco International Airport，IATA：SFO，ICAO：KSFO，FAA：SFO），中国常称“旧金山国际机场”，位于美利坚合众国加利福尼亚州圣马特奥县机场大道，北距圣弗朗西斯科市中心约13千米，为4F级国际机场、大型航空枢纽。','圣弗朗西斯科国际机场（旧金山）',37,-122,'正常运营'),(6,6,'谢列梅捷沃亚历山大·普希金国际机场（Sheremetyevo Alexander Pushkin International Airport），位于俄罗斯莫斯科直辖市北部飞地，东南距莫斯科市中心27千米，为4F级国际机场、门户型国际航空枢纽。','普希金国际机场（莫斯科）',55,32,'正常运营'),(7,7,'成田国际机场（英语：Narita International Airport，日语：成田国际空港，IATA：NRT，ICAO：RJAA），位于日本国千叶县成田市，西距东京都中心63.5千米，为4F级国际机场、国际航空枢纽、日本国家中心机场。','成田国际机场（东京）',35,140,'正常运营'),(8,8,'大阪国际机场【日语：大阪国际空港（伊丹空港），英语：Osaka International Airport，IATA：ITM，ICAO：RJOO】，简称ITAMI，常称伊丹机场或大阪伊丹机场，位于日本国兵库县伊丹市、大阪府丰中市、池田市三地交界地带，距大阪中心城区11.5千米，为日本国家中心机场、大阪都市圈第二大机场。','大阪国际机场（大阪）',34,135,'正常运营'),(9,9,'巴黎夏尔·戴高乐机场（法语：Aéroport Paris-Charles-de-Gaulle；IATA代码：CDG；ICAO代码：LFPG），中文通称巴黎戴高乐机场及戴高乐机场，为欧洲主要的航空中心，是法国主要的国际机场，也是法国首都巴黎首要的机场。它是以法兰西第五共和国第一任总统夏尔·戴高乐的名字命名的。其位于离巴黎市中心东北25公里处的法兰西地区鲁瓦西（隶属于法兰西岛大区的瓦兹河谷省），也因此被称为鲁瓦西机场（法语：Roissy）。','夏尔·戴高乐机场（巴黎）',49,2,'正常运营'),(10,13,'希思罗机场（英语：Heathrow Airport；IATA代码：LHR；ICAO代码：EGLL）是英国首都伦敦的主要国际机场，同时是英国航空与维珍航空的枢纽机场，位于大伦敦地区西侧的希灵登区，距离伦敦城中心约23千米（14英里），拥有2条平行的东西向跑道及5座航站楼，为全英国乃至全世界最繁忙的机场之一。运营机构为希斯罗机场控股公司。\n截至2023年，希思罗机场的总客运量在全球机场中排行第5，但因拥有众多的跨境航班，若仅计算跨境的客运流量，则为全球机场第二位，自2014年起仅次于迪拜国际机场。希思罗机场同时是全欧洲最繁忙的机场，相较伊斯坦布尔机场、巴黎夏尔·戴高乐机场、阿姆斯特丹斯希普霍尔机场与法兰克福机场的客量还要高出31.5%，但航班数目则比任两个机场的总和少三分之一。这反映出由于航班数目限制下，航空公司多利用载客量高的宽体飞机（如空中客车A380、波音747、波音777）运营来往希思罗机场的航线。希思罗机场亦是全球飞机升降量和客量最高的双跑道机场。','希思罗机场（伦敦）',51,0,'正常运营');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `nation_id` int DEFAULT NULL,
  `city_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `cityx` int DEFAULT NULL,
  `cityy` int DEFAULT NULL,
  `search_times` int DEFAULT NULL,
  `time_adapter` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time_zone` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `nation_id` (`nation_id`),
  KEY `idx_city_name` (`city_name`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`nation_id`) REFERENCES `nation` (`nation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,1,'北京',39,116,10,'UTC/GMT +8','UTC/GMT +8'),(2,1,'上海',31,121,5,'UTC/GMT +8','UTC/GMT +8'),(3,1,'西安',34,108,1,'UTC/GMT +8','UTC/GMT +8'),(4,2,'纽约',40,-73,2,'UTC/GMT -5','UTC/GMT -5'),(5,2,'旧金山',37,-122,1,'UTC/GMT -8','UTC/GMT -8'),(6,3,'莫斯科',55,37,0,'UTC/GMT +3','UTC/GMT +3'),(7,4,'东京',35,139,2,'UTC/GMT +9','UTC/GMT +9'),(8,4,'大阪',34,135,1,'UTC/GMT +9','UTC/GMT +9'),(9,5,'巴黎',48,2,3,'UTC/GMT +1','UTC/GMT +1'),(10,5,'马赛',43,5,0,'UTC/GMT +1','UTC/GMT +1'),(11,NULL,'王城罗德尔',0,0,1,'虚构','虚构'),(12,2,'卡姆登（肯顿）',39,-75,0,'UTC/GMT -4','UTC/GMT -4'),(13,6,'伦敦',51,0,0,'UTC/GMT +0','UTC/GMT +0');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `client_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `amount_of_money` int DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `id_number` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `real_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `idx_client_person_id` (`person_id`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,2,99992908,'男','45010420031222013','Peng Yanjun'),(2,4,7994870,'女','45010420031222024','Polo Peng'),(3,6,1471550,'男','45010420031222129','ABC');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deal`
--

DROP TABLE IF EXISTS `deal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deal` (
  `deal_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `travel_record_id` int DEFAULT NULL,
  `seat_id` int DEFAULT NULL,
  `attribute` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `value` int DEFAULT NULL,
  PRIMARY KEY (`deal_id`),
  KEY `FKt00imcvlrn3odxamb06368kp6` (`seat_id`),
  KEY `idx_deal_client_id` (`client_id`),
  KEY `idx_deal_travel_record_id` (`travel_record_id`),
  CONSTRAINT `deal_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  CONSTRAINT `deal_ibfk_2` FOREIGN KEY (`travel_record_id`) REFERENCES `travel_record` (`travel_record_id`),
  CONSTRAINT `FKt00imcvlrn3odxamb06368kp6` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`seat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deal`
--

LOCK TABLES `deal` WRITE;
/*!40000 ALTER TABLE `deal` DISABLE KEYS */;
INSERT INTO `deal` VALUES (1,1,1,NULL,'直达','已退款','2024-08-22 11:21:01',950),(2,1,1,NULL,'直达','已退款','2024-08-22 11:21:01',1400),(3,1,1,NULL,'直达','已退款','2024-08-22 11:21:01',2000),(4,1,2,NULL,'直达','已退款','2024-09-04 09:54:28',800),(5,1,2,NULL,'直达','已退款','2024-09-04 09:54:28',1400),(6,1,2,NULL,'直达','已退款','2024-09-04 09:54:28',2100),(7,1,3,469,'直达','已付款','2024-08-21 13:02:49',1800),(8,2,4,470,'直达','已付款','2024-08-21 19:06:02',1800),(9,1,5,128,'直达','已付款','2024-08-21 22:24:43',950),(10,1,5,88,'直达','已付款','2024-08-21 22:24:52',1400),(11,1,5,505,'直达','已付款','2024-08-21 22:25:01',2600),(12,1,5,664,'直达','已付款','2024-08-21 22:25:08',1850),(13,1,5,697,'直达','已付款','2024-08-21 22:25:13',1740),(14,1,6,123,'直达','已付款','2024-08-22 20:20:48',800),(15,1,6,170,'直达','已付款','2024-08-22 11:22:25',1280),(16,1,6,508,'直达','已付款','2024-08-22 11:22:34',2600),(17,1,7,3,'直达','已付款','2024-08-26 17:07:32',1200),(18,1,8,NULL,'直达','已退款','2024-08-26 17:20:34',1800),(19,1,9,555,'直达','已付款','2024-08-31 10:10:53',1800),(21,1,NULL,NULL,'直达','已退款','2024-09-04 09:06:29',1100),(22,1,11,782,'直达','已付款','2024-09-01 08:54:54',1100),(23,1,12,783,'直达','已付款','2024-09-01 08:55:19',1100),(24,1,13,784,'直达','已付款','2024-09-01 08:56:03',1100),(25,1,14,785,'直达','已付款','2024-09-01 09:00:34',1100),(26,1,15,NULL,'直达','已退款','2024-09-02 09:27:34',1100),(27,1,16,871,'直达','已付款','2024-09-04 09:54:05',2000),(28,1,16,739,'直达','已付款','2024-09-01 12:02:09',1500),(29,1,16,592,'直达','已付款','2024-09-01 12:02:10',2310),(30,1,16,662,'直达','已付款','2024-09-01 12:02:16',1850),(31,1,16,712,'直达','已付款','2024-09-01 22:00:47',1740),(32,3,17,NULL,'直达','已退款','2024-09-02 09:41:27',2600),(33,3,18,786,'直达','已付款','2024-09-02 09:41:53',1100),(34,3,18,597,'直达','已付款','2024-09-02 09:42:04',2310),(35,3,19,787,'直达','已付款','2024-09-02 10:26:08',1200),(36,3,19,589,'直达','已付款','2024-09-02 10:26:13',2310),(37,2,21,579,'直达','已付款','2024-09-02 15:31:22',1800),(38,2,21,824,'直达','已付款','2024-09-02 15:30:33',1480),(39,3,22,NULL,'直达','已退款','2024-09-02 15:48:58',1200),(40,3,22,NULL,'直达','已退款','2024-09-02 15:48:58',950),(41,3,23,NULL,'直达','已退款','2024-09-03 11:59:03',950),(42,3,23,NULL,'直达','已退款','2024-09-03 11:59:03',1280),(43,3,23,NULL,'直达','已退款','2024-09-03 11:59:03',2300),(44,1,NULL,NULL,'直达','已退款','2024-09-04 09:08:41',1800),(45,1,24,879,'直达','已付款','2024-09-04 09:58:03',1800),(46,1,24,828,'直达','已付款','2024-09-04 09:58:09',1600),(47,3,25,876,'直达','已付款','2024-09-04 10:36:18',2000),(48,3,25,831,'直达','已付款','2024-09-04 10:36:23',1600),(49,3,26,889,'直达','已付款','2024-09-04 10:40:57',2000),(50,3,26,836,'直达','已付款','2024-09-04 10:41:00',1600),(51,3,27,873,'直达','已付款','2024-09-04 10:41:07',1600),(52,3,27,826,'直达','已付款','2024-09-04 10:41:13',1480),(53,3,28,625,'直达','已付款','2024-09-04 10:43:15',2100),(54,3,29,627,'直达','已付款','2024-09-04 10:43:22',2300),(55,3,30,7,'直达','已付款','2024-09-05 20:44:14',1200),(56,3,30,283,'直达','已付款','2024-09-05 20:44:19',2100),(57,3,30,1405,'直达','已付款','2024-09-05 20:44:22',1980),(58,3,31,12,'直达','已付款','2024-09-05 20:44:38',1000),(59,3,31,288,'直达','已付款','2024-09-05 20:44:42',2100),(60,3,31,1410,'直达','已付款','2024-09-05 20:44:45',1980),(61,3,32,901,'直达','已付款','2024-09-05 20:47:03',2000),(62,3,32,841,'直达','已付款','2024-09-05 20:47:06',1600),(63,3,33,902,'直达','已付款','2024-09-05 20:47:17',2000),(64,3,33,842,'直达','已付款','2024-09-05 20:47:27',1600),(65,3,34,NULL,'直达','已退款','2024-09-05 20:49:05',2000),(66,3,34,NULL,'直达','已退款','2024-09-05 20:49:05',1600),(67,3,35,NULL,'直达','已退款','2024-09-05 20:49:59',1800),(68,3,35,NULL,'直达','已退款','2024-09-05 20:49:59',1600),(69,3,36,553,'直达','已付款','2024-09-05 20:51:12',1800),(70,3,36,1093,'直达','已付款','2024-09-05 20:51:15',2150);
/*!40000 ALTER TABLE `deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictionary` (
  `id` int NOT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `label` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `pid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
INSERT INTO `dictionary` VALUES (1,'XBM','性别码',NULL),(2,'1','男',1),(3,'2','女',1);
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (21),(21),(21),(21),(21),(21),(21);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `user_type_ids` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,NULL,'个人信息',NULL,'1,2,3,4,5'),(2,NULL,'系统管理',NULL,'1,4,5'),(3,NULL,'人员管理',NULL,'1'),(4,NULL,'信息中心',NULL,'1,4,5'),(11,'SystemIntroduce','系统简介',1,'1,2,3'),(12,'Password','修改密码',1,'1,2,3'),(13,'ProjectHtml','项目文档',1,'1,2'),(14,'ProjectVideo','项目视频',1,'1,2'),(15,'StudentIntroduce','个人简介',1,'2'),(16,'TeacherIntroduce','个人简介',1,'3'),(17,'ChangeEmail','修改邮箱',1,'1,2,3,4,5'),(18,'Try','尝试',1,'1,2'),(21,'menu-manage-panel','菜单管理',2,'1'),(22,'dictionary-manage-panel','字典管理',2,'1'),(31,'student-panel','学生管理',3,'1'),(32,'teacher-panel','教师管理',3,'1'),(41,'course-panel-admin','课程管理',4,'1'),(42,'score-table-admin-panel','成绩管理',4,'1'),(43,'StudentQuery','学生信息查询',1,'1,2,3'),(44,'TeacherQuery','教师信息查询',1,'1,2,3'),(45,'StudentPractice','社会实践管理',1,'2'),(46,'PracticeAudit','社会实践审核',1,'1'),(47,'AwardAudit','奖励管理',1,'1'),(48,'Message','消息中心',1,'1,2,3,4,5'),(49,'AwardApply','奖项申请',1,'2,3'),(50,'ActivityAudit','课外活动审核',1,'1'),(51,'Activities','课外活动管理',1,'2'),(52,'score-table-teacher-panel','成绩管理',4,'3'),(53,'course-panel-student-choose','选课管理',19,'2'),(54,'course-panel-student-Info','课程信息',19,'2'),(55,'course-panel-student-graph','课表',19,'2'),(56,'ClientCenter','用户中心',1,'1,4'),(57,'AirlineCompanyCenter','用户中心',1,'1,5'),(58,'Search','飞机票预订查询',4,'1,4'),(59,'PublishFlights','发布新航班',4,'1,5');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `message_id` int NOT NULL,
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `from_user` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `if_read` int DEFAULT NULL,
  `time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `to_user` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'测试','Polo Peng',1,'2024-08-18 15:29:56','PYJ'),(2,'你好','PYJ',1,'2024-08-18 15:31:41','Polo Peng'),(3,'123','Polo Peng',1,'2024-08-18 15:33:22','PYJ'),(4,'...','PYJ',1,'2024-08-26 17:49:43','Polo Peng'),(5,'修改项测试','Polo Peng',1,'2024-08-26 17:54:48','PYJ'),(6,'测试1','PYJ',1,'2024-08-26 17:57:36','Polo Peng'),(7,'测试2','Polo Peng',1,'2024-08-26 17:58:46','PYJ'),(8,'测试','Try',1,'2024-09-02 09:43:28','PYJ'),(9,'测试-admin','管理员',1,'2024-09-02 09:44:32','Try');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modify_log`
--

DROP TABLE IF EXISTS `modify_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modify_log` (
  `id` int NOT NULL,
  `table_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `info` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `operate_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_modify_log_operate_time` (`operate_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modify_log`
--

LOCK TABLES `modify_log` WRITE;
/*!40000 ALTER TABLE `modify_log` DISABLE KEYS */;
INSERT INTO `modify_log` VALUES (1,'Student','1','{`studentId`:1,`major`:`软件工程`,`className`:`软1`,`numName`:`2022030001-杨平`}','2023-07-06 16:39:29',1),(2,'Student','1','{`studentId`:3,`major`:``,`className`:``,`term`:`大二第一学年`,`name`:`兰玉坤`,`num`:`202222300281`,`numName`:`202222300281-兰玉坤`}','2023-12-21 23:12:16',1),(3,'Student','1','{`studentId`:1,`major`:`软件工程`,`className`:`软1`,`term`:`大一第一学年`,`name`:`拉达冈`,`num`:`2022030001`,`numName`:`2022030001-拉达冈`}','2023-12-21 23:15:50',1),(4,'Student','1','{`studentId`:2,`major`:`软件工程`,`className`:`软2`,`term`:`大三第二学年`,`name`:`蒂法`,`num`:`2022030002`,`numName`:`2022030002-蒂法`}','2023-12-21 23:15:54',1),(5,'Student','1','{`studentId`:3,`major`:``,`className`:``,`term`:`大二第一学年`,`name`:`兰玉坤`,`num`:`202222300281`,`numName`:`202222300281-兰玉坤`}','2023-12-21 23:16:07',1),(6,'Student','1','{`studentId`:3,`major`:``,`className`:``,`term`:`大二第一学年`,`name`:`兰玉坤`,`num`:`202222300281`,`numName`:`202222300281-兰玉坤`}','2023-12-21 23:16:16',1),(7,'Student','1','{`studentId`:1,`major`:`软件工程`,`className`:`八班`,`term`:`大二第一学年`,`name`:`梁司懿`,`numName`:`202200300319-梁司懿`,`num`:`202200300319`}','2023-12-23 01:01:37',1),(8,'Student','1','{`studentId`:2,`major`:`软件工程`,`className`:``,`blog`:`https://sss0458.github.io/`,`term`:`大二第一学年`,`name`:`杨平`,`num`:`2022001`,`numName`:`2022001-杨平`}','2023-12-23 14:01:05',1),(9,'Student','1','{`studentId`:3,`major`:`软件工程`,`className`:``,`blog`:`https://jincsjw.github.io/`,`term`:`大一第二学年`,`name`:`李四`,`num`:`2022002`,`numName`:`2022002-李四`}','2023-12-23 14:01:12',1),(10,'Student','1','{`studentId`:3,`major`:`软件工程`,`className`:``,`blog`:`https://jincsjw.github.io/`,`term`:`大一第二学年`,`name`:`张菊`,`num`:`2022002`,`numName`:`2022002-张菊`}','2023-12-23 14:02:16',1),(11,'Student','1','{`studentId`:1,`major`:`软件工程`,`className`:`八班`,`blog`:null,`term`:`大二第一学年`,`name`:`梁司懿`,`num`:`202200300319`,`numName`:`202200300319-梁司懿`}','2023-12-23 14:59:59',1),(12,'Student','1','{`studentId`:2,`major`:`软件工程`,`className`:``,`blog`:`https://sss0458.github.io/`,`term`:`大二第一学年`,`name`:`杨平`,`num`:`2022001`,`numName`:`2022001-杨平`}','2023-12-23 15:36:49',1),(13,'Student','1','{`studentId`:5,`major`:`软件工程`,`className`:`一班`,`blog`:null,`term`:`大二第一学年`,`name`:`新用户`,`num`:`2022003`,`numName`:`2022003-新用户`}','2023-12-23 15:37:15',1);
/*!40000 ALTER TABLE `modify_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nation`
--

DROP TABLE IF EXISTS `nation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nation` (
  `nation_id` int NOT NULL,
  `nation_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`nation_id`),
  KEY `idx_nation_name` (`nation_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nation`
--

LOCK TABLES `nation` WRITE;
/*!40000 ALTER TABLE `nation` DISABLE KEYS */;
INSERT INTO `nation` VALUES (1,'中国'),(3,'俄罗斯'),(4,'日本'),(5,'法国'),(2,'美国'),(6,'英国');
/*!40000 ALTER TABLE `nation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` int NOT NULL,
  `person_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `date` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `idx_notification_person_id` (`person_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,2,'欢迎！','欢迎您的注册及使用，我们将竭诚为您服务。','2024-08-21','已读'),(2,3,'航班状态更新','G089 当前状态更新为： 航班已起飞','2024-08-22','未读'),(3,2,'航班状态更新','G089 当前状态更新为： 航班已起飞','2024-08-22','已读'),(4,4,'航班状态更新','G089 当前状态更新为： 航班已起飞','2024-08-22','已读'),(5,3,'航班状态更新','G089 当前状态更新为： 航班已安全到达','2024-08-22','未读'),(6,2,'航班状态更新','G089 当前状态更新为： 航班已安全到达','2024-08-22','已读'),(7,4,'航班状态更新','G089 当前状态更新为： 航班已安全到达','2024-08-22','已读'),(8,2,'改签成功','已为您改签！您的新航班为 G020 ,此次改签差价为： 200 ￥','2024-08-26','已读'),(9,2,'改签成功','已为您改签！您的新航班为 G001 ,此次改签差价为： 0 ￥','2024-08-26','已读'),(10,2,'景区购票成功','购票成功！景区： 故宫（紫禁城） ,总价格： 150 ￥,共 3 张门票','2024-08-26','已读'),(11,2,'景区退票成功','退票成功！退款： 50 ￥已经返还到您的账户','2024-08-26','已读'),(12,2,'景区退票成功','退票成功！退款： 50 ￥已经返还到您的账户','2024-08-26','已读'),(13,2,'景区退票成功','退票成功！退款： 50 ￥已经返还到您的账户','2024-08-26','已读'),(14,2,'购票成功','购票成功！航班： R203 ,价格： 1800 ￥','2024-08-26','已读'),(15,2,'改签成功','已为您改签！您的新航班为 R203 ,此次改签差价为： 0 ￥','2024-08-26','已读'),(16,2,'全部退票成功','已为您全部退票！,您的退款 1800 ￥已到账。','2024-08-26','已读'),(17,2,'景区购票成功','购票成功！景区： 新泽西号战列舰 (BB-62) ,总价格： 210 ￥,共 1 张门票','2024-08-26','已读'),(18,2,'购票成功','购票成功！航班： G001 ,价格： 1200 ￥','2024-08-29','已读'),(19,2,'购票成功','购票成功！航班： R010 ,价格： 2600 ￥','2024-08-29','已读'),(20,2,'购票成功','购票成功！航班： G103 ,价格： 950 ￥','2024-08-29','已读'),(21,2,'购票成功','购票成功！航班： G125 ,价格： 1280 ￥','2024-08-29','已读'),(22,2,'取消购票成功','已为您取消本次购票！退款金额 2230 ￥已返还您的账户。','2024-08-29','已读'),(23,2,'购票成功','购票成功！航班： G103 ,价格： 800 ￥','2024-08-29','已读'),(24,2,'取消购票成功','已为您取消本次购票！退款金额 800 ￥已返还您的账户。','2024-08-29','已读'),(25,2,'购票成功','购票成功！航班： R203 ,价格： 1800 ￥','2024-08-31','已读'),(26,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-01','已读'),(27,2,'购票成功','购票成功！航班： R203 ,价格： 1800 ￥','2024-09-01','已读'),(28,2,'购票成功','购票成功！航班： R100 ,价格： 1500 ￥','2024-09-01','已读'),(29,2,'购票成功','购票成功！航班： R108 ,价格： 2310 ￥','2024-09-01','已读'),(30,2,'购票成功','购票成功！航班： R007 ,价格： 1850 ￥','2024-09-01','已读'),(31,2,'购票成功','购票成功！航班： R141 ,价格： 1740 ￥','2024-09-01','已读'),(32,2,'改签成功','已为您改签！您的新航班为 R203 ,此次改签差价为： 0 ￥','2024-09-01','已读'),(33,2,'景区购票成功','购票成功！景区： 天守阁（姬路城） ,总价格： 120 ￥,共 3 张门票','2024-09-01','已读'),(34,2,'全部退票成功','已为您全部退票！,您的退款 1100 ￥已到账。','2024-09-02','已读'),(35,3,'航班状态更新','G277 当前状态更新为： 可正常购票/退票','2024-09-02','未读'),(44,3,'航班状态更新','G277 当前状态更新为： 余票售罄','2024-09-02','未读'),(45,4,'购票成功','购票成功！航班： R203 ,价格： 1600 ￥','2024-09-02','已读'),(46,4,'购票成功','购票成功！航班： G947 ,价格： 1480 ￥','2024-09-02','已读'),(47,4,'改签成功','已为您改签！您的新航班为 R203 ,此次改签差价为： -200 ￥','2024-09-02','已读'),(48,6,'购票成功','购票成功！航班： G001 ,价格： 1200 ￥','2024-09-02','已读'),(49,6,'购票成功','购票成功！航班： R149 ,价格： 950 ￥','2024-09-02','已读'),(50,6,'全部退票成功','已为您全部退票！,您的退款 2150 ￥已到账。','2024-09-02','已读'),(51,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(52,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(53,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(54,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(55,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(56,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(57,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(58,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(59,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(60,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(61,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(62,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(63,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(64,4,'景区购票成功','购票成功！景区： 故宫（紫禁城） ,总价格： 100 ￥,共 2 张门票','2024-09-03','已读'),(65,6,'购票成功','购票成功！航班： G103 ,价格： 950 ￥','2024-09-03','已读'),(66,6,'购票成功','购票成功！航班： G125 ,价格： 1280 ￥','2024-09-03','已读'),(67,6,'购票成功','购票成功！航班： R602 ,价格： 2300 ￥','2024-09-03','已读'),(68,6,'全部退票成功','已为您全部退票！,您的退款 4530 ￥已到账。','2024-09-03','已读'),(69,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-03','未读'),(70,2,'购票数据异常','您的上次购票似乎异常退出,已为您退票！您的退款 1100 ￥已到账。','2024-09-04','未读'),(71,3,'航班状态更新','G277 当前状态更新为： 可正常购票/退票','2024-09-04','未读'),(72,2,'购票成功','购票成功！航班： R203 ,价格： 1800 ￥','2024-09-04','未读'),(73,2,'购票数据异常','您的上次购票似乎异常退出,已为您退票！您的退款 1800 ￥已到账。','2024-09-04','未读'),(74,2,'取消购票成功','已为您取消本次购票！退款金额 0 ￥已返还您的账户。','2024-09-04','未读'),(75,2,'购票成功','购票成功！航班： G001 ,价格： 1200 ￥','2024-09-04','未读'),(76,2,'取消购票成功','已为您取消本次购票！退款金额 1200 ￥已返还您的账户。','2024-09-04','未读'),(77,2,'改签成功','已为您改签！您的新航班为 G014 ,此次改签差价为： -200 ￥','2024-09-04','未读'),(78,2,'改签成功','已为您改签！您的新航班为 R203 ,此次改签差价为： 200 ￥','2024-09-04','未读'),(79,2,'改签成功','已为您改签！您的新航班为 G014 ,此次改签差价为： -200 ￥','2024-09-04','未读'),(80,2,'全部退票成功','已为您全部退票！,您的退款 4300 ￥已到账。','2024-09-04','未读'),(81,2,'购票成功','购票成功！航班： G014 ,价格： 1800 ￥','2024-09-04','未读'),(82,2,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-04','未读'),(83,6,'购票成功','购票成功！航班： G014 ,价格： 2000 ￥','2024-09-04','未读'),(84,6,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-04','未读'),(85,6,'购票成功','购票成功！航班： G014 ,价格： 2000 ￥','2024-09-04','未读'),(86,6,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-04','未读'),(87,6,'购票成功','购票成功！航班： G014 ,价格： 1600 ￥','2024-09-04','未读'),(88,6,'购票成功','购票成功！航班： G947 ,价格： 1480 ￥','2024-09-04','未读'),(89,6,'购票成功','购票成功！航班： R602 ,价格： 2100 ￥','2024-09-04','未读'),(90,6,'购票成功','购票成功！航班： R602 ,价格： 2300 ￥','2024-09-04','未读'),(91,6,'购票成功','购票成功！航班： G001 ,价格： 1200 ￥','2024-09-05','未读'),(92,6,'购票成功','购票成功！航班： G038 ,价格： 2100 ￥','2024-09-05','未读'),(93,6,'购票成功','购票成功！航班： R709 ,价格： 1980 ￥','2024-09-05','未读'),(94,6,'购票成功','购票成功！航班： G001 ,价格： 1000 ￥','2024-09-05','未读'),(95,6,'购票成功','购票成功！航班： G038 ,价格： 2100 ￥','2024-09-05','未读'),(96,6,'购票成功','购票成功！航班： R709 ,价格： 1980 ￥','2024-09-05','未读'),(97,6,'购票成功','购票成功！航班： G014 ,价格： 2000 ￥','2024-09-05','未读'),(98,6,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-05','未读'),(99,6,'购票成功','购票成功！航班： G014 ,价格： 2000 ￥','2024-09-05','未读'),(100,6,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-05','未读'),(101,6,'购票成功','购票成功！航班： G014 ,价格： 2000 ￥','2024-09-05','未读'),(102,6,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-05','未读'),(103,6,'改签成功','已为您改签！您的新航班为 G014 ,此次改签差价为： 0 ￥','2024-09-05','未读'),(104,6,'全部退票成功','已为您全部退票！,您的退款 3600 ￥已到账。','2024-09-05','未读'),(105,6,'购票成功','购票成功！航班： G014 ,价格： 1800 ￥','2024-09-05','未读'),(106,6,'购票成功','购票成功！航班： G947 ,价格： 1600 ￥','2024-09-05','未读'),(107,6,'全部退票成功','已为您全部退票！,您的退款 3400 ￥已到账。','2024-09-05','未读'),(108,6,'购票成功','购票成功！航班： R203 ,价格： 1800 ￥','2024-09-05','未读'),(109,6,'购票成功','购票成功！航班： G473 ,价格： 2150 ￥','2024-09-05','未读');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peer`
--

DROP TABLE IF EXISTS `peer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peer` (
  `peer_id` int NOT NULL,
  `art` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `labour` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `morality` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sport` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `study` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  PRIMARY KEY (`peer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peer`
--

LOCK TABLES `peer` WRITE;
/*!40000 ALTER TABLE `peer` DISABLE KEYS */;
INSERT INTO `peer` VALUES (1,'4.3','4.5','4.7','4.9','4.7',1),(2,'0.5','0.5','1.0','0.5','0.5',1),(3,'4.5','3.0','3.5','4.5','2.5',3),(4,'1.5','4.5','3.5','5.0','3.0',2);
/*!40000 ALTER TABLE `peer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `person_id` int NOT NULL,
  `num` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `UKq0qdoubuenhgp186mv738fo1` (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'admin','管理员','0','x@sdu.edu.cn',NULL),(2,'C466668210','PYJ','3','3149483432@qq.com','19163836015'),(3,'A553167','南方航空','4','pyj20031223@outlook.com','19163836015'),(4,'C754303860','Polo Peng','3','19163836015@163.com','15994383896'),(5,'A464825','瑞士国际航空','4','1122334455@123.com','+41 (0)84 870 07 00'),(6,'C262695319','Try','3','Try@456.com','123456789');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plane`
--

DROP TABLE IF EXISTS `plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plane` (
  `plane_id` int NOT NULL,
  `airline_company_id` int DEFAULT NULL,
  `departure_airport` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `arrival_airport` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `start_city` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `end_city` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `start_day` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `end_day` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `start_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `end_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `number_all` int DEFAULT NULL,
  `number_rest` int DEFAULT NULL,
  `plane_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `plane_status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`plane_id`),
  KEY `idx_plane_airline_company_id` (`airline_company_id`),
  KEY `idx_plane_arrival_airport` (`arrival_airport`),
  KEY `idx_plane_departure_airport` (`departure_airport`),
  CONSTRAINT `plane_ibfk_1` FOREIGN KEY (`airline_company_id`) REFERENCES `airline_company` (`airline_company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plane`
--

LOCK TABLES `plane` WRITE;
/*!40000 ALTER TABLE `plane` DISABLE KEYS */;
INSERT INTO `plane` VALUES (1,1,'大兴国际机场（北京）','成田国际机场（东京）','北京','东京','2024-09-08','2024-09-08','20:45:00','22:30:00',36,33,'G001','可正常购票/退票'),(2,1,'大兴国际机场（北京）','成田国际机场（东京）','北京','东京','2024-09-08','2024-09-08','10:30:00','12:50:00',48,48,'G020','可正常购票/退票'),(3,1,'浦东国际机场（上海）','成田国际机场（东京）','上海','东京','2024-09-08','2024-09-09','22:50:47','02:25:00',36,35,'G100','可正常购票/退票'),(4,1,'大兴国际机场（北京）','浦东国际机场（上海）','北京','上海','2024-09-08','2024-09-08','08:00:00','09:25:00',48,46,'G103','可正常购票/退票'),(5,1,'浦东国际机场（上海）','成田国际机场（东京）','上海','东京','2024-09-08','2024-09-09','13:05:00','02:55:00',36,35,'G125','可正常购票/退票'),(6,1,'大兴国际机场（北京）','肯尼迪国际机场（纽约）','北京','纽约','2024-09-08','2024-09-09','18:15:00','06:00:00',36,36,'G401','可正常购票/退票'),(7,1,'成田国际机场（东京）','肯尼迪国际机场（纽约）','东京','纽约','2024-09-10','2024-09-10','08:00:00','16:10:00',36,36,'G612','可正常购票/退票'),(8,1,'成田国际机场（东京）','肯尼迪国际机场（纽约）','东京','纽约','2024-09-09','2024-09-10','22:00:41','05:05:00',48,46,'G038','可正常购票/退票'),(9,1,'大兴国际机场（北京）','圣弗朗西斯科国际机场（旧金山）','北京','旧金山','2024-09-08','2024-09-08','12:00:00','18:05:00',36,36,'G061','可正常购票/退票'),(10,1,'圣弗朗西斯科国际机场（旧金山）','肯尼迪国际机场（纽约）','旧金山','纽约','2024-09-10','2024-09-10','09:20:45','12:18:46',36,36,'G077','可正常购票/退票'),(11,1,'成田国际机场（东京）','圣弗朗西斯科国际机场（旧金山）','东京','旧金山','2024-09-11','2024-09-11','12:20:57','17:05:00',36,36,'G140','可正常购票/退票'),(12,1,'浦东国际机场（上海）','肯尼迪国际机场（纽约）','上海','纽约','2024-09-09','2024-09-09','13:23:54','16:05:18',36,36,'G901','可正常购票/退票'),(13,1,'肯尼迪国际机场（纽约）','夏尔·戴高乐机场（巴黎）','纽约','巴黎','2024-08-22','2024-08-22','07:30:00','14:50:00',36,34,'G089','航班已安全到达'),(14,2,'成田国际机场（东京）','夏尔·戴高乐机场（巴黎）','东京','巴黎','2024-09-09','2024-09-09','10:00:55','16:05:00',48,46,'R010','可正常购票/退票'),(15,2,'大兴国际机场（北京）','普希金国际机场（莫斯科）','北京','莫斯科','2024-09-08','2024-09-08','12:05:31','16:04:31',36,33,'R203','可正常购票/退票'),(16,2,'浦东国际机场（上海）','夏尔·戴高乐机场（巴黎）','上海','巴黎','2024-09-10','2024-09-11','20:06:29','07:05:29',36,33,'R108','可正常购票/退票'),(17,2,'成田国际机场（东京）','肯尼迪国际机场（纽约）','东京','纽约','2024-09-09','2024-09-10','19:08:33','05:10:33',36,34,'R602','可正常购票/退票'),(18,2,'夏尔·戴高乐机场（巴黎）','浦东国际机场（上海）','巴黎','上海','2024-09-12','2024-09-12','01:00:00','09:00:31',36,34,'R007','可正常购票/退票'),(19,2,'浦东国际机场（上海）','肯尼迪国际机场（纽约）','上海','纽约','2024-09-12','2024-09-12','11:13:03','17:10:03',36,34,'R141','可正常购票/退票'),(20,2,'普希金国际机场（莫斯科）','浦东国际机场（上海）','莫斯科','上海','2024-09-10','2024-09-10','14:10:39','18:20:21',48,47,'R100','可正常购票/退票'),(21,1,'成田国际机场（东京）','浦东国际机场（上海）','东京','上海','2024-09-09','2024-09-09','08:48:43','11:40:43',6,1,'G277','可正常购票/退票'),(22,2,'成田国际机场（东京）','浦东国际机场（上海）','东京','上海','2024-09-09','2024-09-09','09:22:58','12:40:58',36,35,'R149','可正常购票/退票'),(23,1,'普希金国际机场（莫斯科）','希思罗机场（伦敦）','莫斯科','伦敦','2024-09-11','2024-09-12','17:26:27','02:15:05',24,17,'G947','可正常购票/退票'),(24,1,'大兴国际机场（北京）','成田国际机场（东京）','北京','东京','2024-09-08','2024-09-08','02:00:15','06:10:06',24,24,'G974','可正常购票/退票'),(25,1,'大兴国际机场（北京）','普希金国际机场（莫斯科）','北京','莫斯科','2024-09-08','2024-09-09','20:43:55','05:32:15',36,29,'G014','可正常购票/退票'),(26,1,'咸阳国际机场（西安）','肯尼迪国际机场（纽约）','西安','纽约','2024-09-10','2024-09-11','15:09:50','04:06:50',24,24,'G640','可正常购票/退票'),(27,1,'大兴国际机场（北京）','咸阳国际机场（西安）','北京','西安','2024-09-08','2024-09-09','22:30:34','02:00:00',18,18,'G247','可正常购票/退票'),(28,1,'浦东国际机场（上海）','成田国际机场（东京）','上海','东京','2024-09-09','2024-09-09','12:15:19','15:09:19',24,24,'G910','可正常购票/退票'),(29,1,'浦东国际机场（上海）','咸阳国际机场（西安）','上海','西安','2024-09-09','2024-09-09','12:08:23','15:17:23',24,24,'G906','可正常购票/退票'),(30,2,'咸阳国际机场（西安）','成田国际机场（东京）','西安','东京','2024-09-09','2024-09-09','07:10:46','14:05:00',36,36,'R774','可正常购票/退票'),(31,1,'咸阳国际机场（西安）','圣弗朗西斯科国际机场（旧金山）','西安','旧金山','2024-09-09','2024-09-10','17:30:00','05:00:00',24,24,'G037','可正常购票/退票'),(32,1,'成田国际机场（东京）','夏尔·戴高乐机场（巴黎）','东京','巴黎','2024-09-11','2024-09-12','18:30:33','08:40:33',36,36,'G001','可正常购票/退票'),(33,1,'普希金国际机场（莫斯科）','希思罗机场（伦敦）','莫斯科','伦敦','2024-09-11','2024-09-12','16:55:46','03:54:00',18,17,'G473','可正常购票/退票'),(34,1,'夏尔·戴高乐机场（巴黎）','圣弗朗西斯科国际机场（旧金山）','巴黎','旧金山','2024-09-12','2024-09-12','08:40:00','16:30:40',36,36,'G170','可正常购票/退票'),(35,1,'圣弗朗西斯科国际机场（旧金山）','肯尼迪国际机场（纽约）','旧金山','纽约','2024-09-12','2024-09-13','20:43:59','01:21:59',18,18,'G172','可正常购票/退票'),(36,1,'普希金国际机场（莫斯科）','夏尔·戴高乐机场（巴黎）','莫斯科','巴黎','2024-09-10','2024-09-10','13:56:30','19:35:30',48,48,'G176','可正常购票/退票'),(37,1,'希思罗机场（伦敦）','夏尔·戴高乐机场（巴黎）','伦敦','巴黎','2024-09-12','2024-09-12','14:58:36','16:40:00',18,18,'G281','可正常购票/退票'),(38,2,'夏尔·戴高乐机场（巴黎）','肯尼迪国际机场（纽约）','巴黎','纽约','2024-09-13','2024-09-14','20:04:25','07:00:00',24,24,'R703','可正常购票/退票'),(39,2,'大阪国际机场（大阪）','圣弗朗西斯科国际机场（旧金山）','大阪','旧金山','2024-09-10','2024-09-10','08:00:00','16:00:00',24,24,'R205','可正常购票/退票'),(40,2,'大兴国际机场（北京）','大阪国际机场（大阪）','北京','大阪','2024-09-09','2024-09-09','14:00:00','17:05:00',18,18,'R908','可正常购票/退票'),(41,2,'大阪国际机场（大阪）','咸阳国际机场（西安）','大阪','西安','2024-09-10','2024-09-10','11:15:19','14:00:00',18,18,'R093','可正常购票/退票'),(42,2,'成田国际机场（东京）','大阪国际机场（大阪）','东京','大阪','2024-09-09','2024-09-09','10:20:10','11:10:08',18,18,'R019','可正常购票/退票'),(43,2,'大阪国际机场（大阪）','肯尼迪国际机场（纽约）','大阪','纽约','2024-09-13','2024-09-13','08:20:00','17:40:00',24,24,'R049','可正常购票/退票'),(44,2,'肯尼迪国际机场（纽约）','希思罗机场（伦敦）','纽约','伦敦','2024-09-13','2024-09-14','22:00:00','07:05:00',18,18,'R909','可正常购票/退票'),(45,2,'希思罗机场（伦敦）','普希金国际机场（莫斯科）','伦敦','莫斯科','2024-09-14','2024-09-14','12:00:00','20:00:00',24,24,'R955','可正常购票/退票'),(46,2,'肯尼迪国际机场（纽约）','夏尔·戴高乐机场（巴黎）','纽约','巴黎','2024-09-10','2024-09-10','12:10:59','20:00:00',24,22,'R709','可正常购票/退票'),(47,2,'夏尔·戴高乐机场（巴黎）','希思罗机场（伦敦）','巴黎','伦敦','2024-09-13','2024-09-14','23:00:00','01:00:00',18,18,'R841','可正常购票/退票'),(48,2,'希思罗机场（伦敦）','咸阳国际机场（西安）','伦敦','西安','2024-09-14','2024-09-14','07:30:00','17:00:00',24,24,'R883','可正常购票/退票'),(49,2,'成田国际机场（东京）','普希金国际机场（莫斯科）','东京','莫斯科','2024-09-10','2024-09-10','07:00:00','13:30:00',18,18,'R770','可正常购票/退票'),(50,2,'浦东国际机场（上海）','夏尔·戴高乐机场（巴黎）','上海','巴黎','2024-09-11','2024-09-12','20:40:00','07:00:00',24,24,'R501','可正常购票/退票');
/*!40000 ALTER TABLE `plane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_log`
--

DROP TABLE IF EXISTS `request_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request_log` (
  `id` int NOT NULL,
  `username` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `start_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `request_time` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_request_log_start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_log`
--

LOCK TABLES `request_log` WRITE;
/*!40000 ALTER TABLE `request_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `seat_id` int NOT NULL,
  `deal_id` int DEFAULT NULL,
  `plane_id` int DEFAULT NULL,
  `is_booked` int NOT NULL,
  `level` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `price` int DEFAULT NULL,
  `seat_column_number` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `seat_row_number` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `idx_seat_deal_id` (`deal_id`),
  KEY `idx_seat_plane_id` (`plane_id`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`deal_id`) REFERENCES `deal` (`deal_id`),
  CONSTRAINT `seat_ibfk_2` FOREIGN KEY (`plane_id`) REFERENCES `plane` (`plane_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (1,NULL,1,0,'经济座',1000,'A','1'),(2,NULL,1,0,'经济座',1000,'B','1'),(3,17,1,1,'经济座',1000,'C','1'),(4,NULL,1,0,'经济座',1000,'D','1'),(5,NULL,1,0,'经济座',1000,'E','1'),(6,NULL,1,0,'经济座',1000,'F','1'),(7,55,1,1,'经济座',1000,'A','2'),(8,NULL,1,0,'经济座',1000,'B','2'),(9,NULL,1,0,'经济座',1000,'C','2'),(10,NULL,1,0,'经济座',1000,'D','2'),(11,NULL,1,0,'经济座',1000,'E','2'),(12,58,1,1,'经济座',1000,'F','2'),(13,NULL,1,0,'经济座',1000,'A','3'),(14,NULL,1,0,'经济座',1000,'B','3'),(15,NULL,1,0,'经济座',1000,'C','3'),(16,NULL,1,0,'经济座',1000,'D','3'),(17,NULL,1,0,'经济座',1000,'E','3'),(18,NULL,1,0,'经济座',1000,'F','3'),(19,NULL,1,0,'经济座',1000,'A','4'),(20,NULL,1,0,'经济座',1000,'B','4'),(21,NULL,1,0,'经济座',1000,'C','4'),(22,NULL,1,0,'经济座',1000,'D','4'),(23,NULL,1,0,'经济座',1000,'E','4'),(24,NULL,1,0,'经济座',1000,'F','4'),(25,NULL,1,0,'经济座',1000,'A','5'),(26,NULL,1,0,'经济座',1000,'B','5'),(27,NULL,1,0,'经济座',1000,'C','5'),(28,NULL,1,0,'经济座',1000,'D','5'),(29,NULL,1,0,'经济座',1000,'E','5'),(30,NULL,1,0,'经济座',1000,'F','5'),(31,NULL,1,0,'经济座',1000,'A','6'),(32,NULL,1,0,'经济座',1000,'B','6'),(33,NULL,1,0,'经济座',1000,'C','6'),(34,NULL,1,0,'经济座',1000,'D','6'),(35,NULL,1,0,'经济座',1000,'E','6'),(36,NULL,1,0,'经济座',1000,'F','6'),(37,NULL,2,0,'经济座',1100,'A','1'),(38,NULL,2,0,'经济座',1100,'B','1'),(39,NULL,2,0,'经济座',1100,'C','1'),(40,NULL,2,0,'经济座',1100,'D','1'),(41,NULL,2,0,'经济座',1100,'E','1'),(42,NULL,2,0,'经济座',1100,'F','1'),(43,NULL,2,0,'经济座',1100,'A','2'),(44,NULL,2,0,'经济座',1100,'B','2'),(45,NULL,2,0,'经济座',1100,'C','2'),(46,NULL,2,0,'经济座',1100,'D','2'),(47,NULL,2,0,'经济座',1100,'E','2'),(48,NULL,2,0,'经济座',1100,'F','2'),(49,NULL,2,0,'经济座',1100,'A','3'),(50,NULL,2,0,'经济座',1100,'B','3'),(51,NULL,2,0,'经济座',1100,'C','3'),(52,NULL,2,0,'经济座',1100,'D','3'),(53,NULL,2,0,'经济座',1100,'E','3'),(54,NULL,2,0,'经济座',1100,'F','3'),(55,NULL,2,0,'经济座',1100,'A','4'),(56,NULL,2,0,'经济座',1100,'B','4'),(57,NULL,2,0,'经济座',1100,'C','4'),(58,NULL,2,0,'经济座',1100,'D','4'),(59,NULL,2,0,'经济座',1100,'E','4'),(60,NULL,2,0,'经济座',1100,'F','4'),(61,NULL,2,0,'经济座',1100,'A','5'),(62,NULL,2,0,'经济座',1100,'B','5'),(63,NULL,2,0,'经济座',1100,'C','5'),(64,NULL,2,0,'经济座',1100,'D','5'),(65,NULL,2,0,'经济座',1100,'E','5'),(66,NULL,2,0,'经济座',1100,'F','5'),(67,NULL,2,0,'经济座',1100,'A','6'),(68,NULL,2,0,'经济座',1100,'B','6'),(69,NULL,2,0,'经济座',1100,'C','6'),(70,NULL,2,0,'经济座',1100,'D','6'),(71,NULL,2,0,'经济座',1100,'E','6'),(72,NULL,2,0,'经济座',1100,'F','6'),(73,NULL,2,0,'经济座',1100,'A','7'),(74,NULL,2,0,'经济座',1100,'B','7'),(75,NULL,2,0,'经济座',1100,'C','7'),(76,NULL,2,0,'经济座',1100,'D','7'),(77,NULL,2,0,'经济座',1100,'E','7'),(78,NULL,2,0,'经济座',1100,'F','7'),(79,NULL,2,0,'经济座',1100,'A','8'),(80,NULL,2,0,'经济座',1100,'B','8'),(81,NULL,2,0,'经济座',1100,'C','8'),(82,NULL,2,0,'经济座',1100,'D','8'),(83,NULL,2,0,'经济座',1100,'E','8'),(84,NULL,2,0,'经济座',1100,'F','8'),(85,NULL,3,0,'经济座',1150,'A','1'),(86,NULL,3,0,'经济座',1150,'B','1'),(87,NULL,3,0,'经济座',1150,'C','1'),(88,10,3,1,'经济座',1150,'D','1'),(89,NULL,3,0,'经济座',1150,'E','1'),(90,NULL,3,0,'经济座',1150,'F','1'),(91,NULL,3,0,'经济座',1150,'A','2'),(92,NULL,3,0,'经济座',1150,'B','2'),(93,NULL,3,0,'经济座',1150,'C','2'),(94,NULL,3,0,'经济座',1150,'D','2'),(95,NULL,3,0,'经济座',1150,'E','2'),(96,NULL,3,0,'经济座',1150,'F','2'),(97,NULL,3,0,'经济座',1150,'A','3'),(98,NULL,3,0,'经济座',1150,'B','3'),(99,NULL,3,0,'经济座',1150,'C','3'),(100,NULL,3,0,'经济座',1150,'D','3'),(101,NULL,3,0,'经济座',1150,'E','3'),(102,NULL,3,0,'经济座',1150,'F','3'),(103,NULL,3,0,'经济座',1150,'A','4'),(104,NULL,3,0,'经济座',1150,'B','4'),(105,NULL,3,0,'经济座',1150,'C','4'),(106,NULL,3,0,'经济座',1150,'D','4'),(107,NULL,3,0,'经济座',1150,'E','4'),(108,NULL,3,0,'经济座',1150,'F','4'),(109,NULL,3,0,'经济座',1150,'A','5'),(110,NULL,3,0,'经济座',1150,'B','5'),(111,NULL,3,0,'经济座',1150,'C','5'),(112,NULL,3,0,'经济座',1150,'D','5'),(113,NULL,3,0,'经济座',1150,'E','5'),(114,NULL,3,0,'经济座',1150,'F','5'),(115,NULL,3,0,'经济座',1150,'A','6'),(116,NULL,3,0,'经济座',1150,'B','6'),(117,NULL,3,0,'经济座',1150,'C','6'),(118,NULL,3,0,'经济座',1150,'D','6'),(119,NULL,3,0,'经济座',1150,'E','6'),(120,NULL,3,0,'经济座',1150,'F','6'),(121,NULL,4,0,'经济座',800,'A','1'),(122,NULL,4,0,'经济座',800,'B','1'),(123,14,4,1,'经济座',800,'C','1'),(124,NULL,4,0,'经济座',800,'D','1'),(125,NULL,4,0,'经济座',800,'E','1'),(126,NULL,4,0,'经济座',800,'F','1'),(127,NULL,4,0,'经济座',800,'A','2'),(128,9,4,1,'经济座',800,'B','2'),(129,NULL,4,0,'经济座',800,'C','2'),(130,NULL,4,0,'经济座',800,'D','2'),(131,NULL,4,0,'经济座',800,'E','2'),(132,NULL,4,0,'经济座',800,'F','2'),(133,NULL,4,0,'经济座',800,'A','3'),(134,NULL,4,0,'经济座',800,'B','3'),(135,NULL,4,0,'经济座',800,'C','3'),(136,NULL,4,0,'经济座',800,'D','3'),(137,NULL,4,0,'经济座',800,'E','3'),(138,NULL,4,0,'经济座',800,'F','3'),(139,NULL,4,0,'经济座',800,'A','4'),(140,NULL,4,0,'经济座',800,'B','4'),(141,NULL,4,0,'经济座',800,'C','4'),(142,NULL,4,0,'经济座',800,'D','4'),(143,NULL,4,0,'经济座',800,'E','4'),(144,NULL,4,0,'经济座',800,'F','4'),(145,NULL,4,0,'经济座',800,'A','5'),(146,NULL,4,0,'经济座',800,'B','5'),(147,NULL,4,0,'经济座',800,'C','5'),(148,NULL,4,0,'经济座',800,'D','5'),(149,NULL,4,0,'经济座',800,'E','5'),(150,NULL,4,0,'经济座',800,'F','5'),(151,NULL,4,0,'经济座',800,'A','6'),(152,NULL,4,0,'经济座',800,'B','6'),(153,NULL,4,0,'经济座',800,'C','6'),(154,NULL,4,0,'经济座',800,'D','6'),(155,NULL,4,0,'经济座',800,'E','6'),(156,NULL,4,0,'经济座',800,'F','6'),(157,NULL,4,0,'经济座',800,'A','7'),(158,NULL,4,0,'经济座',800,'B','7'),(159,NULL,4,0,'经济座',800,'C','7'),(160,NULL,4,0,'经济座',800,'D','7'),(161,NULL,4,0,'经济座',800,'E','7'),(162,NULL,4,0,'经济座',800,'F','7'),(163,NULL,4,0,'经济座',800,'A','8'),(164,NULL,4,0,'经济座',800,'B','8'),(165,NULL,4,0,'经济座',800,'C','8'),(166,NULL,4,0,'经济座',800,'D','8'),(167,NULL,4,0,'经济座',800,'E','8'),(168,NULL,4,0,'经济座',800,'F','8'),(169,NULL,5,0,'经济座',1150,'A','1'),(170,15,5,1,'经济座',1150,'B','1'),(171,NULL,5,0,'经济座',1150,'C','1'),(172,NULL,5,0,'经济座',1150,'D','1'),(173,NULL,5,0,'经济座',1150,'E','1'),(174,NULL,5,0,'经济座',1150,'F','1'),(175,NULL,5,0,'经济座',1150,'A','2'),(176,NULL,5,0,'经济座',1150,'B','2'),(177,NULL,5,0,'经济座',1150,'C','2'),(178,NULL,5,0,'经济座',1150,'D','2'),(179,NULL,5,0,'经济座',1150,'E','2'),(180,NULL,5,0,'经济座',1150,'F','2'),(181,NULL,5,0,'经济座',1150,'A','3'),(182,NULL,5,0,'经济座',1150,'B','3'),(183,NULL,5,0,'经济座',1150,'C','3'),(184,NULL,5,0,'经济座',1150,'D','3'),(185,NULL,5,0,'经济座',1150,'E','3'),(186,NULL,5,0,'经济座',1150,'F','3'),(187,NULL,5,0,'经济座',1150,'A','4'),(188,NULL,5,0,'经济座',1150,'B','4'),(189,NULL,5,0,'经济座',1150,'C','4'),(190,NULL,5,0,'经济座',1150,'D','4'),(191,NULL,5,0,'经济座',1150,'E','4'),(192,NULL,5,0,'经济座',1150,'F','4'),(193,NULL,5,0,'经济座',1150,'A','5'),(194,NULL,5,0,'经济座',1150,'B','5'),(195,NULL,5,0,'经济座',1150,'C','5'),(196,NULL,5,0,'经济座',1150,'D','5'),(197,NULL,5,0,'经济座',1150,'E','5'),(198,NULL,5,0,'经济座',1150,'F','5'),(199,NULL,5,0,'经济座',1150,'A','6'),(200,NULL,5,0,'经济座',1150,'B','6'),(201,NULL,5,0,'经济座',1150,'C','6'),(202,NULL,5,0,'经济座',1150,'D','6'),(203,NULL,5,0,'经济座',1150,'E','6'),(204,NULL,5,0,'经济座',1150,'F','6'),(205,NULL,6,0,'经济座',2300,'A','1'),(206,NULL,6,0,'经济座',2300,'B','1'),(207,NULL,6,0,'经济座',2300,'C','1'),(208,NULL,6,0,'经济座',2300,'D','1'),(209,NULL,6,0,'经济座',2300,'E','1'),(210,NULL,6,0,'经济座',2300,'F','1'),(211,NULL,6,0,'经济座',2300,'A','2'),(212,NULL,6,0,'经济座',2300,'B','2'),(213,NULL,6,0,'经济座',2300,'C','2'),(214,NULL,6,0,'经济座',2300,'D','2'),(215,NULL,6,0,'经济座',2300,'E','2'),(216,NULL,6,0,'经济座',2300,'F','2'),(217,NULL,6,0,'经济座',2300,'A','3'),(218,NULL,6,0,'经济座',2300,'B','3'),(219,NULL,6,0,'经济座',2300,'C','3'),(220,NULL,6,0,'经济座',2300,'D','3'),(221,NULL,6,0,'经济座',2300,'E','3'),(222,NULL,6,0,'经济座',2300,'F','3'),(223,NULL,6,0,'经济座',2300,'A','4'),(224,NULL,6,0,'经济座',2300,'B','4'),(225,NULL,6,0,'经济座',2300,'C','4'),(226,NULL,6,0,'经济座',2300,'D','4'),(227,NULL,6,0,'经济座',2300,'E','4'),(228,NULL,6,0,'经济座',2300,'F','4'),(229,NULL,6,0,'经济座',2300,'A','5'),(230,NULL,6,0,'经济座',2300,'B','5'),(231,NULL,6,0,'经济座',2300,'C','5'),(232,NULL,6,0,'经济座',2300,'D','5'),(233,NULL,6,0,'经济座',2300,'E','5'),(234,NULL,6,0,'经济座',2300,'F','5'),(235,NULL,6,0,'经济座',2300,'A','6'),(236,NULL,6,0,'经济座',2300,'B','6'),(237,NULL,6,0,'经济座',2300,'C','6'),(238,NULL,6,0,'经济座',2300,'D','6'),(239,NULL,6,0,'经济座',2300,'E','6'),(240,NULL,6,0,'经济座',2300,'F','6'),(241,NULL,7,0,'经济座',1800,'A','1'),(242,NULL,7,0,'经济座',1800,'B','1'),(243,NULL,7,0,'经济座',1800,'C','1'),(244,NULL,7,0,'经济座',1800,'D','1'),(245,NULL,7,0,'经济座',1800,'E','1'),(246,NULL,7,0,'经济座',1800,'F','1'),(247,NULL,7,0,'经济座',1800,'A','2'),(248,NULL,7,0,'经济座',1800,'B','2'),(249,NULL,7,0,'经济座',1800,'C','2'),(250,NULL,7,0,'经济座',1800,'D','2'),(251,NULL,7,0,'经济座',1800,'E','2'),(252,NULL,7,0,'经济座',1800,'F','2'),(253,NULL,7,0,'经济座',1800,'A','3'),(254,NULL,7,0,'经济座',1800,'B','3'),(255,NULL,7,0,'经济座',1800,'C','3'),(256,NULL,7,0,'经济座',1800,'D','3'),(257,NULL,7,0,'经济座',1800,'E','3'),(258,NULL,7,0,'经济座',1800,'F','3'),(259,NULL,7,0,'经济座',1800,'A','4'),(260,NULL,7,0,'经济座',1800,'B','4'),(261,NULL,7,0,'经济座',1800,'C','4'),(262,NULL,7,0,'经济座',1800,'D','4'),(263,NULL,7,0,'经济座',1800,'E','4'),(264,NULL,7,0,'经济座',1800,'F','4'),(265,NULL,7,0,'经济座',1800,'A','5'),(266,NULL,7,0,'经济座',1800,'B','5'),(267,NULL,7,0,'经济座',1800,'C','5'),(268,NULL,7,0,'经济座',1800,'D','5'),(269,NULL,7,0,'经济座',1800,'E','5'),(270,NULL,7,0,'经济座',1800,'F','5'),(271,NULL,7,0,'经济座',1800,'A','6'),(272,NULL,7,0,'经济座',1800,'B','6'),(273,NULL,7,0,'经济座',1800,'C','6'),(274,NULL,7,0,'经济座',1800,'D','6'),(275,NULL,7,0,'经济座',1800,'E','6'),(276,NULL,7,0,'经济座',1800,'F','6'),(277,NULL,8,0,'经济座',1720,'A','1'),(278,NULL,8,0,'经济座',1720,'B','1'),(279,NULL,8,0,'经济座',1720,'C','1'),(280,NULL,8,0,'经济座',1720,'D','1'),(281,NULL,8,0,'经济座',1720,'E','1'),(282,NULL,8,0,'经济座',1720,'F','1'),(283,56,8,1,'经济座',1720,'A','2'),(284,NULL,8,0,'经济座',1720,'B','2'),(285,NULL,8,0,'经济座',1720,'C','2'),(286,NULL,8,0,'经济座',1720,'D','2'),(287,NULL,8,0,'经济座',1720,'E','2'),(288,59,8,1,'经济座',1720,'F','2'),(289,NULL,8,0,'经济座',1720,'A','3'),(290,NULL,8,0,'经济座',1720,'B','3'),(291,NULL,8,0,'经济座',1720,'C','3'),(292,NULL,8,0,'经济座',1720,'D','3'),(293,NULL,8,0,'经济座',1720,'E','3'),(294,NULL,8,0,'经济座',1720,'F','3'),(295,NULL,8,0,'经济座',1720,'A','4'),(296,NULL,8,0,'经济座',1720,'B','4'),(297,NULL,8,0,'经济座',1720,'C','4'),(298,NULL,8,0,'经济座',1720,'D','4'),(299,NULL,8,0,'经济座',1720,'E','4'),(300,NULL,8,0,'经济座',1720,'F','4'),(301,NULL,8,0,'经济座',1720,'A','5'),(302,NULL,8,0,'经济座',1720,'B','5'),(303,NULL,8,0,'经济座',1720,'C','5'),(304,NULL,8,0,'经济座',1720,'D','5'),(305,NULL,8,0,'经济座',1720,'E','5'),(306,NULL,8,0,'经济座',1720,'F','5'),(307,NULL,8,0,'经济座',1720,'A','6'),(308,NULL,8,0,'经济座',1720,'B','6'),(309,NULL,8,0,'经济座',1720,'C','6'),(310,NULL,8,0,'经济座',1720,'D','6'),(311,NULL,8,0,'经济座',1720,'E','6'),(312,NULL,8,0,'经济座',1720,'F','6'),(313,NULL,8,0,'经济座',1720,'A','7'),(314,NULL,8,0,'经济座',1720,'B','7'),(315,NULL,8,0,'经济座',1720,'C','7'),(316,NULL,8,0,'经济座',1720,'D','7'),(317,NULL,8,0,'经济座',1720,'E','7'),(318,NULL,8,0,'经济座',1720,'F','7'),(319,NULL,8,0,'经济座',1720,'A','8'),(320,NULL,8,0,'经济座',1720,'B','8'),(321,NULL,8,0,'经济座',1720,'C','8'),(322,NULL,8,0,'经济座',1720,'D','8'),(323,NULL,8,0,'经济座',1720,'E','8'),(324,NULL,8,0,'经济座',1720,'F','8'),(325,NULL,9,0,'经济座',2110,'A','1'),(326,NULL,9,0,'经济座',2110,'B','1'),(327,NULL,9,0,'经济座',2110,'C','1'),(328,NULL,9,0,'经济座',2110,'D','1'),(329,NULL,9,0,'经济座',2110,'E','1'),(330,NULL,9,0,'经济座',2110,'F','1'),(331,NULL,9,0,'经济座',2110,'A','2'),(332,NULL,9,0,'经济座',2110,'B','2'),(333,NULL,9,0,'经济座',2110,'C','2'),(334,NULL,9,0,'经济座',2110,'D','2'),(335,NULL,9,0,'经济座',2110,'E','2'),(336,NULL,9,0,'经济座',2110,'F','2'),(337,NULL,9,0,'经济座',2110,'A','3'),(338,NULL,9,0,'经济座',2110,'B','3'),(339,NULL,9,0,'经济座',2110,'C','3'),(340,NULL,9,0,'经济座',2110,'D','3'),(341,NULL,9,0,'经济座',2110,'E','3'),(342,NULL,9,0,'经济座',2110,'F','3'),(343,NULL,9,0,'经济座',2110,'A','4'),(344,NULL,9,0,'经济座',2110,'B','4'),(345,NULL,9,0,'经济座',2110,'C','4'),(346,NULL,9,0,'经济座',2110,'D','4'),(347,NULL,9,0,'经济座',2110,'E','4'),(348,NULL,9,0,'经济座',2110,'F','4'),(349,NULL,9,0,'经济座',2110,'A','5'),(350,NULL,9,0,'经济座',2110,'B','5'),(351,NULL,9,0,'经济座',2110,'C','5'),(352,NULL,9,0,'经济座',2110,'D','5'),(353,NULL,9,0,'经济座',2110,'E','5'),(354,NULL,9,0,'经济座',2110,'F','5'),(355,NULL,9,0,'经济座',2110,'A','6'),(356,NULL,9,0,'经济座',2110,'B','6'),(357,NULL,9,0,'经济座',2110,'C','6'),(358,NULL,9,0,'经济座',2110,'D','6'),(359,NULL,9,0,'经济座',2110,'E','6'),(360,NULL,9,0,'经济座',2110,'F','6'),(361,NULL,10,0,'经济座',1030,'A','1'),(362,NULL,10,0,'经济座',1030,'B','1'),(363,NULL,10,0,'经济座',1030,'C','1'),(364,NULL,10,0,'经济座',1030,'D','1'),(365,NULL,10,0,'经济座',1030,'E','1'),(366,NULL,10,0,'经济座',1030,'F','1'),(367,NULL,10,0,'经济座',1030,'A','2'),(368,NULL,10,0,'经济座',1030,'B','2'),(369,NULL,10,0,'经济座',1030,'C','2'),(370,NULL,10,0,'经济座',1030,'D','2'),(371,NULL,10,0,'经济座',1030,'E','2'),(372,NULL,10,0,'经济座',1030,'F','2'),(373,NULL,10,0,'经济座',1030,'A','3'),(374,NULL,10,0,'经济座',1030,'B','3'),(375,NULL,10,0,'经济座',1030,'C','3'),(376,NULL,10,0,'经济座',1030,'D','3'),(377,NULL,10,0,'经济座',1030,'E','3'),(378,NULL,10,0,'经济座',1030,'F','3'),(379,NULL,10,0,'经济座',1030,'A','4'),(380,NULL,10,0,'经济座',1030,'B','4'),(381,NULL,10,0,'经济座',1030,'C','4'),(382,NULL,10,0,'经济座',1030,'D','4'),(383,NULL,10,0,'经济座',1030,'E','4'),(384,NULL,10,0,'经济座',1030,'F','4'),(385,NULL,10,0,'经济座',1030,'A','5'),(386,NULL,10,0,'经济座',1030,'B','5'),(387,NULL,10,0,'经济座',1030,'C','5'),(388,NULL,10,0,'经济座',1030,'D','5'),(389,NULL,10,0,'经济座',1030,'E','5'),(390,NULL,10,0,'经济座',1030,'F','5'),(391,NULL,10,0,'经济座',1030,'A','6'),(392,NULL,10,0,'经济座',1030,'B','6'),(393,NULL,10,0,'经济座',1030,'C','6'),(394,NULL,10,0,'经济座',1030,'D','6'),(395,NULL,10,0,'经济座',1030,'E','6'),(396,NULL,10,0,'经济座',1030,'F','6'),(397,NULL,11,0,'经济座',1710,'A','1'),(398,NULL,11,0,'经济座',1710,'B','1'),(399,NULL,11,0,'经济座',1710,'C','1'),(400,NULL,11,0,'经济座',1710,'D','1'),(401,NULL,11,0,'经济座',1710,'E','1'),(402,NULL,11,0,'经济座',1710,'F','1'),(403,NULL,11,0,'经济座',1710,'A','2'),(404,NULL,11,0,'经济座',1710,'B','2'),(405,NULL,11,0,'经济座',1710,'C','2'),(406,NULL,11,0,'经济座',1710,'D','2'),(407,NULL,11,0,'经济座',1710,'E','2'),(408,NULL,11,0,'经济座',1710,'F','2'),(409,NULL,11,0,'经济座',1710,'A','3'),(410,NULL,11,0,'经济座',1710,'B','3'),(411,NULL,11,0,'经济座',1710,'C','3'),(412,NULL,11,0,'经济座',1710,'D','3'),(413,NULL,11,0,'经济座',1710,'E','3'),(414,NULL,11,0,'经济座',1710,'F','3'),(415,NULL,11,0,'经济座',1710,'A','4'),(416,NULL,11,0,'经济座',1710,'B','4'),(417,NULL,11,0,'经济座',1710,'C','4'),(418,NULL,11,0,'经济座',1710,'D','4'),(419,NULL,11,0,'经济座',1710,'E','4'),(420,NULL,11,0,'经济座',1710,'F','4'),(421,NULL,11,0,'经济座',1710,'A','5'),(422,NULL,11,0,'经济座',1710,'B','5'),(423,NULL,11,0,'经济座',1710,'C','5'),(424,NULL,11,0,'经济座',1710,'D','5'),(425,NULL,11,0,'经济座',1710,'E','5'),(426,NULL,11,0,'经济座',1710,'F','5'),(427,NULL,11,0,'经济座',1710,'A','6'),(428,NULL,11,0,'经济座',1710,'B','6'),(429,NULL,11,0,'经济座',1710,'C','6'),(430,NULL,11,0,'经济座',1710,'D','6'),(431,NULL,11,0,'经济座',1710,'E','6'),(432,NULL,11,0,'经济座',1710,'F','6'),(433,NULL,12,0,'经济座',1110,'A','1'),(434,NULL,12,0,'经济座',1110,'B','1'),(435,NULL,12,0,'经济座',1110,'C','1'),(436,NULL,12,0,'经济座',1110,'D','1'),(437,NULL,12,0,'经济座',1110,'E','1'),(438,NULL,12,0,'经济座',1110,'F','1'),(439,NULL,12,0,'经济座',1110,'A','2'),(440,NULL,12,0,'经济座',1110,'B','2'),(441,NULL,12,0,'经济座',1110,'C','2'),(442,NULL,12,0,'经济座',1110,'D','2'),(443,NULL,12,0,'经济座',1110,'E','2'),(444,NULL,12,0,'经济座',1110,'F','2'),(445,NULL,12,0,'经济座',1110,'A','3'),(446,NULL,12,0,'经济座',1110,'B','3'),(447,NULL,12,0,'经济座',1110,'C','3'),(448,NULL,12,0,'经济座',1110,'D','3'),(449,NULL,12,0,'经济座',1110,'E','3'),(450,NULL,12,0,'经济座',1110,'F','3'),(451,NULL,12,0,'经济座',1110,'A','4'),(452,NULL,12,0,'经济座',1110,'B','4'),(453,NULL,12,0,'经济座',1110,'C','4'),(454,NULL,12,0,'经济座',1110,'D','4'),(455,NULL,12,0,'经济座',1110,'E','4'),(456,NULL,12,0,'经济座',1110,'F','4'),(457,NULL,12,0,'经济座',1110,'A','5'),(458,NULL,12,0,'经济座',1110,'B','5'),(459,NULL,12,0,'经济座',1110,'C','5'),(460,NULL,12,0,'经济座',1110,'D','5'),(461,NULL,12,0,'经济座',1110,'E','5'),(462,NULL,12,0,'经济座',1110,'F','5'),(463,NULL,12,0,'经济座',1110,'A','6'),(464,NULL,12,0,'经济座',1110,'B','6'),(465,NULL,12,0,'经济座',1110,'C','6'),(466,NULL,12,0,'经济座',1110,'D','6'),(467,NULL,12,0,'经济座',1110,'E','6'),(468,NULL,12,0,'经济座',1110,'F','6'),(469,7,13,1,'经济座',1800,'A','1'),(470,8,13,1,'经济座',1800,'B','1'),(471,NULL,13,0,'经济座',1800,'C','1'),(472,NULL,13,0,'经济座',1800,'D','1'),(473,NULL,13,0,'经济座',1800,'E','1'),(474,NULL,13,0,'经济座',1800,'F','1'),(475,NULL,13,0,'经济座',1800,'A','2'),(476,NULL,13,0,'经济座',1800,'B','2'),(477,NULL,13,0,'经济座',1800,'C','2'),(478,NULL,13,0,'经济座',1800,'D','2'),(479,NULL,13,0,'经济座',1800,'E','2'),(480,NULL,13,0,'经济座',1800,'F','2'),(481,NULL,13,0,'经济座',1800,'A','3'),(482,NULL,13,0,'经济座',1800,'B','3'),(483,NULL,13,0,'经济座',1800,'C','3'),(484,NULL,13,0,'经济座',1800,'D','3'),(485,NULL,13,0,'经济座',1800,'E','3'),(486,NULL,13,0,'经济座',1800,'F','3'),(487,NULL,13,0,'经济座',1800,'A','4'),(488,NULL,13,0,'经济座',1800,'B','4'),(489,NULL,13,0,'经济座',1800,'C','4'),(490,NULL,13,0,'经济座',1800,'D','4'),(491,NULL,13,0,'经济座',1800,'E','4'),(492,NULL,13,0,'经济座',1800,'F','4'),(493,NULL,13,0,'经济座',1800,'A','5'),(494,NULL,13,0,'经济座',1800,'B','5'),(495,NULL,13,0,'经济座',1800,'C','5'),(496,NULL,13,0,'经济座',1800,'D','5'),(497,NULL,13,0,'经济座',1800,'E','5'),(498,NULL,13,0,'经济座',1800,'F','5'),(499,NULL,13,0,'经济座',1800,'A','6'),(500,NULL,13,0,'经济座',1800,'B','6'),(501,NULL,13,0,'经济座',1800,'C','6'),(502,NULL,13,0,'经济座',1800,'D','6'),(503,NULL,13,0,'经济座',1800,'E','6'),(504,NULL,13,0,'经济座',1800,'F','6'),(505,11,14,1,'标准服务',2200,'A','1'),(506,NULL,14,0,'标准服务',2200,'B','1'),(507,NULL,14,0,'标准服务',2200,'C','1'),(508,16,14,1,'标准服务',2200,'D','1'),(509,NULL,14,0,'标准服务',2200,'E','1'),(510,NULL,14,0,'标准服务',2200,'F','1'),(511,NULL,14,0,'标准服务',2200,'A','2'),(512,NULL,14,0,'标准服务',2200,'B','2'),(513,NULL,14,0,'标准服务',2200,'C','2'),(514,NULL,14,0,'标准服务',2200,'D','2'),(515,NULL,14,0,'标准服务',2200,'E','2'),(516,NULL,14,0,'标准服务',2200,'F','2'),(517,NULL,14,0,'标准服务',2200,'A','3'),(518,NULL,14,0,'标准服务',2200,'B','3'),(519,NULL,14,0,'标准服务',2200,'C','3'),(520,NULL,14,0,'标准服务',2200,'D','3'),(521,NULL,14,0,'标准服务',2200,'E','3'),(522,NULL,14,0,'标准服务',2200,'F','3'),(523,NULL,14,0,'标准服务',2200,'A','4'),(524,NULL,14,0,'标准服务',2200,'B','4'),(525,NULL,14,0,'标准服务',2200,'C','4'),(526,NULL,14,0,'标准服务',2200,'D','4'),(527,NULL,14,0,'标准服务',2200,'E','4'),(528,NULL,14,0,'标准服务',2200,'F','4'),(529,NULL,14,0,'标准服务',2200,'A','5'),(530,NULL,14,0,'标准服务',2200,'B','5'),(531,NULL,14,0,'标准服务',2200,'C','5'),(532,NULL,14,0,'标准服务',2200,'D','5'),(533,NULL,14,0,'标准服务',2200,'E','5'),(534,NULL,14,0,'标准服务',2200,'F','5'),(535,NULL,14,0,'标准服务',2200,'A','6'),(536,NULL,14,0,'标准服务',2200,'B','6'),(537,NULL,14,0,'标准服务',2200,'C','6'),(538,NULL,14,0,'标准服务',2200,'D','6'),(539,NULL,14,0,'标准服务',2200,'E','6'),(540,NULL,14,0,'标准服务',2200,'F','6'),(541,NULL,14,0,'标准服务',2200,'A','7'),(542,NULL,14,0,'标准服务',2200,'B','7'),(543,NULL,14,0,'标准服务',2200,'C','7'),(544,NULL,14,0,'标准服务',2200,'D','7'),(545,NULL,14,0,'标准服务',2200,'E','7'),(546,NULL,14,0,'标准服务',2200,'F','7'),(547,NULL,14,0,'标准服务',2200,'A','8'),(548,NULL,14,0,'标准服务',2200,'B','8'),(549,NULL,14,0,'标准服务',2200,'C','8'),(550,NULL,14,0,'标准服务',2200,'D','8'),(551,NULL,14,0,'标准服务',2200,'E','8'),(552,NULL,14,0,'标准服务',2200,'F','8'),(553,69,15,1,'标准服务',1600,'A','1'),(554,NULL,15,0,'标准服务',1600,'B','1'),(555,19,15,1,'标准服务',1600,'C','1'),(556,NULL,15,0,'标准服务',1600,'D','1'),(557,NULL,15,0,'标准服务',1600,'E','1'),(558,NULL,15,0,'标准服务',1600,'F','1'),(559,NULL,15,0,'标准服务',1600,'A','2'),(560,NULL,15,0,'标准服务',1600,'B','2'),(561,NULL,15,0,'标准服务',1600,'C','2'),(562,NULL,15,0,'标准服务',1600,'D','2'),(563,NULL,15,0,'标准服务',1600,'E','2'),(564,NULL,15,0,'标准服务',1600,'F','2'),(565,NULL,15,0,'标准服务',1600,'A','3'),(566,NULL,15,0,'标准服务',1600,'B','3'),(567,NULL,15,0,'标准服务',1600,'C','3'),(568,NULL,15,0,'标准服务',1600,'D','3'),(569,NULL,15,0,'标准服务',1600,'E','3'),(570,NULL,15,0,'标准服务',1600,'F','3'),(571,NULL,15,0,'标准服务',1600,'A','4'),(572,NULL,15,0,'标准服务',1600,'B','4'),(573,NULL,15,0,'标准服务',1600,'C','4'),(574,NULL,15,0,'标准服务',1600,'D','4'),(575,NULL,15,0,'标准服务',1600,'E','4'),(576,NULL,15,0,'标准服务',1600,'F','4'),(577,NULL,15,0,'标准服务',1600,'A','5'),(578,NULL,15,0,'标准服务',1600,'B','5'),(579,37,15,1,'标准服务',1600,'C','5'),(580,NULL,15,0,'标准服务',1600,'D','5'),(581,NULL,15,0,'标准服务',1600,'E','5'),(582,NULL,15,0,'标准服务',1600,'F','5'),(583,NULL,15,0,'标准服务',1600,'A','6'),(584,NULL,15,0,'标准服务',1600,'B','6'),(585,NULL,15,0,'标准服务',1600,'C','6'),(586,NULL,15,0,'标准服务',1600,'D','6'),(587,NULL,15,0,'标准服务',1600,'E','6'),(588,NULL,15,0,'标准服务',1600,'F','6'),(589,36,16,1,'标准服务',2100,'A','1'),(590,NULL,16,0,'标准服务',2100,'B','1'),(591,NULL,16,0,'标准服务',2100,'C','1'),(592,29,16,1,'标准服务',2100,'D','1'),(593,NULL,16,0,'标准服务',2100,'E','1'),(594,NULL,16,0,'标准服务',2100,'F','1'),(595,NULL,16,0,'标准服务',2100,'A','2'),(596,NULL,16,0,'标准服务',2100,'B','2'),(597,34,16,1,'标准服务',2100,'C','2'),(598,NULL,16,0,'标准服务',2100,'D','2'),(599,NULL,16,0,'标准服务',2100,'E','2'),(600,NULL,16,0,'标准服务',2100,'F','2'),(601,NULL,16,0,'标准服务',2100,'A','3'),(602,NULL,16,0,'标准服务',2100,'B','3'),(603,NULL,16,0,'标准服务',2100,'C','3'),(604,NULL,16,0,'标准服务',2100,'D','3'),(605,NULL,16,0,'标准服务',2100,'E','3'),(606,NULL,16,0,'标准服务',2100,'F','3'),(607,NULL,16,0,'标准服务',2100,'A','4'),(608,NULL,16,0,'标准服务',2100,'B','4'),(609,NULL,16,0,'标准服务',2100,'C','4'),(610,NULL,16,0,'标准服务',2100,'D','4'),(611,NULL,16,0,'标准服务',2100,'E','4'),(612,NULL,16,0,'标准服务',2100,'F','4'),(613,NULL,16,0,'标准服务',2100,'A','5'),(614,NULL,16,0,'标准服务',2100,'B','5'),(615,NULL,16,0,'标准服务',2100,'C','5'),(616,NULL,16,0,'标准服务',2100,'D','5'),(617,NULL,16,0,'标准服务',2100,'E','5'),(618,NULL,16,0,'标准服务',2100,'F','5'),(619,NULL,16,0,'标准服务',2100,'A','6'),(620,NULL,16,0,'标准服务',2100,'B','6'),(621,NULL,16,0,'标准服务',2100,'C','6'),(622,NULL,16,0,'标准服务',2100,'D','6'),(623,NULL,16,0,'标准服务',2100,'E','6'),(624,NULL,16,0,'标准服务',2100,'F','6'),(625,53,17,1,'标准服务',1900,'A','1'),(626,NULL,17,0,'标准服务',1900,'B','1'),(627,54,17,1,'标准服务',1900,'C','1'),(628,NULL,17,0,'标准服务',1900,'D','1'),(629,NULL,17,0,'标准服务',1900,'E','1'),(630,NULL,17,0,'标准服务',1900,'F','1'),(631,NULL,17,0,'标准服务',1900,'A','2'),(632,NULL,17,0,'标准服务',1900,'B','2'),(633,NULL,17,0,'标准服务',1900,'C','2'),(634,NULL,17,0,'标准服务',1900,'D','2'),(635,NULL,17,0,'标准服务',1900,'E','2'),(636,NULL,17,0,'标准服务',1900,'F','2'),(637,NULL,17,0,'标准服务',1900,'A','3'),(638,NULL,17,0,'标准服务',1900,'B','3'),(639,NULL,17,0,'标准服务',1900,'C','3'),(640,NULL,17,0,'标准服务',1900,'D','3'),(641,NULL,17,0,'标准服务',1900,'E','3'),(642,NULL,17,0,'标准服务',1900,'F','3'),(643,NULL,17,0,'标准服务',1900,'A','4'),(644,NULL,17,0,'标准服务',1900,'B','4'),(645,NULL,17,0,'标准服务',1900,'C','4'),(646,NULL,17,0,'标准服务',1900,'D','4'),(647,NULL,17,0,'标准服务',1900,'E','4'),(648,NULL,17,0,'标准服务',1900,'F','4'),(649,NULL,17,0,'标准服务',1900,'A','5'),(650,NULL,17,0,'标准服务',1900,'B','5'),(651,NULL,17,0,'标准服务',1900,'C','5'),(652,NULL,17,0,'标准服务',1900,'D','5'),(653,NULL,17,0,'标准服务',1900,'E','5'),(654,NULL,17,0,'标准服务',1900,'F','5'),(655,NULL,17,0,'标准服务',1900,'A','6'),(656,NULL,17,0,'标准服务',1900,'B','6'),(657,NULL,17,0,'标准服务',1900,'C','6'),(658,NULL,17,0,'标准服务',1900,'D','6'),(659,NULL,17,0,'标准服务',1900,'E','6'),(660,NULL,17,0,'标准服务',1900,'F','6'),(661,NULL,18,0,'标准服务',1850,'A','1'),(662,30,18,1,'标准服务',1850,'B','1'),(663,NULL,18,0,'标准服务',1850,'C','1'),(664,12,18,1,'标准服务',1850,'D','1'),(665,NULL,18,0,'标准服务',1850,'E','1'),(666,NULL,18,0,'标准服务',1850,'F','1'),(667,NULL,18,0,'标准服务',1850,'A','2'),(668,NULL,18,0,'标准服务',1850,'B','2'),(669,NULL,18,0,'标准服务',1850,'C','2'),(670,NULL,18,0,'标准服务',1850,'D','2'),(671,NULL,18,0,'标准服务',1850,'E','2'),(672,NULL,18,0,'标准服务',1850,'F','2'),(673,NULL,18,0,'标准服务',1850,'A','3'),(674,NULL,18,0,'标准服务',1850,'B','3'),(675,NULL,18,0,'标准服务',1850,'C','3'),(676,NULL,18,0,'标准服务',1850,'D','3'),(677,NULL,18,0,'标准服务',1850,'E','3'),(678,NULL,18,0,'标准服务',1850,'F','3'),(679,NULL,18,0,'标准服务',1850,'A','4'),(680,NULL,18,0,'标准服务',1850,'B','4'),(681,NULL,18,0,'标准服务',1850,'C','4'),(682,NULL,18,0,'标准服务',1850,'D','4'),(683,NULL,18,0,'标准服务',1850,'E','4'),(684,NULL,18,0,'标准服务',1850,'F','4'),(685,NULL,18,0,'标准服务',1850,'A','5'),(686,NULL,18,0,'标准服务',1850,'B','5'),(687,NULL,18,0,'标准服务',1850,'C','5'),(688,NULL,18,0,'标准服务',1850,'D','5'),(689,NULL,18,0,'标准服务',1850,'E','5'),(690,NULL,18,0,'标准服务',1850,'F','5'),(691,NULL,18,0,'标准服务',1850,'A','6'),(692,NULL,18,0,'标准服务',1850,'B','6'),(693,NULL,18,0,'标准服务',1850,'C','6'),(694,NULL,18,0,'标准服务',1850,'D','6'),(695,NULL,18,0,'标准服务',1850,'E','6'),(696,NULL,18,0,'标准服务',1850,'F','6'),(697,13,19,1,'标准服务',1740,'A','1'),(698,NULL,19,0,'标准服务',1740,'B','1'),(699,NULL,19,0,'标准服务',1740,'C','1'),(700,NULL,19,0,'标准服务',1740,'D','1'),(701,NULL,19,0,'标准服务',1740,'E','1'),(702,NULL,19,0,'标准服务',1740,'F','1'),(703,NULL,19,0,'标准服务',1740,'A','2'),(704,NULL,19,0,'标准服务',1740,'B','2'),(705,NULL,19,0,'标准服务',1740,'C','2'),(706,NULL,19,0,'标准服务',1740,'D','2'),(707,NULL,19,0,'标准服务',1740,'E','2'),(708,NULL,19,0,'标准服务',1740,'F','2'),(709,NULL,19,0,'标准服务',1740,'A','3'),(710,NULL,19,0,'标准服务',1740,'B','3'),(711,NULL,19,0,'标准服务',1740,'C','3'),(712,31,19,1,'标准服务',1740,'D','3'),(713,NULL,19,0,'标准服务',1740,'E','3'),(714,NULL,19,0,'标准服务',1740,'F','3'),(715,NULL,19,0,'标准服务',1740,'A','4'),(716,NULL,19,0,'标准服务',1740,'B','4'),(717,NULL,19,0,'标准服务',1740,'C','4'),(718,NULL,19,0,'标准服务',1740,'D','4'),(719,NULL,19,0,'标准服务',1740,'E','4'),(720,NULL,19,0,'标准服务',1740,'F','4'),(721,NULL,19,0,'标准服务',1740,'A','5'),(722,NULL,19,0,'标准服务',1740,'B','5'),(723,NULL,19,0,'标准服务',1740,'C','5'),(724,NULL,19,0,'标准服务',1740,'D','5'),(725,NULL,19,0,'标准服务',1740,'E','5'),(726,NULL,19,0,'标准服务',1740,'F','5'),(727,NULL,19,0,'标准服务',1740,'A','6'),(728,NULL,19,0,'标准服务',1740,'B','6'),(729,NULL,19,0,'标准服务',1740,'C','6'),(730,NULL,19,0,'标准服务',1740,'D','6'),(731,NULL,19,0,'标准服务',1740,'E','6'),(732,NULL,19,0,'标准服务',1740,'F','6'),(733,NULL,20,0,'标准服务',1400,'A','1'),(734,NULL,20,0,'标准服务',1400,'B','1'),(735,NULL,20,0,'标准服务',1400,'C','1'),(736,NULL,20,0,'标准服务',1400,'D','1'),(737,NULL,20,0,'标准服务',1400,'E','1'),(738,NULL,20,0,'标准服务',1400,'F','1'),(739,28,20,1,'标准服务',1400,'A','2'),(740,NULL,20,0,'标准服务',1400,'B','2'),(741,NULL,20,0,'标准服务',1400,'C','2'),(742,NULL,20,0,'标准服务',1400,'D','2'),(743,NULL,20,0,'标准服务',1400,'E','2'),(744,NULL,20,0,'标准服务',1400,'F','2'),(745,NULL,20,0,'标准服务',1400,'A','3'),(746,NULL,20,0,'标准服务',1400,'B','3'),(747,NULL,20,0,'标准服务',1400,'C','3'),(748,NULL,20,0,'标准服务',1400,'D','3'),(749,NULL,20,0,'标准服务',1400,'E','3'),(750,NULL,20,0,'标准服务',1400,'F','3'),(751,NULL,20,0,'标准服务',1400,'A','4'),(752,NULL,20,0,'标准服务',1400,'B','4'),(753,NULL,20,0,'标准服务',1400,'C','4'),(754,NULL,20,0,'标准服务',1400,'D','4'),(755,NULL,20,0,'标准服务',1400,'E','4'),(756,NULL,20,0,'标准服务',1400,'F','4'),(757,NULL,20,0,'标准服务',1400,'A','5'),(758,NULL,20,0,'标准服务',1400,'B','5'),(759,NULL,20,0,'标准服务',1400,'C','5'),(760,NULL,20,0,'标准服务',1400,'D','5'),(761,NULL,20,0,'标准服务',1400,'E','5'),(762,NULL,20,0,'标准服务',1400,'F','5'),(763,NULL,20,0,'标准服务',1400,'A','6'),(764,NULL,20,0,'标准服务',1400,'B','6'),(765,NULL,20,0,'标准服务',1400,'C','6'),(766,NULL,20,0,'标准服务',1400,'D','6'),(767,NULL,20,0,'标准服务',1400,'E','6'),(768,NULL,20,0,'标准服务',1400,'F','6'),(769,NULL,20,0,'标准服务',1400,'A','7'),(770,NULL,20,0,'标准服务',1400,'B','7'),(771,NULL,20,0,'标准服务',1400,'C','7'),(772,NULL,20,0,'标准服务',1400,'D','7'),(773,NULL,20,0,'标准服务',1400,'E','7'),(774,NULL,20,0,'标准服务',1400,'F','7'),(775,NULL,20,0,'标准服务',1400,'A','8'),(776,NULL,20,0,'标准服务',1400,'B','8'),(777,NULL,20,0,'标准服务',1400,'C','8'),(778,NULL,20,0,'标准服务',1400,'D','8'),(779,NULL,20,0,'标准服务',1400,'E','8'),(780,NULL,20,0,'标准服务',1400,'F','8'),(781,NULL,21,0,'标准服务',1100,'A','1'),(782,22,21,1,'标准服务',1100,'B','1'),(783,23,21,1,'标准服务',1100,'C','1'),(784,24,21,1,'标准服务',1100,'D','1'),(785,25,21,1,'标准服务',1100,'E','1'),(786,33,21,1,'标准服务',1100,'F','1'),(787,35,22,1,'标准服务',950,'A','1'),(788,NULL,22,0,'标准服务',950,'B','1'),(789,NULL,22,0,'标准服务',950,'C','1'),(790,NULL,22,0,'标准服务',950,'D','1'),(791,NULL,22,0,'标准服务',950,'E','1'),(792,NULL,22,0,'标准服务',950,'F','1'),(793,NULL,22,0,'标准服务',950,'A','2'),(794,NULL,22,0,'标准服务',950,'B','2'),(795,NULL,22,0,'标准服务',950,'C','2'),(796,NULL,22,0,'标准服务',950,'D','2'),(797,NULL,22,0,'标准服务',950,'E','2'),(798,NULL,22,0,'标准服务',950,'F','2'),(799,NULL,22,0,'标准服务',950,'A','3'),(800,NULL,22,0,'标准服务',950,'B','3'),(801,NULL,22,0,'标准服务',950,'C','3'),(802,NULL,22,0,'标准服务',950,'D','3'),(803,NULL,22,0,'标准服务',950,'E','3'),(804,NULL,22,0,'标准服务',950,'F','3'),(805,NULL,22,0,'标准服务',950,'A','4'),(806,NULL,22,0,'标准服务',950,'B','4'),(807,NULL,22,0,'标准服务',950,'C','4'),(808,NULL,22,0,'标准服务',950,'D','4'),(809,NULL,22,0,'标准服务',950,'E','4'),(810,NULL,22,0,'标准服务',950,'F','4'),(811,NULL,22,0,'标准服务',950,'A','5'),(812,NULL,22,0,'标准服务',950,'B','5'),(813,NULL,22,0,'标准服务',950,'C','5'),(814,NULL,22,0,'标准服务',950,'D','5'),(815,NULL,22,0,'标准服务',950,'E','5'),(816,NULL,22,0,'标准服务',950,'F','5'),(817,NULL,22,0,'标准服务',950,'A','6'),(818,NULL,22,0,'标准服务',950,'B','6'),(819,NULL,22,0,'标准服务',950,'C','6'),(820,NULL,22,0,'标准服务',950,'D','6'),(821,NULL,22,0,'标准服务',950,'E','6'),(822,NULL,22,0,'标准服务',950,'F','6'),(823,NULL,23,0,'标准座',1480,'A','1'),(824,38,23,1,'标准座',1480,'B','1'),(825,NULL,23,0,'标准座',1480,'C','1'),(826,52,23,1,'标准座',1480,'D','1'),(827,NULL,23,0,'标准座',1480,'E','1'),(828,46,23,1,'标准座',1480,'F','1'),(829,NULL,23,0,'标准座',1480,'A','2'),(830,NULL,23,0,'标准座',1480,'B','2'),(831,48,23,1,'标准座',1480,'C','2'),(832,NULL,23,0,'标准座',1480,'D','2'),(833,NULL,23,0,'标准座',1480,'E','2'),(834,NULL,23,0,'标准座',1480,'F','2'),(835,NULL,23,0,'标准座',1480,'A','3'),(836,50,23,1,'标准座',1480,'B','3'),(837,NULL,23,0,'标准座',1480,'C','3'),(838,NULL,23,0,'标准座',1480,'D','3'),(839,NULL,23,0,'标准座',1480,'E','3'),(840,NULL,23,0,'标准座',1480,'F','3'),(841,62,23,1,'标准座',1480,'A','4'),(842,64,23,1,'标准座',1480,'B','4'),(843,NULL,23,0,'标准座',1480,'C','4'),(844,NULL,23,0,'标准座',1480,'D','4'),(845,NULL,23,0,'标准座',1480,'E','4'),(846,NULL,23,0,'标准座',1480,'F','4'),(847,NULL,24,0,'标准座',1200,'A','1'),(848,NULL,24,0,'标准座',1200,'B','1'),(849,NULL,24,0,'标准座',1200,'C','1'),(850,NULL,24,0,'标准座',1200,'D','1'),(851,NULL,24,0,'标准座',1200,'E','1'),(852,NULL,24,0,'标准座',1200,'F','1'),(853,NULL,24,0,'标准座',1200,'A','2'),(854,NULL,24,0,'标准座',1200,'B','2'),(855,NULL,24,0,'标准座',1200,'C','2'),(856,NULL,24,0,'标准座',1200,'D','2'),(857,NULL,24,0,'标准座',1200,'E','2'),(858,NULL,24,0,'标准座',1200,'F','2'),(859,NULL,24,0,'标准座',1200,'A','3'),(860,NULL,24,0,'标准座',1200,'B','3'),(861,NULL,24,0,'标准座',1200,'C','3'),(862,NULL,24,0,'标准座',1200,'D','3'),(863,NULL,24,0,'标准座',1200,'E','3'),(864,NULL,24,0,'标准座',1200,'F','3'),(865,NULL,24,0,'标准座',1200,'A','4'),(866,NULL,24,0,'标准座',1200,'B','4'),(867,NULL,24,0,'标准座',1200,'C','4'),(868,NULL,24,0,'标准座',1200,'D','4'),(869,NULL,24,0,'标准座',1200,'E','4'),(870,NULL,24,0,'标准座',1200,'F','4'),(871,27,25,1,'经济座',1600,'A','1'),(872,NULL,25,0,'经济座',1600,'B','1'),(873,51,25,1,'经济座',1600,'C','1'),(874,NULL,25,0,'经济座',1600,'D','1'),(875,NULL,25,0,'经济座',1600,'E','1'),(876,47,25,1,'经济座',1600,'F','1'),(877,NULL,25,0,'经济座',1600,'A','2'),(878,NULL,25,0,'经济座',1600,'B','2'),(879,45,25,1,'经济座',1600,'C','2'),(880,NULL,25,0,'经济座',1600,'D','2'),(881,NULL,25,0,'经济座',1600,'E','2'),(882,NULL,25,0,'经济座',1600,'F','2'),(883,NULL,25,0,'经济座',1600,'A','3'),(884,NULL,25,0,'经济座',1600,'B','3'),(885,NULL,25,0,'经济座',1600,'C','3'),(886,NULL,25,0,'经济座',1600,'D','3'),(887,NULL,25,0,'经济座',1600,'E','3'),(888,NULL,25,0,'经济座',1600,'F','3'),(889,49,25,1,'经济座',1600,'A','4'),(890,NULL,25,0,'经济座',1600,'B','4'),(891,NULL,25,0,'经济座',1600,'C','4'),(892,NULL,25,0,'经济座',1600,'D','4'),(893,NULL,25,0,'经济座',1600,'E','4'),(894,NULL,25,0,'经济座',1600,'F','4'),(895,NULL,25,0,'经济座',1600,'A','5'),(896,NULL,25,0,'经济座',1600,'B','5'),(897,NULL,25,0,'经济座',1600,'C','5'),(898,NULL,25,0,'经济座',1600,'D','5'),(899,NULL,25,0,'经济座',1600,'E','5'),(900,NULL,25,0,'经济座',1600,'F','5'),(901,61,25,1,'经济座',1600,'A','6'),(902,63,25,1,'经济座',1600,'B','6'),(903,NULL,25,0,'经济座',1600,'C','6'),(904,NULL,25,0,'经济座',1600,'D','6'),(905,NULL,25,0,'经济座',1600,'E','6'),(906,NULL,25,0,'经济座',1600,'F','6'),(907,NULL,26,0,'标准座',1700,'A','1'),(908,NULL,26,0,'标准座',1700,'B','1'),(909,NULL,26,0,'标准座',1700,'C','1'),(910,NULL,26,0,'标准座',1700,'D','1'),(911,NULL,26,0,'标准座',1700,'E','1'),(912,NULL,26,0,'标准座',1700,'F','1'),(913,NULL,26,0,'标准座',1700,'A','2'),(914,NULL,26,0,'标准座',1700,'B','2'),(915,NULL,26,0,'标准座',1700,'C','2'),(916,NULL,26,0,'标准座',1700,'D','2'),(917,NULL,26,0,'标准座',1700,'E','2'),(918,NULL,26,0,'标准座',1700,'F','2'),(919,NULL,26,0,'标准座',1700,'A','3'),(920,NULL,26,0,'标准座',1700,'B','3'),(921,NULL,26,0,'标准座',1700,'C','3'),(922,NULL,26,0,'标准座',1700,'D','3'),(923,NULL,26,0,'标准座',1700,'E','3'),(924,NULL,26,0,'标准座',1700,'F','3'),(925,NULL,26,0,'标准座',1700,'A','4'),(926,NULL,26,0,'标准座',1700,'B','4'),(927,NULL,26,0,'标准座',1700,'C','4'),(928,NULL,26,0,'标准座',1700,'D','4'),(929,NULL,26,0,'标准座',1700,'E','4'),(930,NULL,26,0,'标准座',1700,'F','4'),(931,NULL,27,0,'标准服务',800,'A','1'),(932,NULL,27,0,'标准服务',800,'B','1'),(933,NULL,27,0,'标准服务',800,'C','1'),(934,NULL,27,0,'标准服务',800,'D','1'),(935,NULL,27,0,'标准服务',800,'E','1'),(936,NULL,27,0,'标准服务',800,'F','1'),(937,NULL,27,0,'标准服务',800,'A','2'),(938,NULL,27,0,'标准服务',800,'B','2'),(939,NULL,27,0,'标准服务',800,'C','2'),(940,NULL,27,0,'标准服务',800,'D','2'),(941,NULL,27,0,'标准服务',800,'E','2'),(942,NULL,27,0,'标准服务',800,'F','2'),(943,NULL,27,0,'标准服务',800,'A','3'),(944,NULL,27,0,'标准服务',800,'B','3'),(945,NULL,27,0,'标准服务',800,'C','3'),(946,NULL,27,0,'标准服务',800,'D','3'),(947,NULL,27,0,'标准服务',800,'E','3'),(948,NULL,27,0,'标准服务',800,'F','3'),(949,NULL,28,0,'经济座',1670,'A','1'),(950,NULL,28,0,'经济座',1670,'B','1'),(951,NULL,28,0,'经济座',1670,'C','1'),(952,NULL,28,0,'经济座',1670,'D','1'),(953,NULL,28,0,'经济座',1670,'E','1'),(954,NULL,28,0,'经济座',1670,'F','1'),(955,NULL,28,0,'经济座',1670,'A','2'),(956,NULL,28,0,'经济座',1670,'B','2'),(957,NULL,28,0,'经济座',1670,'C','2'),(958,NULL,28,0,'经济座',1670,'D','2'),(959,NULL,28,0,'经济座',1670,'E','2'),(960,NULL,28,0,'经济座',1670,'F','2'),(961,NULL,28,0,'经济座',1670,'A','3'),(962,NULL,28,0,'经济座',1670,'B','3'),(963,NULL,28,0,'经济座',1670,'C','3'),(964,NULL,28,0,'经济座',1670,'D','3'),(965,NULL,28,0,'经济座',1670,'E','3'),(966,NULL,28,0,'经济座',1670,'F','3'),(967,NULL,28,0,'经济座',1670,'A','4'),(968,NULL,28,0,'经济座',1670,'B','4'),(969,NULL,28,0,'经济座',1670,'C','4'),(970,NULL,28,0,'经济座',1670,'D','4'),(971,NULL,28,0,'经济座',1670,'E','4'),(972,NULL,28,0,'经济座',1670,'F','4'),(973,NULL,29,0,'经济座',1000,'A','1'),(974,NULL,29,0,'经济座',1000,'B','1'),(975,NULL,29,0,'经济座',1000,'C','1'),(976,NULL,29,0,'经济座',1000,'D','1'),(977,NULL,29,0,'经济座',1000,'E','1'),(978,NULL,29,0,'经济座',1000,'F','1'),(979,NULL,29,0,'经济座',1000,'A','2'),(980,NULL,29,0,'经济座',1000,'B','2'),(981,NULL,29,0,'经济座',1000,'C','2'),(982,NULL,29,0,'经济座',1000,'D','2'),(983,NULL,29,0,'经济座',1000,'E','2'),(984,NULL,29,0,'经济座',1000,'F','2'),(985,NULL,29,0,'经济座',1000,'A','3'),(986,NULL,29,0,'经济座',1000,'B','3'),(987,NULL,29,0,'经济座',1000,'C','3'),(988,NULL,29,0,'经济座',1000,'D','3'),(989,NULL,29,0,'经济座',1000,'E','3'),(990,NULL,29,0,'经济座',1000,'F','3'),(991,NULL,29,0,'经济座',1000,'A','4'),(992,NULL,29,0,'经济座',1000,'B','4'),(993,NULL,29,0,'经济座',1000,'C','4'),(994,NULL,29,0,'经济座',1000,'D','4'),(995,NULL,29,0,'经济座',1000,'E','4'),(996,NULL,29,0,'经济座',1000,'F','4'),(997,NULL,30,0,'经济座',1400,'A','1'),(998,NULL,30,0,'经济座',1400,'B','1'),(999,NULL,30,0,'经济座',1400,'C','1'),(1000,NULL,30,0,'经济座',1400,'D','1'),(1001,NULL,30,0,'经济座',1400,'E','1'),(1002,NULL,30,0,'经济座',1400,'F','1'),(1003,NULL,30,0,'经济座',1400,'A','2'),(1004,NULL,30,0,'经济座',1400,'B','2'),(1005,NULL,30,0,'经济座',1400,'C','2'),(1006,NULL,30,0,'经济座',1400,'D','2'),(1007,NULL,30,0,'经济座',1400,'E','2'),(1008,NULL,30,0,'经济座',1400,'F','2'),(1009,NULL,30,0,'经济座',1400,'A','3'),(1010,NULL,30,0,'经济座',1400,'B','3'),(1011,NULL,30,0,'经济座',1400,'C','3'),(1012,NULL,30,0,'经济座',1400,'D','3'),(1013,NULL,30,0,'经济座',1400,'E','3'),(1014,NULL,30,0,'经济座',1400,'F','3'),(1015,NULL,30,0,'经济座',1400,'A','4'),(1016,NULL,30,0,'经济座',1400,'B','4'),(1017,NULL,30,0,'经济座',1400,'C','4'),(1018,NULL,30,0,'经济座',1400,'D','4'),(1019,NULL,30,0,'经济座',1400,'E','4'),(1020,NULL,30,0,'经济座',1400,'F','4'),(1021,NULL,30,0,'经济座',1400,'A','5'),(1022,NULL,30,0,'经济座',1400,'B','5'),(1023,NULL,30,0,'经济座',1400,'C','5'),(1024,NULL,30,0,'经济座',1400,'D','5'),(1025,NULL,30,0,'经济座',1400,'E','5'),(1026,NULL,30,0,'经济座',1400,'F','5'),(1027,NULL,30,0,'经济座',1400,'A','6'),(1028,NULL,30,0,'经济座',1400,'B','6'),(1029,NULL,30,0,'经济座',1400,'C','6'),(1030,NULL,30,0,'经济座',1400,'D','6'),(1031,NULL,30,0,'经济座',1400,'E','6'),(1032,NULL,30,0,'经济座',1400,'F','6'),(1033,NULL,31,0,'经济座',2100,'A','1'),(1034,NULL,31,0,'经济座',2100,'B','1'),(1035,NULL,31,0,'经济座',2100,'C','1'),(1036,NULL,31,0,'经济座',2100,'D','1'),(1037,NULL,31,0,'经济座',2100,'E','1'),(1038,NULL,31,0,'经济座',2100,'F','1'),(1039,NULL,31,0,'经济座',2100,'A','2'),(1040,NULL,31,0,'经济座',2100,'B','2'),(1041,NULL,31,0,'经济座',2100,'C','2'),(1042,NULL,31,0,'经济座',2100,'D','2'),(1043,NULL,31,0,'经济座',2100,'E','2'),(1044,NULL,31,0,'经济座',2100,'F','2'),(1045,NULL,31,0,'经济座',2100,'A','3'),(1046,NULL,31,0,'经济座',2100,'B','3'),(1047,NULL,31,0,'经济座',2100,'C','3'),(1048,NULL,31,0,'经济座',2100,'D','3'),(1049,NULL,31,0,'经济座',2100,'E','3'),(1050,NULL,31,0,'经济座',2100,'F','3'),(1051,NULL,31,0,'经济座',2100,'A','4'),(1052,NULL,31,0,'经济座',2100,'B','4'),(1053,NULL,31,0,'经济座',2100,'C','4'),(1054,NULL,31,0,'经济座',2100,'D','4'),(1055,NULL,31,0,'经济座',2100,'E','4'),(1056,NULL,31,0,'经济座',2100,'F','4'),(1057,NULL,32,0,'经济座',2600,'A','1'),(1058,NULL,32,0,'经济座',2600,'B','1'),(1059,NULL,32,0,'经济座',2600,'C','1'),(1060,NULL,32,0,'经济座',2600,'D','1'),(1061,NULL,32,0,'经济座',2600,'E','1'),(1062,NULL,32,0,'经济座',2600,'F','1'),(1063,NULL,32,0,'经济座',2600,'A','2'),(1064,NULL,32,0,'经济座',2600,'B','2'),(1065,NULL,32,0,'经济座',2600,'C','2'),(1066,NULL,32,0,'经济座',2600,'D','2'),(1067,NULL,32,0,'经济座',2600,'E','2'),(1068,NULL,32,0,'经济座',2600,'F','2'),(1069,NULL,32,0,'经济座',2600,'A','3'),(1070,NULL,32,0,'经济座',2600,'B','3'),(1071,NULL,32,0,'经济座',2600,'C','3'),(1072,NULL,32,0,'经济座',2600,'D','3'),(1073,NULL,32,0,'经济座',2600,'E','3'),(1074,NULL,32,0,'经济座',2600,'F','3'),(1075,NULL,32,0,'经济座',2600,'A','4'),(1076,NULL,32,0,'经济座',2600,'B','4'),(1077,NULL,32,0,'经济座',2600,'C','4'),(1078,NULL,32,0,'经济座',2600,'D','4'),(1079,NULL,32,0,'经济座',2600,'E','4'),(1080,NULL,32,0,'经济座',2600,'F','4'),(1081,NULL,32,0,'经济座',2600,'A','5'),(1082,NULL,32,0,'经济座',2600,'B','5'),(1083,NULL,32,0,'经济座',2600,'C','5'),(1084,NULL,32,0,'经济座',2600,'D','5'),(1085,NULL,32,0,'经济座',2600,'E','5'),(1086,NULL,32,0,'经济座',2600,'F','5'),(1087,NULL,32,0,'经济座',2600,'A','6'),(1088,NULL,32,0,'经济座',2600,'B','6'),(1089,NULL,32,0,'经济座',2600,'C','6'),(1090,NULL,32,0,'经济座',2600,'D','6'),(1091,NULL,32,0,'经济座',2600,'E','6'),(1092,NULL,32,0,'经济座',2600,'F','6'),(1093,70,33,1,'经济座',2000,'A','1'),(1094,NULL,33,0,'经济座',2000,'B','1'),(1095,NULL,33,0,'经济座',2000,'C','1'),(1096,NULL,33,0,'经济座',2000,'D','1'),(1097,NULL,33,0,'经济座',2000,'E','1'),(1098,NULL,33,0,'经济座',2000,'F','1'),(1099,NULL,33,0,'经济座',2000,'A','2'),(1100,NULL,33,0,'经济座',2000,'B','2'),(1101,NULL,33,0,'经济座',2000,'C','2'),(1102,NULL,33,0,'经济座',2000,'D','2'),(1103,NULL,33,0,'经济座',2000,'E','2'),(1104,NULL,33,0,'经济座',2000,'F','2'),(1105,NULL,33,0,'经济座',2000,'A','3'),(1106,NULL,33,0,'经济座',2000,'B','3'),(1107,NULL,33,0,'经济座',2000,'C','3'),(1108,NULL,33,0,'经济座',2000,'D','3'),(1109,NULL,33,0,'经济座',2000,'E','3'),(1110,NULL,33,0,'经济座',2000,'F','3'),(1111,NULL,34,0,'经济座',2600,'A','1'),(1112,NULL,34,0,'经济座',2600,'B','1'),(1113,NULL,34,0,'经济座',2600,'C','1'),(1114,NULL,34,0,'经济座',2600,'D','1'),(1115,NULL,34,0,'经济座',2600,'E','1'),(1116,NULL,34,0,'经济座',2600,'F','1'),(1117,NULL,34,0,'经济座',2600,'A','2'),(1118,NULL,34,0,'经济座',2600,'B','2'),(1119,NULL,34,0,'经济座',2600,'C','2'),(1120,NULL,34,0,'经济座',2600,'D','2'),(1121,NULL,34,0,'经济座',2600,'E','2'),(1122,NULL,34,0,'经济座',2600,'F','2'),(1123,NULL,34,0,'经济座',2600,'A','3'),(1124,NULL,34,0,'经济座',2600,'B','3'),(1125,NULL,34,0,'经济座',2600,'C','3'),(1126,NULL,34,0,'经济座',2600,'D','3'),(1127,NULL,34,0,'经济座',2600,'E','3'),(1128,NULL,34,0,'经济座',2600,'F','3'),(1129,NULL,34,0,'经济座',2600,'A','4'),(1130,NULL,34,0,'经济座',2600,'B','4'),(1131,NULL,34,0,'经济座',2600,'C','4'),(1132,NULL,34,0,'经济座',2600,'D','4'),(1133,NULL,34,0,'经济座',2600,'E','4'),(1134,NULL,34,0,'经济座',2600,'F','4'),(1135,NULL,34,0,'经济座',2600,'A','5'),(1136,NULL,34,0,'经济座',2600,'B','5'),(1137,NULL,34,0,'经济座',2600,'C','5'),(1138,NULL,34,0,'经济座',2600,'D','5'),(1139,NULL,34,0,'经济座',2600,'E','5'),(1140,NULL,34,0,'经济座',2600,'F','5'),(1141,NULL,34,0,'经济座',2600,'A','6'),(1142,NULL,34,0,'经济座',2600,'B','6'),(1143,NULL,34,0,'经济座',2600,'C','6'),(1144,NULL,34,0,'经济座',2600,'D','6'),(1145,NULL,34,0,'经济座',2600,'E','6'),(1146,NULL,34,0,'经济座',2600,'F','6'),(1147,NULL,35,0,'经济座',1100,'A','1'),(1148,NULL,35,0,'经济座',1100,'B','1'),(1149,NULL,35,0,'经济座',1100,'C','1'),(1150,NULL,35,0,'经济座',1100,'D','1'),(1151,NULL,35,0,'经济座',1100,'E','1'),(1152,NULL,35,0,'经济座',1100,'F','1'),(1153,NULL,35,0,'经济座',1100,'A','2'),(1154,NULL,35,0,'经济座',1100,'B','2'),(1155,NULL,35,0,'经济座',1100,'C','2'),(1156,NULL,35,0,'经济座',1100,'D','2'),(1157,NULL,35,0,'经济座',1100,'E','2'),(1158,NULL,35,0,'经济座',1100,'F','2'),(1159,NULL,35,0,'经济座',1100,'A','3'),(1160,NULL,35,0,'经济座',1100,'B','3'),(1161,NULL,35,0,'经济座',1100,'C','3'),(1162,NULL,35,0,'经济座',1100,'D','3'),(1163,NULL,35,0,'经济座',1100,'E','3'),(1164,NULL,35,0,'经济座',1100,'F','3'),(1165,NULL,36,0,'经济座',2100,'A','1'),(1166,NULL,36,0,'经济座',2100,'B','1'),(1167,NULL,36,0,'经济座',2100,'C','1'),(1168,NULL,36,0,'经济座',2100,'D','1'),(1169,NULL,36,0,'经济座',2100,'E','1'),(1170,NULL,36,0,'经济座',2100,'F','1'),(1171,NULL,36,0,'经济座',2100,'A','2'),(1172,NULL,36,0,'经济座',2100,'B','2'),(1173,NULL,36,0,'经济座',2100,'C','2'),(1174,NULL,36,0,'经济座',2100,'D','2'),(1175,NULL,36,0,'经济座',2100,'E','2'),(1176,NULL,36,0,'经济座',2100,'F','2'),(1177,NULL,36,0,'经济座',2100,'A','3'),(1178,NULL,36,0,'经济座',2100,'B','3'),(1179,NULL,36,0,'经济座',2100,'C','3'),(1180,NULL,36,0,'经济座',2100,'D','3'),(1181,NULL,36,0,'经济座',2100,'E','3'),(1182,NULL,36,0,'经济座',2100,'F','3'),(1183,NULL,36,0,'经济座',2100,'A','4'),(1184,NULL,36,0,'经济座',2100,'B','4'),(1185,NULL,36,0,'经济座',2100,'C','4'),(1186,NULL,36,0,'经济座',2100,'D','4'),(1187,NULL,36,0,'经济座',2100,'E','4'),(1188,NULL,36,0,'经济座',2100,'F','4'),(1189,NULL,36,0,'经济座',2100,'A','5'),(1190,NULL,36,0,'经济座',2100,'B','5'),(1191,NULL,36,0,'经济座',2100,'C','5'),(1192,NULL,36,0,'经济座',2100,'D','5'),(1193,NULL,36,0,'经济座',2100,'E','5'),(1194,NULL,36,0,'经济座',2100,'F','5'),(1195,NULL,36,0,'经济座',2100,'A','6'),(1196,NULL,36,0,'经济座',2100,'B','6'),(1197,NULL,36,0,'经济座',2100,'C','6'),(1198,NULL,36,0,'经济座',2100,'D','6'),(1199,NULL,36,0,'经济座',2100,'E','6'),(1200,NULL,36,0,'经济座',2100,'F','6'),(1201,NULL,36,0,'经济座',2100,'A','7'),(1202,NULL,36,0,'经济座',2100,'B','7'),(1203,NULL,36,0,'经济座',2100,'C','7'),(1204,NULL,36,0,'经济座',2100,'D','7'),(1205,NULL,36,0,'经济座',2100,'E','7'),(1206,NULL,36,0,'经济座',2100,'F','7'),(1207,NULL,36,0,'经济座',2100,'A','8'),(1208,NULL,36,0,'经济座',2100,'B','8'),(1209,NULL,36,0,'经济座',2100,'C','8'),(1210,NULL,36,0,'经济座',2100,'D','8'),(1211,NULL,36,0,'经济座',2100,'E','8'),(1212,NULL,36,0,'经济座',2100,'F','8'),(1213,NULL,37,0,'经济座',740,'A','1'),(1214,NULL,37,0,'经济座',740,'B','1'),(1215,NULL,37,0,'经济座',740,'C','1'),(1216,NULL,37,0,'经济座',740,'D','1'),(1217,NULL,37,0,'经济座',740,'E','1'),(1218,NULL,37,0,'经济座',740,'F','1'),(1219,NULL,37,0,'经济座',740,'A','2'),(1220,NULL,37,0,'经济座',740,'B','2'),(1221,NULL,37,0,'经济座',740,'C','2'),(1222,NULL,37,0,'经济座',740,'D','2'),(1223,NULL,37,0,'经济座',740,'E','2'),(1224,NULL,37,0,'经济座',740,'F','2'),(1225,NULL,37,0,'经济座',740,'A','3'),(1226,NULL,37,0,'经济座',740,'B','3'),(1227,NULL,37,0,'经济座',740,'C','3'),(1228,NULL,37,0,'经济座',740,'D','3'),(1229,NULL,37,0,'经济座',740,'E','3'),(1230,NULL,37,0,'经济座',740,'F','3'),(1231,NULL,38,0,'经济座',1950,'A','1'),(1232,NULL,38,0,'经济座',1950,'B','1'),(1233,NULL,38,0,'经济座',1950,'C','1'),(1234,NULL,38,0,'经济座',1950,'D','1'),(1235,NULL,38,0,'经济座',1950,'E','1'),(1236,NULL,38,0,'经济座',1950,'F','1'),(1237,NULL,38,0,'经济座',1950,'A','2'),(1238,NULL,38,0,'经济座',1950,'B','2'),(1239,NULL,38,0,'经济座',1950,'C','2'),(1240,NULL,38,0,'经济座',1950,'D','2'),(1241,NULL,38,0,'经济座',1950,'E','2'),(1242,NULL,38,0,'经济座',1950,'F','2'),(1243,NULL,38,0,'经济座',1950,'A','3'),(1244,NULL,38,0,'经济座',1950,'B','3'),(1245,NULL,38,0,'经济座',1950,'C','3'),(1246,NULL,38,0,'经济座',1950,'D','3'),(1247,NULL,38,0,'经济座',1950,'E','3'),(1248,NULL,38,0,'经济座',1950,'F','3'),(1249,NULL,38,0,'经济座',1950,'A','4'),(1250,NULL,38,0,'经济座',1950,'B','4'),(1251,NULL,38,0,'经济座',1950,'C','4'),(1252,NULL,38,0,'经济座',1950,'D','4'),(1253,NULL,38,0,'经济座',1950,'E','4'),(1254,NULL,38,0,'经济座',1950,'F','4'),(1255,NULL,39,0,'经济座',1800,'A','1'),(1256,NULL,39,0,'经济座',1800,'B','1'),(1257,NULL,39,0,'经济座',1800,'C','1'),(1258,NULL,39,0,'经济座',1800,'D','1'),(1259,NULL,39,0,'经济座',1800,'E','1'),(1260,NULL,39,0,'经济座',1800,'F','1'),(1261,NULL,39,0,'经济座',1800,'A','2'),(1262,NULL,39,0,'经济座',1800,'B','2'),(1263,NULL,39,0,'经济座',1800,'C','2'),(1264,NULL,39,0,'经济座',1800,'D','2'),(1265,NULL,39,0,'经济座',1800,'E','2'),(1266,NULL,39,0,'经济座',1800,'F','2'),(1267,NULL,39,0,'经济座',1800,'A','3'),(1268,NULL,39,0,'经济座',1800,'B','3'),(1269,NULL,39,0,'经济座',1800,'C','3'),(1270,NULL,39,0,'经济座',1800,'D','3'),(1271,NULL,39,0,'经济座',1800,'E','3'),(1272,NULL,39,0,'经济座',1800,'F','3'),(1273,NULL,39,0,'经济座',1800,'A','4'),(1274,NULL,39,0,'经济座',1800,'B','4'),(1275,NULL,39,0,'经济座',1800,'C','4'),(1276,NULL,39,0,'经济座',1800,'D','4'),(1277,NULL,39,0,'经济座',1800,'E','4'),(1278,NULL,39,0,'经济座',1800,'F','4'),(1279,NULL,40,0,'经济座',1000,'A','1'),(1280,NULL,40,0,'经济座',1000,'B','1'),(1281,NULL,40,0,'经济座',1000,'C','1'),(1282,NULL,40,0,'经济座',1000,'D','1'),(1283,NULL,40,0,'经济座',1000,'E','1'),(1284,NULL,40,0,'经济座',1000,'F','1'),(1285,NULL,40,0,'经济座',1000,'A','2'),(1286,NULL,40,0,'经济座',1000,'B','2'),(1287,NULL,40,0,'经济座',1000,'C','2'),(1288,NULL,40,0,'经济座',1000,'D','2'),(1289,NULL,40,0,'经济座',1000,'E','2'),(1290,NULL,40,0,'经济座',1000,'F','2'),(1291,NULL,40,0,'经济座',1000,'A','3'),(1292,NULL,40,0,'经济座',1000,'B','3'),(1293,NULL,40,0,'经济座',1000,'C','3'),(1294,NULL,40,0,'经济座',1000,'D','3'),(1295,NULL,40,0,'经济座',1000,'E','3'),(1296,NULL,40,0,'经济座',1000,'F','3'),(1297,NULL,41,0,'经济座',1100,'A','1'),(1298,NULL,41,0,'经济座',1100,'B','1'),(1299,NULL,41,0,'经济座',1100,'C','1'),(1300,NULL,41,0,'经济座',1100,'D','1'),(1301,NULL,41,0,'经济座',1100,'E','1'),(1302,NULL,41,0,'经济座',1100,'F','1'),(1303,NULL,41,0,'经济座',1100,'A','2'),(1304,NULL,41,0,'经济座',1100,'B','2'),(1305,NULL,41,0,'经济座',1100,'C','2'),(1306,NULL,41,0,'经济座',1100,'D','2'),(1307,NULL,41,0,'经济座',1100,'E','2'),(1308,NULL,41,0,'经济座',1100,'F','2'),(1309,NULL,41,0,'经济座',1100,'A','3'),(1310,NULL,41,0,'经济座',1100,'B','3'),(1311,NULL,41,0,'经济座',1100,'C','3'),(1312,NULL,41,0,'经济座',1100,'D','3'),(1313,NULL,41,0,'经济座',1100,'E','3'),(1314,NULL,41,0,'经济座',1100,'F','3'),(1315,NULL,42,0,'标准服务',600,'A','1'),(1316,NULL,42,0,'标准服务',600,'B','1'),(1317,NULL,42,0,'标准服务',600,'C','1'),(1318,NULL,42,0,'标准服务',600,'D','1'),(1319,NULL,42,0,'标准服务',600,'E','1'),(1320,NULL,42,0,'标准服务',600,'F','1'),(1321,NULL,42,0,'标准服务',600,'A','2'),(1322,NULL,42,0,'标准服务',600,'B','2'),(1323,NULL,42,0,'标准服务',600,'C','2'),(1324,NULL,42,0,'标准服务',600,'D','2'),(1325,NULL,42,0,'标准服务',600,'E','2'),(1326,NULL,42,0,'标准服务',600,'F','2'),(1327,NULL,42,0,'标准服务',600,'A','3'),(1328,NULL,42,0,'标准服务',600,'B','3'),(1329,NULL,42,0,'标准服务',600,'C','3'),(1330,NULL,42,0,'标准服务',600,'D','3'),(1331,NULL,42,0,'标准服务',600,'E','3'),(1332,NULL,42,0,'标准服务',600,'F','3'),(1333,NULL,43,0,'标准服务',2100,'A','1'),(1334,NULL,43,0,'标准服务',2100,'B','1'),(1335,NULL,43,0,'标准服务',2100,'C','1'),(1336,NULL,43,0,'标准服务',2100,'D','1'),(1337,NULL,43,0,'标准服务',2100,'E','1'),(1338,NULL,43,0,'标准服务',2100,'F','1'),(1339,NULL,43,0,'标准服务',2100,'A','2'),(1340,NULL,43,0,'标准服务',2100,'B','2'),(1341,NULL,43,0,'标准服务',2100,'C','2'),(1342,NULL,43,0,'标准服务',2100,'D','2'),(1343,NULL,43,0,'标准服务',2100,'E','2'),(1344,NULL,43,0,'标准服务',2100,'F','2'),(1345,NULL,43,0,'标准服务',2100,'A','3'),(1346,NULL,43,0,'标准服务',2100,'B','3'),(1347,NULL,43,0,'标准服务',2100,'C','3'),(1348,NULL,43,0,'标准服务',2100,'D','3'),(1349,NULL,43,0,'标准服务',2100,'E','3'),(1350,NULL,43,0,'标准服务',2100,'F','3'),(1351,NULL,43,0,'标准服务',2100,'A','4'),(1352,NULL,43,0,'标准服务',2100,'B','4'),(1353,NULL,43,0,'标准服务',2100,'C','4'),(1354,NULL,43,0,'标准服务',2100,'D','4'),(1355,NULL,43,0,'标准服务',2100,'E','4'),(1356,NULL,43,0,'标准服务',2100,'F','4'),(1357,NULL,44,0,'标准服务',2000,'A','1'),(1358,NULL,44,0,'标准服务',2000,'B','1'),(1359,NULL,44,0,'标准服务',2000,'C','1'),(1360,NULL,44,0,'标准服务',2000,'D','1'),(1361,NULL,44,0,'标准服务',2000,'E','1'),(1362,NULL,44,0,'标准服务',2000,'F','1'),(1363,NULL,44,0,'标准服务',2000,'A','2'),(1364,NULL,44,0,'标准服务',2000,'B','2'),(1365,NULL,44,0,'标准服务',2000,'C','2'),(1366,NULL,44,0,'标准服务',2000,'D','2'),(1367,NULL,44,0,'标准服务',2000,'E','2'),(1368,NULL,44,0,'标准服务',2000,'F','2'),(1369,NULL,44,0,'标准服务',2000,'A','3'),(1370,NULL,44,0,'标准服务',2000,'B','3'),(1371,NULL,44,0,'标准服务',2000,'C','3'),(1372,NULL,44,0,'标准服务',2000,'D','3'),(1373,NULL,44,0,'标准服务',2000,'E','3'),(1374,NULL,44,0,'标准服务',2000,'F','3'),(1375,NULL,45,0,'标准服务',2100,'A','1'),(1376,NULL,45,0,'标准服务',2100,'B','1'),(1377,NULL,45,0,'标准服务',2100,'C','1'),(1378,NULL,45,0,'标准服务',2100,'D','1'),(1379,NULL,45,0,'标准服务',2100,'E','1'),(1380,NULL,45,0,'标准服务',2100,'F','1'),(1381,NULL,45,0,'标准服务',2100,'A','2'),(1382,NULL,45,0,'标准服务',2100,'B','2'),(1383,NULL,45,0,'标准服务',2100,'C','2'),(1384,NULL,45,0,'标准服务',2100,'D','2'),(1385,NULL,45,0,'标准服务',2100,'E','2'),(1386,NULL,45,0,'标准服务',2100,'F','2'),(1387,NULL,45,0,'标准服务',2100,'A','3'),(1388,NULL,45,0,'标准服务',2100,'B','3'),(1389,NULL,45,0,'标准服务',2100,'C','3'),(1390,NULL,45,0,'标准服务',2100,'D','3'),(1391,NULL,45,0,'标准服务',2100,'E','3'),(1392,NULL,45,0,'标准服务',2100,'F','3'),(1393,NULL,45,0,'标准服务',2100,'A','4'),(1394,NULL,45,0,'标准服务',2100,'B','4'),(1395,NULL,45,0,'标准服务',2100,'C','4'),(1396,NULL,45,0,'标准服务',2100,'D','4'),(1397,NULL,45,0,'标准服务',2100,'E','4'),(1398,NULL,45,0,'标准服务',2100,'F','4'),(1399,NULL,46,0,'标准服务',1980,'A','1'),(1400,NULL,46,0,'标准服务',1980,'B','1'),(1401,NULL,46,0,'标准服务',1980,'C','1'),(1402,NULL,46,0,'标准服务',1980,'D','1'),(1403,NULL,46,0,'标准服务',1980,'E','1'),(1404,NULL,46,0,'标准服务',1980,'F','1'),(1405,57,46,1,'标准服务',1980,'A','2'),(1406,NULL,46,0,'标准服务',1980,'B','2'),(1407,NULL,46,0,'标准服务',1980,'C','2'),(1408,NULL,46,0,'标准服务',1980,'D','2'),(1409,NULL,46,0,'标准服务',1980,'E','2'),(1410,60,46,1,'标准服务',1980,'F','2'),(1411,NULL,46,0,'标准服务',1980,'A','3'),(1412,NULL,46,0,'标准服务',1980,'B','3'),(1413,NULL,46,0,'标准服务',1980,'C','3'),(1414,NULL,46,0,'标准服务',1980,'D','3'),(1415,NULL,46,0,'标准服务',1980,'E','3'),(1416,NULL,46,0,'标准服务',1980,'F','3'),(1417,NULL,46,0,'标准服务',1980,'A','4'),(1418,NULL,46,0,'标准服务',1980,'B','4'),(1419,NULL,46,0,'标准服务',1980,'C','4'),(1420,NULL,46,0,'标准服务',1980,'D','4'),(1421,NULL,46,0,'标准服务',1980,'E','4'),(1422,NULL,46,0,'标准服务',1980,'F','4'),(1423,NULL,47,0,'标准套餐',670,'A','1'),(1424,NULL,47,0,'标准套餐',670,'B','1'),(1425,NULL,47,0,'标准套餐',670,'C','1'),(1426,NULL,47,0,'标准套餐',670,'D','1'),(1427,NULL,47,0,'标准套餐',670,'E','1'),(1428,NULL,47,0,'标准套餐',670,'F','1'),(1429,NULL,47,0,'标准套餐',670,'A','2'),(1430,NULL,47,0,'标准套餐',670,'B','2'),(1431,NULL,47,0,'标准套餐',670,'C','2'),(1432,NULL,47,0,'标准套餐',670,'D','2'),(1433,NULL,47,0,'标准套餐',670,'E','2'),(1434,NULL,47,0,'标准套餐',670,'F','2'),(1435,NULL,47,0,'标准套餐',670,'A','3'),(1436,NULL,47,0,'标准套餐',670,'B','3'),(1437,NULL,47,0,'标准套餐',670,'C','3'),(1438,NULL,47,0,'标准套餐',670,'D','3'),(1439,NULL,47,0,'标准套餐',670,'E','3'),(1440,NULL,47,0,'标准套餐',670,'F','3'),(1441,NULL,48,0,'标准座',2400,'A','1'),(1442,NULL,48,0,'标准座',2400,'B','1'),(1443,NULL,48,0,'标准座',2400,'C','1'),(1444,NULL,48,0,'标准座',2400,'D','1'),(1445,NULL,48,0,'标准座',2400,'E','1'),(1446,NULL,48,0,'标准座',2400,'F','1'),(1447,NULL,48,0,'标准座',2400,'A','2'),(1448,NULL,48,0,'标准座',2400,'B','2'),(1449,NULL,48,0,'标准座',2400,'C','2'),(1450,NULL,48,0,'标准座',2400,'D','2'),(1451,NULL,48,0,'标准座',2400,'E','2'),(1452,NULL,48,0,'标准座',2400,'F','2'),(1453,NULL,48,0,'标准座',2400,'A','3'),(1454,NULL,48,0,'标准座',2400,'B','3'),(1455,NULL,48,0,'标准座',2400,'C','3'),(1456,NULL,48,0,'标准座',2400,'D','3'),(1457,NULL,48,0,'标准座',2400,'E','3'),(1458,NULL,48,0,'标准座',2400,'F','3'),(1459,NULL,48,0,'标准座',2400,'A','4'),(1460,NULL,48,0,'标准座',2400,'B','4'),(1461,NULL,48,0,'标准座',2400,'C','4'),(1462,NULL,48,0,'标准座',2400,'D','4'),(1463,NULL,48,0,'标准座',2400,'E','4'),(1464,NULL,48,0,'标准座',2400,'F','4'),(1465,NULL,49,0,'标准座',1400,'A','1'),(1466,NULL,49,0,'标准座',1400,'B','1'),(1467,NULL,49,0,'标准座',1400,'C','1'),(1468,NULL,49,0,'标准座',1400,'D','1'),(1469,NULL,49,0,'标准座',1400,'E','1'),(1470,NULL,49,0,'标准座',1400,'F','1'),(1471,NULL,49,0,'标准座',1400,'A','2'),(1472,NULL,49,0,'标准座',1400,'B','2'),(1473,NULL,49,0,'标准座',1400,'C','2'),(1474,NULL,49,0,'标准座',1400,'D','2'),(1475,NULL,49,0,'标准座',1400,'E','2'),(1476,NULL,49,0,'标准座',1400,'F','2'),(1477,NULL,49,0,'标准座',1400,'A','3'),(1478,NULL,49,0,'标准座',1400,'B','3'),(1479,NULL,49,0,'标准座',1400,'C','3'),(1480,NULL,49,0,'标准座',1400,'D','3'),(1481,NULL,49,0,'标准座',1400,'E','3'),(1482,NULL,49,0,'标准座',1400,'F','3'),(1483,NULL,50,0,'标准座',1920,'A','1'),(1484,NULL,50,0,'标准座',1920,'B','1'),(1485,NULL,50,0,'标准座',1920,'C','1'),(1486,NULL,50,0,'标准座',1920,'D','1'),(1487,NULL,50,0,'标准座',1920,'E','1'),(1488,NULL,50,0,'标准座',1920,'F','1'),(1489,NULL,50,0,'标准座',1920,'A','2'),(1490,NULL,50,0,'标准座',1920,'B','2'),(1491,NULL,50,0,'标准座',1920,'C','2'),(1492,NULL,50,0,'标准座',1920,'D','2'),(1493,NULL,50,0,'标准座',1920,'E','2'),(1494,NULL,50,0,'标准座',1920,'F','2'),(1495,NULL,50,0,'标准座',1920,'A','3'),(1496,NULL,50,0,'标准座',1920,'B','3'),(1497,NULL,50,0,'标准座',1920,'C','3'),(1498,NULL,50,0,'标准座',1920,'D','3'),(1499,NULL,50,0,'标准座',1920,'E','3'),(1500,NULL,50,0,'标准座',1920,'F','3'),(1501,NULL,50,0,'标准座',1920,'A','4'),(1502,NULL,50,0,'标准座',1920,'B','4'),(1503,NULL,50,0,'标准座',1920,'C','4'),(1504,NULL,50,0,'标准座',1920,'D','4'),(1505,NULL,50,0,'标准座',1920,'E','4'),(1506,NULL,50,0,'标准座',1920,'F','4');
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spot`
--

DROP TABLE IF EXISTS `spot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spot` (
  `spot_id` int NOT NULL,
  `city_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `category` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `opening_hours` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `rating` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ticket_price` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`spot_id`),
  KEY `city_id` (`city_id`),
  KEY `idx_spot_name` (`name`),
  CONSTRAINT `spot_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spot`
--

LOCK TABLES `spot` WRITE;
/*!40000 ALTER TABLE `spot` DISABLE KEYS */;
INSERT INTO `spot` VALUES (1,11,'Leyndell','文化古迹','王城罗德尔是黄金树之城，\n\n也是一座有双重城墙固守的大城。\n\n据说靠近城中心的那道墙，\n\n至今依旧无人攻破。','亚坛高原王城罗德尔','全天24小时','4','20￥/位'),(2,1,'故宫（紫禁城）','著名历史文化古迹（宫殿）','北京故宫（The Imperial Palace ）位于中国北京市，是中国明清两代的皇家宫殿，又称紫禁城，位于北京中轴线的中心。故宫以三大殿为中心，占地面积约72万平方米，建筑面积约15万平方米，有大小宫殿七十多座，相传故宫一共有9999.5间，实际据1973年专家现场测量故宫有房间8707间 。故宫是中国明清两朝二十四位皇帝的皇宫。故宫始建于明成祖永乐四年（1406年），永乐十八年（1420年）落成。位于北京中轴线中心的故宫，占地面积72万平方米，建筑面积约15万平方米，有大小宫殿七十多座，房屋九千余间。是世界上现存规模最大、最完整的宫殿型建筑。北京故宫是第一批全国重点文物保护单位、第一批国家5A级旅游景区，1987年被选入《世界文化遗产》名录，亦为2024年7月27日所入选另一项世界遗产“北京中轴线——中国理想都城秩序的杰作”的一部分。故宫现为故宫博物院，藏品主要以明、清两代宫廷收藏为基础，是国家一级博物馆。','北京市东城区','早上9:00-下午5:00','5','50￥/位'),(3,12,'新泽西号战列舰 (BB-62)','海上传奇','新泽西号（USS New Jersey）是一艘隶属于美国海军的战列舰，为衣阿华级战列舰的二号舰。她是美军第二艘以新泽西州为名的军舰。新泽西号在1940年按照第二次文森法案（Second Vinson Act），于费城造船厂开始建造，在1942年下水，并在1943年服役，其时美国已参与第二次世界大战多时。新泽西号旋即被派往太平洋战区，并先后参与吉尔伯特及马绍尔群岛战事、马里亚纳群岛及帕劳战事、莱特湾海战、硫磺岛战役及冲绳战役。战争结束前数月，新泽西号返国维修，在日本投降后返抵远东，并协助美军占领日本，然后参与魔毯行动（Operation Magic Carpet），接载美军返国。2000年，新泽西号正式改装为博物馆舰，并在新泽西州肯顿对外开放，一代海上传奇就此落幕。','卡姆登（肯顿）市Clinton St大街100号，特拉华河畔','早上9:00-下午5:30','5','210￥/位'),(4,4,'自由女神像','著名塑像','自由女神像（英语：Statue of Liberty）又名自由照耀世界（英语：Liberty Enlightening the World，法语：La Liberté éclairant le monde），是位于美国纽约港自由岛的巨型古典主义塑像，由弗雷德里克·奥古斯特·巴托尔迪设计，古斯塔夫·埃菲尔建造，1886年10月28日落成，是法国人民送给美国人民的礼物。塑像人物是身穿长袍的女子，代表罗马神话中的自主神，她右手高举火炬，左手的册子上用罗马数字写有美国独立宣言签署日期：“JULY IV MDCCLXXVI”（1776年7月4日），脚下还有断裂的锁链。这座塑像是自由和美国的象征，也是对外来移民的欢迎信号。','纽约港自由岛','全天24小时','4.5','0￥/位'),(5,8,'天守阁（姬路城）','著名历史文化古迹（城堡）','天守（日语：天守／てんしゅ Tenshu */?），又称为天守阁（日语：天守閣／てんしゅかく Tenshukaku），是日式城堡中位于顶端的阁楼和屋顶部分，也在视觉上最具冲击力的一环，具有瞭望、指挥的功能。在日本传统文化中，天守也是封建权利的象征之一，代表拥有者有着强大的武力。','大阪市中央区','全天24小时','3.5','40￥/位'),(6,9,'埃菲尔铁塔','著名建筑','埃菲尔铁塔（法语：Tour Eiffel，/ˈaɪfəl/ [tuʁ‿ɛfɛl] （ⓘ），也常称为巴黎铁塔）是位于法国巴黎第七区、塞纳河畔战神广场的铁制镂空塔，世界著名建筑，也是法国文化象征之一，巴黎城市地标之一，巴黎最高建筑物。正式地址为Rue Anatole-France 5号。 埃菲尔铁塔建成于1889年，初名为“三百米塔”，后得名自其设计师居斯塔夫·埃菲尔。铁塔是世界建筑史上的技术杰作，也是世界上最多人付费参观的名胜古迹，这个为了世界博览会而落成的金属建筑，2011年约有698万人参观，是法国参观人数第二多的文化景点。1986年美国土木工程师协会将该建筑列入国际土木工程历史古迹，1991年，埃菲尔铁塔连同巴黎塞纳河沿岸整座被列入世界遗产。','法国巴黎第七区','全天（午夜歇业）','4.5','0￥/位');
/*!40000 ALTER TABLE `spot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spot_evaluluate`
--

DROP TABLE IF EXISTS `spot_evaluluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spot_evaluluate` (
  `spot_evaluluate_id` int NOT NULL,
  `spot_id` int DEFAULT NULL,
  `evaluluate` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `user_name` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`spot_evaluluate_id`),
  KEY `spot_id` (`spot_id`),
  CONSTRAINT `spot_evaluluate_ibfk_1` FOREIGN KEY (`spot_id`) REFERENCES `spot` (`spot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spot_evaluluate`
--

LOCK TABLES `spot_evaluluate` WRITE;
/*!40000 ALTER TABLE `spot_evaluluate` DISABLE KEYS */;
INSERT INTO `spot_evaluluate` VALUES (1,2,'中华文明之瑰宝，古代宫殿之桂冠。',5,'PYJ'),(2,3,'大海铭记不朽。',5,'PYJ'),(3,3,'406毫米のKing，比肩大和的美',4,'Polo Peng'),(4,5,'直到现在我都无法用语言形容我的感受，游览姬路城时，无时不刻感受到强大的压迫感。弯曲陡峭的盘旋上坡路，无处不在的射击孔，落石孔，必须弯腰才能前进的窄门，60度左右的楼梯，昏暗的视线，暗藏的武士密室，头顶的木板可能突然掀开、乱枪刺下。你完全不知道攻击来自何方，几个小天守会让你迷失方向。\n如果我是敌方士兵，面对这座名城我会选择逃跑。第一次近距离感受古代攻城战的残酷，我对姬路城的历代建造者表达最高的敬意。\n顺便说一下，姬路城下了大天守阁，就有一个叫“腹切丸”的景点，大家自己去理解吧……',4,'Try'),(5,3,'非常值得一去，但是要注意下午五点半关门，完整的参观下来需要两到三个小时。如果你想仔细参观一遍需要更多时间。参观内容更侧重于战舰上士兵们的日常生活和战舰的历史，武器方面比较少。\n\n遗憾的是不能参观它的主炮供弹系统。但我听说密苏里号的主炮就可以参观。',5,'PYJ'),(6,3,'这一定是新泽西州最好的博物馆之一！  志愿船员非常努力地保持船舶的清洁和安全。  他们有精彩的巡演、精彩的活动，瑞安·西曼斯基 (Ryan Simanski) 在 YouTube Chanel 上的表现也非常出色。  我可以回去100次！',5,'Try'),(7,2,'明清两代建都于此地，歷经六百年的经营，体现出中国千年来宫廷建筑之美，从电影或电视剧上都可以看到清代宫廷剧里的建筑，但是亲眼看到才会觉得雄偉的力量。信步闲庭漫步在明清时期的雄偉建筑，令人感觉到宮廷深处不勝寒，更感受到古代的皇帝孤家寡人的悲哀。有些东西也特别有趣，就是故宫博物院的御貓玩偶公仔，可以让人在肅穆的气氛下，有著一些欢乐的趣味，来北京旅游必须来的景点，建议要提前网上预约，一大早就进去，否则可就只能走馬看花了。故宫里的几个地方必定要去的，延禧宫，儲秀宫及正大光明殿',5,'Try'),(8,2,'初一的时候人灰常的多，建议早点去。需要安检，尽量少带点东西。买票现在都是通过官网购买。来北京一定要去的地方。',5,'Polo Peng');
/*!40000 ALTER TABLE `spot_evaluluate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spot_ticket`
--

DROP TABLE IF EXISTS `spot_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spot_ticket` (
  `spot_ticket_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `spot_id` int DEFAULT NULL,
  `time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `value` int DEFAULT NULL,
  PRIMARY KEY (`spot_ticket_id`),
  KEY `idx_spot_ticket_spot_id` (`spot_id`),
  KEY `idx_spot_ticket_client_id` (`client_id`),
  CONSTRAINT `spot_ticket_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  CONSTRAINT `spot_ticket_ibfk_2` FOREIGN KEY (`spot_id`) REFERENCES `spot` (`spot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spot_ticket`
--

LOCK TABLES `spot_ticket` WRITE;
/*!40000 ALTER TABLE `spot_ticket` DISABLE KEYS */;
INSERT INTO `spot_ticket` VALUES (1,1,3,'2024-09-01',210),(2,1,5,'2024-09-08',40),(3,1,5,'2024-09-08',40),(4,1,5,'2024-09-08',40),(5,3,2,'2024-09-09',50),(6,2,2,'2024-09-09',50),(7,2,2,'2024-09-09',50);
/*!40000 ALTER TABLE `spot_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics_day`
--

DROP TABLE IF EXISTS `statistics_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statistics_day` (
  `day` varchar(255) COLLATE utf8_bin NOT NULL,
  `login_count` int DEFAULT NULL,
  `request_count` int DEFAULT NULL,
  `create_count` int DEFAULT NULL,
  `modify_count` int DEFAULT NULL,
  PRIMARY KEY (`day`),
  KEY `idx_statistics_day_day` (`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics_day`
--

LOCK TABLES `statistics_day` WRITE;
/*!40000 ALTER TABLE `statistics_day` DISABLE KEYS */;
INSERT INTO `statistics_day` VALUES ('20230701',3,12,1,1),('20230702',6,13,0,2),('20230703',5,12,2,0),('20230704',7,20,1,5),('20230705',3,6,2,3),('20230706',4,12,1,5);
/*!40000 ALTER TABLE `statistics_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_info`
--

DROP TABLE IF EXISTS `system_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_info` (
  `id` int NOT NULL,
  `des` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_system_info_value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_info`
--

LOCK TABLES `system_info` WRITE;
/*!40000 ALTER TABLE `system_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariff`
--

DROP TABLE IF EXISTS `tariff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tariff` (
  `tariff_id` int NOT NULL,
  `plane_id` int DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `price` int DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`tariff_id`),
  KEY `plane_id` (`plane_id`),
  CONSTRAINT `tariff_ibfk_1` FOREIGN KEY (`plane_id`) REFERENCES `plane` (`plane_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff`
--

LOCK TABLES `tariff` WRITE;
/*!40000 ALTER TABLE `tariff` DISABLE KEYS */;
INSERT INTO `tariff` VALUES (1,1,'标准服务套餐',1000,'经济座'),(2,1,'标准服务套餐+餐食',1200,'商务座'),(3,2,'标准服务套餐',1100,'经济座'),(4,2,'标准服务套餐+餐食',1200,'商务座'),(5,2,'标准服务套餐+餐食+纪念品',1400,'VIP座'),(6,3,'标准服务套餐',1150,'经济座'),(7,3,'标准服务套餐+餐食',1280,'商务座'),(8,3,'标准服务套餐+餐食+纪念品',1400,'VIP座'),(9,4,'标准服务套餐',800,'经济座'),(10,4,'标准服务套餐+餐食',950,'商务座'),(11,5,'标准服务套餐',1150,'经济座'),(12,5,'标准服务套餐+餐食',1280,'商务座'),(13,6,'标准服务套餐',2300,'经济座'),(14,6,'标准服务套餐+餐食',2600,'商务座'),(15,6,'标准服务套餐+餐食+纪念品',2800,'VIP座'),(16,7,'标准服务套餐',1800,'经济座'),(17,7,'标准服务套餐+餐食',2000,'商务座'),(18,8,'标准服务套餐',1720,'经济座'),(19,8,'标准服务套餐+餐食',1850,'商务座'),(20,8,'标准服务套餐+餐食+纪念品',2100,'VIP座'),(21,9,'标准服务套餐',2110,'经济座'),(22,9,'标准服务套餐+餐食',2300,'商务座'),(23,10,'标准服务套餐',1030,'经济座'),(24,10,'标准服务套餐+餐食',1200,'商务座'),(25,11,'标准服务套餐',1710,'经济座'),(26,11,'标准服务套餐+餐食',1800,'商务座'),(27,11,'标准服务套餐+餐食+纪念品',1980,'VIP座'),(28,12,'标准服务套餐',1110,'经济座'),(29,12,'标准服务套餐+餐食',1210,'商务座'),(30,13,'标准服务套餐',1800,'经济座'),(31,14,'标准服务',2200,'标准服务'),(32,14,'会员服务+餐食',2600,'会员服务'),(33,15,'标准服务',1600,'标准服务'),(34,15,'会员服务+套餐',1800,'会员服务'),(35,16,'标准服务',2100,'标准服务'),(36,16,'会员服务',2310,'会员服务'),(37,17,'标准服务',1900,'标准服务'),(38,17,'会员服务+餐食',2100,'会员服务'),(39,17,'VIP专享服务套餐',2300,'VIP服务'),(40,18,'标准服务',1850,'标准服务'),(41,19,'标准服务',1740,'标准服务'),(42,20,'标准服务',1400,'标准服务'),(43,20,'会员服务',1500,'会员服务'),(44,21,'标准服务套餐',1100,'标准服务'),(45,22,'标准服务',950,'标准服务'),(46,22,'增值服务套餐',1200,'会员服务'),(47,23,'标准服务套餐',1480,'标准座'),(48,23,'标准服务套餐+餐食',1600,'商务座'),(49,24,'标准服务套餐',1200,'标准座'),(50,24,'标准服务套餐+餐食',1350,'商务座'),(51,25,'标准服务',1600,'经济座'),(52,25,'标准服务+餐食',1800,'商务座'),(53,25,'增值服务套餐',2000,'VIP座'),(54,26,'标准服务套餐',1700,'标准座'),(55,26,'商务服务',1850,'商务座'),(56,27,'标准服务套餐',800,'标准服务'),(57,28,'标准服务',1670,'经济座'),(58,29,'标准服务套餐',1000,'经济座'),(59,29,'商务服务',1150,'商务座'),(60,30,'标准服务套餐',1400,'经济座'),(61,30,'商务服务套餐+餐食+纪念品',1800,'VIP座'),(62,31,'标准服务套餐',2100,'经济座'),(63,31,'标准服务套餐+纪念品',2200,'商务座'),(64,32,'标准服务类型',2600,'经济座'),(65,32,'商务服务套餐+餐食',2900,'商务座'),(66,33,'标准服务套餐',2000,'经济座'),(67,33,'商务座套餐',2150,'商务座'),(68,34,'标准服务套餐',2600,'经济座'),(69,34,'标准服务套餐+餐食',2750,'商务座'),(70,35,'标准服务套餐',1100,'经济座'),(71,35,'商务特惠服务',1200,'商务座'),(72,36,'标准服务套餐',2100,'经济座'),(73,36,'标准服务套餐+餐食',2250,'商务座'),(74,37,'标准服务套餐',740,'经济座'),(75,37,'商务套餐',820,'商务座'),(76,37,'豪华套餐+纪念品',1000,'VIP座'),(77,38,'标准服务套餐',1950,'经济座'),(78,39,'标准服务套餐',1800,'经济座'),(79,39,'标准服务套餐+餐食',2000,'商务座'),(80,40,'标准服务套餐',1000,'经济座'),(81,40,'商务套餐',1150,'商务座'),(82,41,'标准服务套餐',1100,'经济座'),(83,41,'标准服务套餐+餐食',1200,'商务座'),(84,42,'标准服务',600,'标准服务'),(85,43,'标准服务',2100,'标准服务'),(86,43,'标准服务+餐食',2300,'商务服务'),(87,44,'标准服务',2000,'标准服务'),(88,44,'增值服务+纪念品',2400,'VIP服务'),(89,45,'标准服务套餐',2100,'标准服务'),(90,45,'标准服务套餐+餐食',2250,'商务套餐'),(91,46,'标准服务套餐',1980,'标准服务'),(92,47,'标准服务套餐',670,'标准套餐'),(93,48,'标准服务',2400,'标准座'),(94,48,'标准服务+餐食',2560,'商务座'),(95,49,'标准服务',1400,'标准座'),(96,50,'标准服务套餐',1920,'标准座'),(97,50,'标准服务+餐食',2050,'商务座');
/*!40000 ALTER TABLE `tariff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `team_id` int NOT NULL,
  `laboratory` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `num` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `score` double DEFAULT NULL,
  `upload_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `uploader_id` int DEFAULT NULL,
  `create_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `creator_id` int DEFAULT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_record`
--

DROP TABLE IF EXISTS `travel_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `travel_record` (
  `travel_record_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `arrival_airport_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `departure_airport_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`travel_record_id`),
  KEY `idx_travel_record_client_id` (`client_id`),
  KEY `idx_travel_record_arrival_airport_name` (`arrival_airport_name`),
  KEY `idx_travel_record_departure_airport_name` (`departure_airport_name`),
  CONSTRAINT `travel_record_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_record`
--

LOCK TABLES `travel_record` WRITE;
/*!40000 ALTER TABLE `travel_record` DISABLE KEYS */;
INSERT INTO `travel_record` VALUES (1,1,'肯尼迪国际机场（纽约）','大兴国际机场（北京）','已退款'),(2,1,'肯尼迪国际机场（纽约）','大兴国际机场（北京）','已退款'),(3,1,'夏尔·戴高乐机场（巴黎）','肯尼迪国际机场（纽约）','已付款'),(4,2,'夏尔·戴高乐机场（巴黎）','肯尼迪国际机场（纽约）','已付款'),(5,1,'肯尼迪国际机场（纽约）','大兴国际机场（北京）','已付款'),(6,1,'夏尔·戴高乐机场（巴黎）','大兴国际机场（北京）','已付款'),(7,1,'成田国际机场（东京）','大兴国际机场（北京）','已付款'),(8,1,'普希金国际机场（莫斯科）','大兴国际机场（北京）','已退款'),(9,1,'普希金国际机场（莫斯科）','大兴国际机场（北京）','已付款'),(11,1,'浦东国际机场（上海）','成田国际机场（东京）','已付款'),(12,1,'浦东国际机场（上海）','成田国际机场（东京）','已付款'),(13,1,'浦东国际机场（上海）','成田国际机场（东京）','已付款'),(14,1,'浦东国际机场（上海）','成田国际机场（东京）','已付款'),(15,1,'浦东国际机场（上海）','成田国际机场（东京）','已退款'),(16,1,'肯尼迪国际机场（纽约）','大兴国际机场（北京）','已付款'),(17,3,'夏尔·戴高乐机场（巴黎）','成田国际机场（东京）','已退款'),(18,3,'夏尔·戴高乐机场（巴黎）','成田国际机场（东京）','已付款'),(19,3,'夏尔·戴高乐机场（巴黎）','成田国际机场（东京）','已付款'),(21,2,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(22,3,'浦东国际机场（上海）','大兴国际机场（北京）','已退款'),(23,3,'肯尼迪国际机场（纽约）','大兴国际机场（北京）','已退款'),(24,1,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(25,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(26,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(27,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(28,3,'肯尼迪国际机场（纽约）','成田国际机场（东京）','已付款'),(29,3,'肯尼迪国际机场（纽约）','成田国际机场（东京）','已付款'),(30,3,'夏尔·戴高乐机场（巴黎）','大兴国际机场（北京）','已付款'),(31,3,'夏尔·戴高乐机场（巴黎）','大兴国际机场（北京）','已付款'),(32,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(33,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款'),(34,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已退款'),(35,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已退款'),(36,3,'希思罗机场（伦敦）','大兴国际机场（北京）','已付款');
/*!40000 ALTER TABLE `travel_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `user_type_id` int DEFAULT NULL,
  `person_id` int DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `last_login_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `login_count` int DEFAULT NULL,
  `create_time` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `creator_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK4bakctviobmdk6ddh2nwg08c2` (`user_name`),
  KEY `user_type_id` (`user_type_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,1,'admin','$2a$10$cyljbX1LC3S/hCxU2ntKVOJj7IwiGzSdvK8vOw307k0Ym9F/rXW9O','2024-09-05 21:37:20',199,'2023-07-06 00:00:01',1),(2,4,2,'C466668210','$2a$10$LZF1HTYkZeQzizea/7Xqw.T2xjytrDKBcif.OeeXjX7crgYpSVXsS','2024-09-05 21:36:40',69,'2024-07-21 18:47:23',2),(3,5,3,'A553167','$2a$10$5yRGWOvyfw6o/0dTaG4X.ek2uD8S7SuUAbUxs4ocZN4.Oi2f/ygy2','2024-09-05 12:34:23',39,'2024-08-04 18:00:17',3),(4,4,4,'C754303860','$2a$10$ONqhaJ34Kp3ejNKFM9X3SOSG7eI4sdXxXlQlgrWpQBHp59xM6i4xS','2024-09-04 10:44:17',18,'2024-08-08 19:32:36',4),(5,5,5,'A464825','$2a$10$zwKGAxjoYjkYHm0nSnuZi.OwNiKp30y4CW78H3kgnfoWRwHfxStjO','2024-09-05 20:04:18',10,'2024-08-21 22:01:28',5),(6,4,6,'C262695319','$2a$10$WcvzzcoApywGb70bJsBPbOVQU/A6tcgtqw9amhhA9JybGqrCli19q','2024-09-05 20:40:10',12,'2024-09-02 09:17:53',6);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_type` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_STUDENT'),(3,'ROLE_TEACHER'),(4,'ROLE_CLIENT'),(5,'ROLE_AIRLINECOMPANY');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visa_free_agreement`
--

DROP TABLE IF EXISTS `visa_free_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visa_free_agreement` (
  `id` int NOT NULL,
  `nation1_id` int DEFAULT NULL,
  `nation2_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_visa_free_agreement_nation1_id` (`nation1_id`),
  KEY `idx_visa_free_agreement_nation2_id` (`nation2_id`),
  CONSTRAINT `visa_free_agreement_ibfk_1` FOREIGN KEY (`nation1_id`) REFERENCES `nation` (`nation_id`),
  CONSTRAINT `visa_free_agreement_ibfk_2` FOREIGN KEY (`nation2_id`) REFERENCES `nation` (`nation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visa_free_agreement`
--

LOCK TABLES `visa_free_agreement` WRITE;
/*!40000 ALTER TABLE `visa_free_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `visa_free_agreement` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-06  7:59:24
