-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: courtease
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `case_applications`
--

DROP TABLE IF EXISTS `case_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_applications` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `application_title` varchar(200) NOT NULL,
  `case_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `application_status` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `reviewed_by` int DEFAULT NULL,
  `case_id` int DEFAULT NULL,
  PRIMARY KEY (`application_id`),
  KEY `fk_application_client` (`client_id`),
  KEY `fk_application_reviewer` (`reviewed_by`),
  KEY `fk_application_case` (`case_id`),
  CONSTRAINT `fk_application_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  CONSTRAINT `fk_application_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `fk_application_reviewer` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_applications`
--

LOCK TABLES `case_applications` WRITE;
/*!40000 ALTER TABLE `case_applications` DISABLE KEYS */;
INSERT INTO `case_applications` VALUES (1,11,'encroachment dispute','Civil','A person is trying to acquire my land illegally.','Approved','2026-10-25 18:20:18','2026-10-25 19:01:18',2,NULL),(2,11,'Defective Electronic Product Complaint','Consumer','An electronic product stopped functioning during the warranty period and that the seller has not resolved the complaint.','Approved','2026-10-25 19:13:02','2026-10-25 19:13:24',2,12),(3,11,'Robbery','Criminal','A person tried to steal our chains and bangles.','Approved','2026-10-26 05:44:46','2026-10-26 05:45:31',2,13),(4,11,'Unpaid Salary Complaint','Civil','An employee seeks payment of outstanding salary and other contractual dues.','Approved','2026-10-26 08:59:02','2026-10-26 09:00:30',2,14),(5,11,'rent dispute','Civil','a client is having dispute in rent agreemnt','Approved','2026-10-28 07:27:03','2026-10-28 07:27:37',2,15);
/*!40000 ALTER TABLE `case_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_audit_log`
--

DROP TABLE IF EXISTS `case_audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_audit_log` (
  `audit_id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `changed_by` int DEFAULT NULL,
  `field_name` varchar(100) NOT NULL,
  `old_value` text,
  `new_value` text,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`),
  KEY `fk_audit_case` (`case_id`),
  KEY `fk_audit_user` (`changed_by`),
  CONSTRAINT `fk_audit_case` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  CONSTRAINT `fk_audit_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_audit_log`
--

LOCK TABLES `case_audit_log` WRITE;
/*!40000 ALTER TABLE `case_audit_log` DISABLE KEYS */;
INSERT INTO `case_audit_log` VALUES (1,12,2,'status','Pending','In Progress','2026-10-25 20:05:23'),(2,11,2,'status','In Progress','Closed','2026-10-25 20:05:41'),(3,11,2,'lawyer_id','3','2','2026-10-25 20:05:41'),(4,11,2,'judge_id','4','1','2026-10-25 20:05:41'),(5,12,2,'judge_id',NULL,'4','2026-10-25 20:08:08'),(6,12,2,'lawyer_id','1','2','2026-10-25 20:09:36'),(10,13,2,'judge_id',NULL,'3','2026-10-26 05:49:02'),(11,14,2,'status','Pending','In Progress','2026-10-26 09:01:14'),(12,14,2,'lawyer_id','1','2','2026-10-26 09:01:14'),(13,14,2,'judge_id',NULL,'3','2026-10-26 09:01:14'),(14,15,2,'status','Pending','In Progress','2026-10-28 07:28:21'),(15,15,2,'judge_id',NULL,'5','2026-10-28 07:28:21');
/*!40000 ALTER TABLE `case_audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_events`
--

DROP TABLE IF EXISTS `case_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `event_date` date NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `case_events_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_events`
--

LOCK TABLES `case_events` WRITE;
/*!40000 ALTER TABLE `case_events` DISABLE KEYS */;
INSERT INTO `case_events` VALUES (1,1,'2026-01-15','Filed','Case registered in demo system'),(2,1,'2026-01-20','Document','Initial documents recorded'),(3,1,'2026-02-10','Hearing','Initial hearing recorded'),(4,2,'2026-02-10','Filed','Case registered in demo system'),(5,2,'2026-02-18','Document','Contract documents recorded'),(6,2,'2026-03-15','Hearing','Initial hearing recorded'),(7,3,'2026-03-05','Filed','Case registered in demo system'),(8,3,'2026-03-20','Hearing','Settlement discussion recorded'),(9,3,'2026-04-12','Closed','Demo matter marked closed'),(10,4,'2026-03-18','Filed','Case registered in demo system'),(11,4,'2026-03-25','Document','Business agreement recorded'),(12,4,'2026-04-05','Hearing','Initial hearing recorded'),(13,5,'2026-04-02','Filed','Case registered in demo system'),(14,5,'2026-04-10','Document','Rental agreement recorded'),(15,5,'2026-05-10','Hearing','Initial hearing recorded'),(16,6,'2026-04-20','Filed','Case registered in demo system'),(17,6,'2026-04-28','Document','Complaint documents recorded'),(18,6,'2026-05-20','Hearing','Complaint reviewed'),(19,7,'2026-05-11','Filed','Case registered in demo system'),(20,7,'2026-05-20','Document','Inheritance documents recorded'),(21,7,'2026-06-15','Hearing','Initial hearing recorded'),(22,8,'2026-06-07','Filed','Case registered in demo system'),(23,8,'2026-06-15','Document','Employment agreement recorded'),(24,8,'2026-07-15','Closed','Demo matter marked closed'),(25,9,'2026-07-14','Filed','Case registered in demo system'),(26,9,'2026-07-20','Document','Payment records recorded'),(27,9,'2026-08-10','Hearing','Initial hearing recorded'),(28,10,'2026-08-01','Filed','Case registered in demo system'),(29,10,'2026-08-12','Document','Supporting documents recorded'),(30,10,'2026-09-05','Hearing','Initial hearing recorded');
/*!40000 ALTER TABLE `case_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases`
--

DROP TABLE IF EXISTS `cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases` (
  `case_id` int NOT NULL AUTO_INCREMENT,
  `case_number` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `case_type` varchar(50) NOT NULL,
  `client_id` int NOT NULL,
  `lawyer_id` int NOT NULL,
  `judge_id` int DEFAULT NULL,
  `filing_date` date NOT NULL,
  `status` enum('Pending','In Progress','Closed') NOT NULL DEFAULT 'Pending',
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`case_id`),
  UNIQUE KEY `case_number` (`case_number`),
  KEY `client_id` (`client_id`),
  KEY `lawyer_id` (`lawyer_id`),
  KEY `judge_id` (`judge_id`),
  CONSTRAINT `cases_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `cases_ibfk_2` FOREIGN KEY (`lawyer_id`) REFERENCES `lawyers` (`lawyer_id`),
  CONSTRAINT `cases_ibfk_3` FOREIGN KEY (`judge_id`) REFERENCES `judges` (`judge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases`
--

LOCK TABLES `cases` WRITE;
/*!40000 ALTER TABLE `cases` DISABLE KEYS */;
INSERT INTO `cases` VALUES (1,'DEMO-2026-001','Property Boundary Dispute','Civil',1,5,1,'2026-01-15','In Progress','Fictional property boundary dispute for demonstration.','2026-10-22 08:30:47'),(2,'DEMO-2026-002','Contract Payment Dispute','Civil',2,4,2,'2026-02-10','Pending','Fictional contract payment matter.','2026-10-22 08:30:47'),(3,'DEMO-2026-003','Family Settlement Matter','Family',3,3,1,'2026-03-05','Closed','Fictional family settlement matter.','2026-10-22 08:30:47'),(4,'DEMO-2026-004','Business Agreement Dispute','Corporate',4,4,4,'2026-03-18','In Progress','Fictional business agreement dispute.','2026-10-22 08:30:47'),(5,'DEMO-2026-005','Rental Agreement Dispute','Civil',5,1,3,'2026-04-02','Pending','Fictional rental agreement matter.','2026-10-22 08:30:47'),(6,'DEMO-2026-006','Consumer Service Complaint','Consumer',6,2,2,'2026-04-20','In Progress','Fictional consumer service complaint.','2026-10-22 08:30:47'),(7,'DEMO-2026-007','Inheritance Property Matter','Property',7,5,3,'2026-05-11','Pending','Fictional inheritance property matter.','2026-10-22 08:30:47'),(8,'DEMO-2026-008','Employment Contract Dispute','Civil',8,1,4,'2026-06-07','Closed','Fictional employment contract dispute.','2026-10-22 08:30:47'),(9,'DEMO-2026-009','Cheque Payment Dispute','Civil',9,2,1,'2026-07-14','In Progress','Fictional cheque payment dispute.','2026-10-22 08:30:47'),(10,'DEMO-2026-010','Family Maintenance Matter','Family',10,3,2,'2026-08-01','Pending','Fictional family maintenance matter.','2026-10-22 08:30:47'),(11,'DEMO-2026-011','Property Boundary Dispute','Civil',11,2,1,'2026-10-25','Closed','Fictional demonstration case for testing CourtEase assignments.','2026-10-25 17:11:22'),(12,'CE-000002','Defective Electronic Product Complaint','Consumer',11,2,4,'2026-10-26','In Progress','An electronic product stopped functioning during the warranty period and that the seller has not resolved the complaint.','2026-10-25 19:13:24'),(13,'CE-000003','Robbery','Criminal',11,1,3,'2026-10-26','Pending','A person tried to steal our chains and bangles.','2026-10-26 05:45:31'),(14,'CE-000004','Unpaid Salary Complaint','Civil',11,2,3,'2026-10-26','In Progress','An employee seeks payment of outstanding salary and other contractual dues.','2026-10-26 09:00:30'),(15,'CE-000005','rent dispute','Civil',11,1,5,'2026-10-28','In Progress','a client is having dispute in rent agreemnt','2026-10-28 07:27:37');
/*!40000 ALTER TABLE `cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Aarav Sharma','9000000001','aarav@example.com','Pune, Maharashtra'),(2,'Priya Patil','9000000002','priya@example.com','Mumbai, Maharashtra'),(3,'Rohan Deshmukh','9000000003','rohan@example.com','Nashik, Maharashtra'),(4,'Ananya Kulkarni','9000000004','ananya@example.com','Nagpur, Maharashtra'),(5,'Ishaan Joshi','9000000005','ishaan@example.com','Kolhapur, Maharashtra'),(6,'Meera Shah','9000000006','meera@example.com','Thane, Maharashtra'),(7,'Kabir More','9000000007','kabir@example.com','Satara, Maharashtra'),(8,'Sana Khan','9000000008','sana@example.com','Aurangabad, Maharashtra'),(9,'Aditya Pawar','9000000009','aditya@example.com','Solapur, Maharashtra'),(10,'Kavya Rao','9000000010','kavya@example.com','Pune, Maharashtra'),(11,'Chaitanya Valekar','08010682501','valekarchaitanya@gmail.com','');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hearings`
--

DROP TABLE IF EXISTS `hearings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hearings` (
  `hearing_id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `hearing_date` date NOT NULL,
  `hearing_time` time DEFAULT NULL,
  `court_room` varchar(50) DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`hearing_id`),
  KEY `case_id` (`case_id`),
  CONSTRAINT `hearings_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hearings`
--

LOCK TABLES `hearings` WRITE;
/*!40000 ALTER TABLE `hearings` DISABLE KEYS */;
INSERT INTO `hearings` VALUES (1,1,'2026-02-10','10:00:00','Room 101','Initial hearing'),(2,1,'2026-11-05','10:30:00','Room 101','Arguments scheduled'),(3,2,'2026-03-15','11:00:00','Room 202','Initial hearing'),(4,2,'2026-11-08','11:00:00','Room 202','Documents to be reviewed'),(5,3,'2026-03-20','12:00:00','Room 101','Settlement discussion'),(6,3,'2026-04-12','12:00:00','Room 101','Demo matter concluded'),(7,4,'2026-04-05','10:30:00','Room 304','Initial hearing'),(8,4,'2026-11-12','11:30:00','Room 304','Arguments scheduled'),(9,5,'2026-05-10','10:00:00','Room 105','Initial hearing'),(10,5,'2026-11-15','10:00:00','Room 105','Further proceedings'),(11,6,'2026-05-20','11:00:00','Room 202','Complaint reviewed'),(12,6,'2026-11-18','11:00:00','Room 202','Next hearing'),(13,7,'2026-06-15','12:00:00','Room 205','Initial hearing'),(14,7,'2026-11-20','12:00:00','Room 205','Evidence review'),(15,8,'2026-06-25','10:30:00','Room 304','Demo hearing'),(16,8,'2026-07-15','10:30:00','Room 304','Demo matter concluded'),(17,9,'2026-08-10','11:00:00','Room 101','Initial hearing'),(18,9,'2026-11-25','11:00:00','Room 101','Arguments scheduled'),(19,10,'2026-09-05','12:00:00','Room 202','Initial hearing'),(20,10,'2026-11-28','12:00:00','Room 202','Further proceedings'),(22,11,'2026-10-29','09:29:00','Courtroom 201','Demo hearing — preliminary proceedings.'),(23,12,'2026-11-04','13:36:00','room 305',NULL),(24,13,'2026-11-05','04:20:00','room 106',NULL),(25,14,'2026-10-30','11:39:00','room 501',NULL),(26,15,'2026-10-29','17:02:00','room 305',NULL);
/*!40000 ALTER TABLE `hearings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `judges`
--

DROP TABLE IF EXISTS `judges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `judges` (
  `judge_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `court_name` varchar(150) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`judge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `judges`
--

LOCK TABLES `judges` WRITE;
/*!40000 ALTER TABLE `judges` DISABLE KEYS */;
INSERT INTO `judges` VALUES (1,'Justice Ananya Rao','Pune Demo Court','District Judge'),(2,'Justice Vikram Shah','Mumbai Demo Court','Civil Judge'),(3,'Justice Meera Nair','Nashik Demo Court','District Judge'),(4,'Justice Arjun Mehta','Nagpur Demo Court','Senior Civil Judge'),(5,'Abhaya','Pune district court','criminal judge');
/*!40000 ALTER TABLE `judges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lawyers`
--

DROP TABLE IF EXISTS `lawyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lawyers` (
  `lawyer_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`lawyer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lawyers`
--

LOCK TABLES `lawyers` WRITE;
/*!40000 ALTER TABLE `lawyers` DISABLE KEYS */;
INSERT INTO `lawyers` VALUES (1,'Adv. Neha Kulkarni','9100000001','neha.law@example.com','Civil Law'),(2,'Adv. Rahul Joshi','9100000002','rahul.law@example.com','Criminal Law'),(3,'Adv. Sneha More','9100000003','sneha.law@example.com','Family Law'),(4,'Adv. Amit Desai','9100000004','amit.law@example.com','Corporate Law'),(5,'Adv. Pooja Shah','9100000005','pooja.law@example.com','Property Law'),(6,'Gauri','100000011','Gauri@example.com','Civil Law');
/*!40000 ALTER TABLE `lawyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','staff','viewer','client','lawyer','judge') NOT NULL DEFAULT 'client',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `account_status` enum('active','disabled') NOT NULL DEFAULT 'active',
  `client_id` int DEFAULT NULL,
  `lawyer_id` int DEFAULT NULL,
  `judge_id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Chaitanya Valekar','scrypt:32768:8:1$s6OUe02tt4xYQCWG$7ed46d904e9b5dbc59b9dd1675757109dd8e3d927225279a78bf5ee91e5340cdbc0f2d319ae002af5653a058d2202e771ba8f2dd00ccac172f39033cb43d65c2','client','2026-10-23 19:59:05','active',11,NULL,NULL),(2,'Chaitanya','scrypt:32768:8:1$EKFA05SRdFozt70z$07460594dcf6a5f4fcec42cbc2037154be837502c3c7d5ef972f5223314e14187320ca585ea7feb60b0f9b55f026736f6fc5953d215e1d5f9b79b19d509abf1e','admin','2026-10-25 16:25:18','active',NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-31  0:13:19
