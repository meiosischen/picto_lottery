-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	5.5.20

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
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `account_role`
--

LOCK TABLES `account_role` WRITE;
/*!40000 ALTER TABLE `account_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (24,6,1,'sign2','16j0pxfq','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-27 22:39:39','store6',1,'2016-05-27 21:39:39',NULL),(25,4,1,'sign1','1mw1m30p','/images/sign.png','TEST555511118888',0,'discount4',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-27 22:44:13','store4',1,'2016-05-27 21:44:13',NULL),(26,4,1,'sign1','1pmm8byo','/images/sign.png','TEST555511118888',0,'discount4',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-27 22:46:07','store4',1,'2016-05-27 21:46:07',NULL),(27,3,1,'newproduct','1pxlziu8','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-27 22:46:50','store3',1,'2016-05-27 21:46:50',NULL),(28,3,1,'newproduct','1ajx4u5f','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-27 22:47:17','store3',1,'2016-05-27 21:47:17',NULL),(29,4,1,'sign1','130x3a16','/images/sign.png','TEST555511118888',0,'discount4',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-27 23:39:29','store4',1,'2016-05-27 22:39:29',NULL),(30,6,1,'sign2','1p3pp5ug','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 10:34:25','store6',1,'2016-05-28 09:34:25',NULL),(31,4,1,'sign1','1e7ztl5k','/images/sign.png','TEST555511118888',0,'discount4',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 10:34:54','store4',1,'2016-05-28 09:34:54',NULL),(32,6,1,'sign2','1rychfz8','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 10:36:25','store6',2,'2016-05-28 09:36:25','2016-05-28 10:24:12'),(33,2,1,'cashdeduct','158c2b3w','/images/cashDeduction.png','TEST555511118888',1,'discount2',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 10:48:11','store2',2,'2016-05-28 09:48:11','2016-05-28 10:19:39'),(34,3,1,'newproduct','1s3rm9ph','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 10:59:50','store3',1,'2016-05-28 09:59:50',NULL),(35,2,1,'cashdeduct','1l36yrsc','/images/cashDeduction.png','TEST555511118888',1,'discount2',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 11:00:19','store2',1,'2016-05-28 10:00:19',NULL),(36,3,1,'newproduct','11c8f9s0','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 11:00:43','store3',1,'2016-05-28 10:00:43',NULL),(37,3,1,'newproduct','11bqpsau','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-30 10:27:08','store3',1,'2016-05-28 10:27:08',NULL),(38,3,1,'newproduct','1rlaoigy','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-30 10:28:08','store3',1,'2016-05-28 10:28:08',NULL),(39,2,1,'cashdeduct','1wpkiax3','/images/cashDeduction.png','TEST555511118888',1,'discount2',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 12:28:31','store2',1,'2016-05-28 10:28:31',NULL),(40,2,1,'cashdeduct','1didhkh3','/images/cashDeduction.png','TEST555511118888',1,'discount2',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 12:28:55','store2',1,'2016-05-28 10:28:55',NULL),(41,2,1,'cashdeduct','1jcuzyda','/images/cashDeduction.png','TEST555511118888',1,'discount2',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-28 12:29:17','store2',1,'2016-05-28 10:29:17',NULL),(42,6,1,'sign2','1ii9z0bv','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-06-02 10:30:05','store6',1,'2016-05-28 10:30:05',NULL),(43,6,1,'sign2','1rw0plnf','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-06-02 11:01:01','store6',1,'2016-05-28 11:01:01',NULL),(44,6,1,'sign2','1o6vsg1m','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-06-02 11:06:21','store6',1,'2016-05-28 11:06:21',NULL),(45,3,1,'newproduct','1ts2t8th','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-30 11:29:10','store3',2,'2016-05-28 11:29:10','2016-05-28 11:29:16'),(46,3,1,'????','1wf1etea','/images/newProduct.png','TEST555511118888',0,'discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-05-30 16:37:02','store3',1,'2016-05-28 16:37:02',NULL),(47,6,1,'?????','1f8qfrax','/images/sign.png','TEST555511118888',0,'discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3','2016-06-02 17:22:23','store6',1,'2016-05-28 17:22:23',NULL);
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `coupon_type`
--

LOCK TABLES `coupon_type` WRITE;
/*!40000 ALTER TABLE `coupon_type` DISABLE KEYS */;
INSERT INTO `coupon_type` VALUES (1,1,'全单5折','/images/50off.png',2,2,1,1,NULL,1,1,'2016-05-23 23:43:00',NULL,1),(2,1,'现金折扣','/images/cashDeduction.png',111,82,1,1,NULL,19,1,'2016-05-23 23:43:00','2016-05-28 10:29:04',1),(3,1,'新品赠送','/images/newProduct.png',111,123,0,1,NULL,28,1,'2016-05-23 23:43:00','2016-05-28 17:06:02',1),(4,1,'sign','/images/sign.png',111,174,0,1,NULL,27,1,'2016-05-23 23:43:00','2016-05-28 17:21:56',1),(5,1,'谢谢惠顾',NULL,1,100,0,1,NULL,1,1,'2016-05-23 23:43:00',NULL,2),(7,2,'cd','\\uploads\\1\\cashDeduction_20160604172208.png',100,100,1,1,NULL,4,1,'2016-06-03 01:07:29','2016-06-04 17:22:25',1),(8,2,'sign','\\uploads\\1\\sign_20160603010945.png',100,100,0,1,NULL,1,1,'2016-06-03 01:10:22',NULL,1),(9,2,'????','\\uploads\\1\\newProduct_20160603194010.png',100,100,1,3,NULL,1,1,'2016-06-03 19:40:23',NULL,1);
/*!40000 ALTER TABLE `coupon_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `coupon_type_discount_rel`
--

LOCK TABLES `coupon_type_discount_rel` WRITE;
/*!40000 ALTER TABLE `coupon_type_discount_rel` DISABLE KEYS */;
INSERT INTO `coupon_type_discount_rel` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,0,5),(6,4,6),(7,9,9);
/*!40000 ALTER TABLE `coupon_type_discount_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `discount_product`
--

LOCK TABLES `discount_product` WRITE;
/*!40000 ALTER TABLE `discount_product` DISABLE KEYS */;
INSERT INTO `discount_product` VALUES (1,1,'全单5折','/images/50off.png','discount1',1,'useMsg','limitMsg1,limitMsg2,limitMsg3',1,'store1',1,'2016-05-24 22:27:00','2016-05-24 22:27:00',0),(2,1,'现金折扣','/images/cashDeduction.png','discount2',1,'useMsg','limitMsg1,limitMsg2,limitMsg3',2,'store2',1,'2016-05-24 22:27:00',NULL,0),(3,1,'新品赠送','/images/newProduct.png','discount3',1,'useMsg','limitMsg1,limitMsg2,limitMsg3',48,'store3',1,'2016-05-24 22:27:00',NULL,0),(4,1,'这是什么','/images/sign.png','discount4',1,'useMsg','limitMsg1,limitMsg2,limitMsg3',120,'store4',1,'2016-05-24 22:27:00',NULL,0),(5,0,NULL,NULL,NULL,NULL,'useMsg','limitMsg1,limitMsg2,limitMsg3',NULL,'store5',0,'0000-00-00 00:00:00',NULL,0),(6,1,'这又是什么','/images/sign.png','discount5',1,'useMsg','limitMsg1,limitMsg2,limitMsg3',120,'store6',1,'2016-05-24 22:27:00',NULL,0),(7,2,'sign','\\uploads\\1\\sign_20160604222449.png','5',1,'aaa','bb,123456789012,aaa23',1,NULL,1,'2016-06-04 22:28:20','2016-06-04 23:28:05',1),(9,2,'new','\\uploads\\1\\newProduct_20160604223705.png','4',1,'asd','abcdefghijkl,adsf,123456789012',2,NULL,1,'2016-06-04 22:38:17',NULL,1);
/*!40000 ALTER TABLE `discount_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `merchant`
--

LOCK TABLES `merchant` WRITE;
/*!40000 ALTER TABLE `merchant` DISABLE KEYS */;
INSERT INTO `merchant` VALUES (1,'picto','picto',NULL,'021-12345678',NULL,'I\'m in the earth!',500,'','efd',NULL,NULL,NULL,'/images/advert_top.jpg','/images/advert_bottom.jpg','/images/advert_bottom.jpg',NULL,'\\uploads\\1\\mr-prize_qrcode_20160601224505.png',1,'2016-05-22 16:24:00','2016-06-01 22:45:15',1),(2,'mr-prize','mr-prize',NULL,'021-87654321',NULL,'here44',4001,'','abc14',NULL,NULL,NULL,'/images/advert_top.jpg','/images/advert_bottom.jpg','/images/advert_bottom.jpg',NULL,'\\uploads\\1\\import_20160601224905.png',1,'2016-05-22 16:24:00','2016-06-01 22:49:57',2);
/*!40000 ALTER TABLE `merchant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `operation_record`
--

LOCK TABLES `operation_record` WRITE;
/*!40000 ALTER TABLE `operation_record` DISABLE KEYS */;
INSERT INTO `operation_record` VALUES (1,'TEST555511118888',1,'',1,'2016-05-21 22:54:00','2016-05-22 22:54:00'),(2,'TEST555511118888',1,NULL,1,'2016-05-24 00:10:21','2016-05-24 00:10:21'),(3,'TEST555511118888',1,NULL,1,'2016-05-24 00:11:33','2016-05-24 00:11:33'),(4,'TEST555511118888',1,NULL,1,'2016-05-24 00:15:17','2016-05-24 00:15:17'),(5,'TEST555511118888',1,NULL,1,'2016-05-24 22:10:57','2016-05-24 22:10:57'),(6,'TEST555511118888',1,NULL,1,'2016-05-24 22:24:38','2016-05-24 22:24:38'),(7,'TEST555511118888',1,NULL,1,'2016-05-24 22:24:38','2016-05-24 22:24:38'),(8,'TEST555511118888',1,NULL,1,'2016-05-24 22:28:31','2016-05-24 22:28:31'),(9,'TEST555511118888',1,NULL,1,'2016-05-24 22:31:30','2016-05-24 22:31:30'),(10,'TEST555511118888',1,NULL,1,'2016-05-24 22:43:06','2016-05-24 22:43:06'),(11,'TEST555511118888',1,NULL,1,'2016-05-24 22:44:22','2016-05-24 22:44:22'),(12,'TEST555511118888',1,NULL,1,'2016-05-24 23:00:01','2016-05-24 23:00:01'),(13,'TEST555511118888',1,NULL,1,'2016-05-24 23:00:40','2016-05-24 23:00:40'),(14,'TEST555511118888',1,NULL,1,'2016-05-24 23:07:54','2016-05-24 23:07:54'),(15,'TEST555511118888',1,NULL,1,'2016-05-24 23:19:33','2016-05-24 23:19:33'),(16,'TEST555511118888',1,NULL,1,'2016-05-24 23:21:45','2016-05-24 23:21:45'),(17,'TEST555511118888',1,NULL,1,'2016-05-25 00:02:33','2016-05-25 00:02:33'),(18,'TEST555511118888',1,NULL,1,'2016-05-25 00:10:58','2016-05-25 00:10:58'),(19,'TEST555511118888',1,NULL,1,'2016-05-25 00:13:45','2016-05-25 00:13:45'),(20,'TEST555511118888',1,NULL,1,'2016-05-25 00:18:29','2016-05-25 00:18:29'),(21,'TEST555511118888',1,NULL,1,'2016-05-25 00:21:46','2016-05-25 00:21:46'),(22,'TEST555511118888',1,NULL,1,'2016-05-25 00:23:21','2016-05-25 00:23:21'),(23,'TEST555511118888',1,NULL,1,'2016-05-25 00:26:09','2016-05-25 00:26:09'),(24,'TEST555511118888',1,NULL,1,'2016-05-25 00:28:29','2016-05-25 00:28:29'),(25,'TEST555511118888',1,NULL,1,'2016-05-25 00:30:28','2016-05-25 00:30:28'),(26,'TEST555511118888',1,NULL,1,'2016-05-25 22:24:33','2016-05-25 22:24:33'),(27,'TEST555511118888',1,NULL,1,'2016-05-25 22:40:43','2016-05-25 22:40:43'),(28,'TEST555511118888',1,NULL,1,'2016-05-25 22:42:41','2016-05-25 22:42:41'),(29,'TEST555511118888',1,NULL,1,'2016-05-25 22:47:04','2016-05-25 22:47:04'),(30,'TEST555511118888',1,NULL,1,'2016-05-25 22:48:14','2016-05-25 22:48:14'),(31,'TEST555511118888',1,NULL,1,'2016-05-25 22:50:53','2016-05-25 22:50:53'),(32,'TEST555511118888',1,NULL,1,'2016-05-25 22:51:28','2016-05-25 22:51:28'),(33,'TEST555511118888',1,NULL,1,'2016-05-25 22:54:39','2016-05-25 22:54:39'),(34,'TEST555511118888',1,NULL,1,'2016-05-25 22:55:23','2016-05-25 22:55:23'),(35,'TEST555511118888',1,NULL,1,'2016-05-25 23:36:38','2016-05-25 23:36:38'),(36,'TEST555511118888',1,NULL,1,'2016-05-25 23:42:45','2016-05-25 23:42:45'),(37,'TEST555511118888',1,NULL,1,'2016-05-25 23:44:35','2016-05-25 23:44:35'),(38,'TEST555511118888',1,NULL,1,'2016-05-25 23:55:27','2016-05-25 23:55:27'),(39,'TEST555511118888',1,NULL,1,'2016-05-26 00:31:23','2016-05-26 00:31:23'),(40,'TEST555511118888',1,NULL,1,'2016-05-26 00:37:47','2016-05-26 00:37:47'),(41,'TEST555511118888',1,NULL,1,'2016-05-26 20:55:00','2016-05-26 20:55:00'),(42,'TEST555511118888',1,NULL,1,'2016-05-26 21:57:34','2016-05-26 21:57:34'),(43,'TEST555511118888',1,NULL,1,'2016-05-26 21:58:24','2016-05-26 21:58:24'),(44,'TEST555511118888',1,NULL,1,'2016-05-26 22:00:05','2016-05-26 22:00:05'),(45,'TEST555511118888',1,NULL,1,'2016-05-26 22:05:39','2016-05-26 22:05:39'),(46,'TEST555511118888',1,NULL,1,'2016-05-26 22:08:11','2016-05-26 22:08:11'),(47,'TEST555511118888',1,NULL,1,'2016-05-26 22:11:34','2016-05-26 22:11:34'),(48,'TEST555511118888',1,NULL,1,'2016-05-26 22:26:39','2016-05-26 22:26:39'),(49,'TEST555511118888',1,NULL,1,'2016-05-26 23:05:22','2016-05-26 23:05:22'),(50,'TEST555511118888',1,NULL,1,'2016-05-26 23:08:15','2016-05-26 23:08:15'),(51,'TEST555511118888',1,'1shq4r9r',1,'2016-05-26 23:11:43','2016-05-26 23:11:43'),(52,'TEST555511118888',1,'1huqhg2j',1,'2016-05-26 23:13:23','2016-05-26 23:13:23'),(53,'TEST555511118888',1,'15l40aqq',1,'2016-05-26 23:16:35','2016-05-26 23:16:35'),(54,'TEST555511118888',1,'18makf0k',1,'2016-05-26 23:19:04','2016-05-26 23:19:04'),(55,'TEST555511118888',1,'18makf0k',2,'2016-05-26 23:19:55','2016-05-26 23:19:55'),(56,'TEST555511118888',1,NULL,1,'2016-05-27 00:23:29','2016-05-27 00:23:29'),(57,'TEST555511118888',1,NULL,1,'2016-05-27 00:57:48','2016-05-27 00:57:48'),(58,'TEST555511118888',1,NULL,1,'2016-05-27 00:58:38','2016-05-27 00:58:38'),(59,'TEST555511118888',1,NULL,1,'2016-05-27 01:03:15','2016-05-27 01:03:15'),(60,'TEST555511118888',1,NULL,1,'2016-05-27 01:04:44','2016-05-27 01:04:44'),(61,'TEST555511118888',1,'1kj91qir',1,'2016-05-27 20:38:01','2016-05-27 20:38:01'),(62,'TEST555511118888',1,'1kj91qir',2,'2016-05-27 20:43:18','2016-05-27 20:43:18'),(63,'TEST555511118888',1,'16j0pxfq',1,'2016-05-27 21:39:19','2016-05-27 21:39:19'),(64,'TEST555511118888',1,'1mw1m30p',1,'2016-05-27 21:43:58','2016-05-27 21:43:58'),(65,'TEST555511118888',1,'1pmm8byo',1,'2016-05-27 21:45:49','2016-05-27 21:45:49'),(66,'TEST555511118888',1,'1pxlziu8',1,'2016-05-27 21:46:37','2016-05-27 21:46:37'),(67,'TEST555511118888',1,'1ajx4u5f',1,'2016-05-27 21:47:04','2016-05-27 21:47:04'),(68,'TEST555511118888',1,'130x3a16',1,'2016-05-27 22:38:58','2016-05-27 22:38:58'),(69,'TEST555511118888',1,NULL,1,'2016-05-27 23:22:55','2016-05-27 23:22:55'),(70,'TEST555511118888',1,NULL,1,'2016-05-27 23:37:03','2016-05-27 23:37:03'),(71,'TEST555511118888',1,'1rychfz8',1,'2016-05-28 09:31:33','2016-05-28 09:31:33'),(72,'TEST555511118888',1,NULL,1,'2016-05-28 09:47:25','2016-05-28 09:47:25'),(73,'TEST555511118888',1,'158c2b3w',1,'2016-05-28 09:47:58','2016-05-28 09:47:58'),(74,'TEST555511118888',1,'1s3rm9ph',1,'2016-05-28 09:59:36','2016-05-28 09:59:36'),(75,'TEST555511118888',1,'1l36yrsc',1,'2016-05-28 10:00:06','2016-05-28 10:00:06'),(76,'TEST555511118888',1,'11c8f9s0',1,'2016-05-28 10:00:30','2016-05-28 10:00:30'),(77,'TEST555511118888',1,'158c2b3w',2,'2016-05-28 10:19:39','2016-05-28 10:19:39'),(78,'TEST555511118888',1,'1rychfz8',2,'2016-05-28 10:24:12','2016-05-28 10:24:12'),(79,'TEST555511118888',1,'11bqpsau',1,'2016-05-28 10:26:54','2016-05-28 10:26:54'),(80,'TEST555511118888',1,'1rlaoigy',1,'2016-05-28 10:27:55','2016-05-28 10:27:55'),(81,'TEST555511118888',1,'1wpkiax3',1,'2016-05-28 10:28:18','2016-05-28 10:28:18'),(82,'TEST555511118888',1,'1didhkh3',1,'2016-05-28 10:28:42','2016-05-28 10:28:42'),(83,'TEST555511118888',1,'1jcuzyda',1,'2016-05-28 10:29:04','2016-05-28 10:29:04'),(84,'TEST555511118888',1,'1o6vsg1m',1,'2016-05-28 10:29:48','2016-05-28 10:29:48'),(85,'TEST555511118888',1,'1ts2t8th',1,'2016-05-28 11:28:56','2016-05-28 11:28:56'),(86,'TEST555511118888',1,'1ts2t8th',2,'2016-05-28 11:29:16','2016-05-28 11:29:16'),(87,'TEST555511118888',1,'1wf1etea',1,'2016-05-28 16:36:48','2016-05-28 16:36:48'),(88,'TEST555511118888',1,NULL,1,'2016-05-28 17:06:02','2016-05-28 17:06:02'),(89,'TEST555511118888',1,NULL,1,'2016-05-28 17:08:42','2016-05-28 17:08:42'),(90,'TEST555511118888',1,NULL,1,'2016-05-28 17:10:33','2016-05-28 17:10:33'),(91,'TEST555511118888',1,'1f8qfrax',1,'2016-05-28 17:21:56','2016-05-28 17:21:56');
/*!40000 ALTER TABLE `operation_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;
/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'huozhanbai'),(2,'wendy'),(3,'asdf'),(4,'gasd'),(5,''),(6,''),(7,'');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-07 22:50:12
