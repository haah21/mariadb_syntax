-- MariaDB dump 10.19-11.3.2-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5559 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(8,'hongildong','hello@naver2.com',NULL,NULL,23,NULL,'user','2024-05-17',NULL,0),
(9,'홍길동','ddc@naver.com',NULL,NULL,20,NULL,'user','2024-05-17',NULL,0),
(10,'홍길동','dde@naver.com',NULL,NULL,19,NULL,'user','2024-05-17',NULL,0),
(11,'홍길동','ffff@naver.com',NULL,NULL,18,NULL,'user','2024-05-17',NULL,0),
(12,'test12','dddgq@naver.com',NULL,NULL,21,NULL,'user','2024-05-17',NULL,0),
(14,'test14','test@test.com',NULL,NULL,22,NULL,'user','2024-05-17',NULL,0),
(15,'test15','test15@test.com',NULL,NULL,23,NULL,'admin','2024-05-17',NULL,0),
(16,'test16','test16@test.com',NULL,NULL,24,NULL,'admin','2024-05-17',NULL,0),
(17,'test17','test17@test.com',NULL,NULL,25,NULL,'user','1999-04-21',NULL,0),
(18,'test18','test18@test.com',NULL,NULL,26,NULL,'user','2000-12-01',NULL,0),
(19,'test19','test19@test.com',NULL,NULL,25,NULL,'user','2024-05-17',NULL,0),
(20,'test20','test20@naver.com',NULL,NULL,24,NULL,'user',NULL,NULL,0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'title1',NULL,8,3000.000,'2024-05-21 07:05:22','87487719-173f-11ef-87fd-0242ac110002'),
(2,'title2',NULL,9,1000.000,'2024-05-21 07:06:48','baa1806e-173f-11ef-87fd-0242ac110002'),
(3,'title3',NULL,10,2000.000,'2024-05-21 07:06:51','bbf22e0a-173f-11ef-87fd-0242ac110002'),
(4,'title4',NULL,11,1500.000,'2024-05-21 07:06:51','bc0ca27a-173f-11ef-87fd-0242ac110002'),
(5,'title5',NULL,12,4500.000,'2024-05-21 07:06:51','bc2772a2-173f-11ef-87fd-0242ac110002'),
(6,'title6',NULL,8,3600.000,'2024-05-21 07:06:51','bc40efc2-173f-11ef-87fd-0242ac110002'),
(7,'title7',NULL,14,4400.000,'2024-05-21 07:06:51','bc585fa2-173f-11ef-87fd-0242ac110002'),
(8,'title8',NULL,8,12000.000,'2024-05-21 07:06:51','bc726e80-173f-11ef-87fd-0242ac110002'),
(9,'title9',NULL,9,1400.000,'2024-05-21 07:06:52','bc8d98f7-173f-11ef-87fd-0242ac110002'),
(10,'title10',NULL,10,800.000,'2024-05-21 07:06:52','bcb4ca74-173f-11ef-87fd-0242ac110002'),
(11,'title11',NULL,11,1200.000,'2024-05-21 07:06:52','bcd1a4d5-173f-11ef-87fd-0242ac110002'),
(12,'title12',NULL,12,24400.000,'2024-05-21 07:06:52','bce7d00f-173f-11ef-87fd-0242ac110002'),
(13,'title13',NULL,8,43600.000,'2024-05-21 07:06:52','bcfd17c3-173f-11ef-87fd-0242ac110002'),
(14,'title14',NULL,8,2400.000,'2024-05-21 07:06:52','bd118da9-173f-11ef-87fd-0242ac110002'),
(15,'title15',NULL,8,4600.000,'2024-05-21 07:06:53','bd2630d5-173f-11ef-87fd-0242ac110002'),
(16,'title16',NULL,15,5000.000,'2024-05-21 07:06:53','bd3c8758-173f-11ef-87fd-0242ac110002'),
(17,'title17',NULL,8,1000.000,'2024-05-21 07:06:53','bd4ec37e-173f-11ef-87fd-0242ac110002'),
(18,'title18',NULL,9,4000.000,'2024-05-21 07:06:53','f310a1a0-1740-11ef-87fd-0242ac110002');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22  7:39:55
