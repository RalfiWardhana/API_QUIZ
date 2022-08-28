-- MariaDB dump 10.19  Distrib 10.8.3-MariaDB, for osx10.17 (arm64)
--
-- Host: localhost    Database: course2
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exercise_id` int NOT NULL,
  `question_id` int NOT NULL,
  `user_id` int NOT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `answers_user_id_IDX` (`user_id`,`question_id`) USING BTREE,
  KEY `answers_FK` (`exercise_id`),
  KEY `answers_FK_1` (`question_id`),
  CONSTRAINT `answers_FK` FOREIGN KEY (`exercise_id`) REFERENCES `exercises` (`id`),
  CONSTRAINT `answers_FK_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  CONSTRAINT `answers_FK_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES
(1,1,1,3,'b','2022-06-17 12:55:44','2022-06-17 12:55:44'),
(2,1,2,3,'c','2022-06-17 12:55:44','2022-06-17 12:55:44'),
(3,1,3,3,'a','2022-06-17 12:55:44','2022-06-17 12:55:44'),
(4,1,4,3,'c','2022-06-17 12:55:44','2022-06-17 12:55:44'),
(5,1,5,3,'d','2022-06-17 12:55:44','2022-06-17 12:55:44'),
(6,1,6,3,'b','2022-06-17 12:55:44','2022-06-17 12:55:44'),
(7,1,7,3,'d','2022-06-17 13:01:35','2022-06-17 13:01:35'),
(8,1,8,3,'c','2022-06-17 13:01:35','2022-06-17 13:01:35'),
(9,1,9,3,'b','2022-06-17 13:01:35','2022-06-17 13:01:35'),
(10,1,10,3,'b','2022-06-17 13:01:35','2022-06-17 13:01:35');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exercises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercises`
--

LOCK TABLES `exercises` WRITE;
/*!40000 ALTER TABLE `exercises` DISABLE KEYS */;
INSERT INTO `exercises` VALUES
(1,'Olimpiade Matematika SMA','Olimpiade Matematika tingkat SMA Jawa Timur 2099');
/*!40000 ALTER TABLE `exercises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exercise_id` int NOT NULL,
  `body` text NOT NULL,
  `option_a` text NOT NULL,
  `option_b` text NOT NULL,
  `option_c` text NOT NULL,
  `option_d` text NOT NULL,
  `correct_answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `score` int NOT NULL,
  `creator_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `questions_FK` (`exercise_id`),
  KEY `questions_FK_1` (`creator_id`),
  CONSTRAINT `questions_FK` FOREIGN KEY (`exercise_id`) REFERENCES `exercises` (`id`),
  CONSTRAINT `questions_FK_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES
(1,1,'Berapa Jumlah hasil dari 1 + 1?','0.2','2','2.2','22','b',10,1,'2022-06-15 14:01:08','2022-06-15 14:01:08'),
(2,1,'Berapa Jumlah hasil dari 2 + 2?','4','4.4','44','0.4','a',10,1,'2022-06-15 14:01:08','2022-06-15 14:01:08'),
(3,1,'Berapa Jumlah hasil dari 1 x 1?','0.1','1','1.1','11','b',10,1,'2022-06-15 14:09:22','2022-06-15 14:09:22'),
(4,1,'Berapa Jumlah hasil dari 3 x 3?','999','9','9.9','99','b',10,1,'2022-06-15 14:09:50','2022-06-15 14:09:50'),
(5,1,'Berapa hasil dari 2 + 3?','0.5','0.55','-5','5','d',10,1,'2022-06-15 14:11:13','2022-06-15 14:11:13'),
(6,1,'Berapa hasil dari 23 x 0.1?','0.1','0.23','23','2.3','d',10,1,'2022-06-15 14:12:07','2022-06-15 14:12:07'),
(7,1,'Jika 3 - 2 = 1, berapakah hasil dari 3 + 1?','4','5','6','7','a',10,1,'2022-06-15 14:15:16','2022-06-15 14:15:16'),
(8,1,'Jika 2 + 2 = 4, berapakah hasil dari 3 + 3?','23','33','6','5','c',10,1,'2022-06-15 14:15:43','2022-06-15 14:15:43'),
(9,1,'Jika 10 + 1 = 11, berapakah hasil dari 30 x 1?','31','13','4','30','d',10,1,'2022-06-15 14:15:47','2022-06-15 14:15:47'),
(10,1,'Berapa hasil dari 9 + 3?','11','12','13','14','b',10,1,'2022-06-15 14:15:50','2022-06-15 14:15:50');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `no_hp` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'super admin','admin@gmail.com','ini password','08171122233333','2022-06-15 13:02:09','2022-06-15 13:02:09'),
(2,'ahsan','ahsan@mail.com','$2a$10$mM7/GAbcxBE1.Z2ALg83puE3Vcqn75UlAEexxa/xbIaQCmjb8PKoa','','2022-06-15 23:45:44','2022-06-15 23:45:44'),
(3,'ahsan','ahsan2@mail.com','$2a$10$UOJAFVPbm4QtObtejd0fy.RduB5brNCqGx4Kv10XpAVxmYIhOT9Vi','','2022-06-16 19:21:49','2022-06-16 19:21:49');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'course2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-17 20:21:19
