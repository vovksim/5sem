/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: GameService
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Achievment`
--

DROP TABLE IF EXISTS `Achievment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Achievment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` blob NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `Achievment_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Achievment`
--

LOCK TABLES `Achievment` WRITE;
/*!40000 ALTER TABLE `Achievment` DISABLE KEYS */;
/*!40000 ALTER TABLE `Character` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CharacterRole`
--

DROP TABLE IF EXISTS `CharacterRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CharacterRole` (
  `game_id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `role_level` enum('Antagonist','Protagonist','Deutragonist','Supporting','Minor') DEFAULT NULL,
  `history` text NOT NULL,
  PRIMARY KEY (`game_id`,`character_id`),
  KEY `character_id` (`character_id`),
  CONSTRAINT `CharacterRole_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`),
  CONSTRAINT `CharacterRole_ibfk_2` FOREIGN KEY (`character_id`) REFERENCES `Character` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CharacterRole`
--

LOCK TABLES `CharacterRole` WRITE;
/*!40000 ALTER TABLE `CharacterRole` DISABLE KEYS */;
/*!40000 ALTER TABLE `CharacterRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CompanyManager`
--

DROP TABLE IF EXISTS `CompanyManager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CompanyManager` (
  `full_name` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CompanyManager`
--

LOCK TABLES `CompanyManager` WRITE;
/*!40000 ALTER TABLE `CompanyManager` DISABLE KEYS */;
/*!40000 ALTER TABLE `Game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GameAward`
--

DROP TABLE IF EXISTS `GameAward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GameAward` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `award_year` year(4) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `GameAward_index_1` (`name`,`award_year`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `GameAward_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GameAward`
--

LOCK TABLES `GameAward` WRITE;
/*!40000 ALTER TABLE `GameAward` DISABLE KEYS */;
/*!40000 ALTER TABLE `Genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Genre_Game`
--

DROP TABLE IF EXISTS `Genre_Game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Genre_Game` (
  `game_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`game_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `Genre_Game_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`),
  CONSTRAINT `Genre_Game_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Genre_Game`
--

LOCK TABLES `Genre_Game` WRITE;
/*!40000 ALTER TABLE `Genre_Game` DISABLE KEYS */;
/*!40000 ALTER TABLE `Genre_Game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Guide`
--

DROP TABLE IF EXISTS `Guide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Guide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  `last_updated_by` varchar(50) DEFAULT NULL,
  `last_updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `Guide_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Guide`
--

LOCK TABLES `Guide` WRITE;
/*!40000 ALTER TABLE `Guide` DISABLE KEYS */;
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `is_marketable` tinyint(1) DEFAULT NULL,
  `is_tradable` tinyint(1) DEFAULT NULL,
  `is_social` tinyint(1) DEFAULT NULL,
  `game_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `Item_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
/*!40000 ALTER TABLE `Language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Library`
--

DROP TABLE IF EXISTS `Library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Library` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `owned_since` timestamp NOT NULL,
  `hours_played` decimal(5,1) DEFAULT 0.0,
  `is_refunded` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`game_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `Library_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
  CONSTRAINT `Library_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Library`
--

LOCK TABLES `Library` WRITE;
/*!40000 ALTER TABLE `Library` DISABLE KEYS */;
INSERT INTO `Library` VALUES
(1,1,'2024-09-11 10:31:24',0.0,0);
/*!40000 ALTER TABLE `Library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Localization`
--

DROP TABLE IF EXISTS `Localization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Localization` (
  `game_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `audio` tinyint(1) DEFAULT NULL,
  `interface` tinyint(1) DEFAULT NULL,
  `subtitles` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`game_id`,`language_id`),
  UNIQUE KEY `Localization_index_0` (`game_id`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `Localization_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`id`),
  CONSTRAINT `Localization_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `Language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Localization`
--

LOCK TABLES `Localization` WRITE;
/*!40000 ALTER TABLE `Localization` DISABLE KEYS */;
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Studio`
--

DROP TABLE IF EXISTS `Studio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Studio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(25) DEFAULT NULL,
  `founded` year(4) DEFAULT NULL,
  `avatar` blob DEFAULT NULL,
  `is_deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Studio`
--

LOCK TABLES `Studio` WRITE;
/*!40000 ALTER TABLE `Studio` DISABLE KEYS */;
INSERT INTO `Studio` VALUES
(1,'CD PROJECT','Witcher','Poland',2000,NULL,NULL);
/*!40000 ALTER TABLE `SupportRequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `username` varchar(50) NOT NULL,
  `born` date NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
('vovksim','2000-01-01','xmpl@gmail.com',1);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Achievment`
--

DROP TABLE IF EXISTS `User_Achievment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User_Achievment` (
  `user_id` int(11) NOT NULL,
  `achievment_id` int(11) NOT NULL,
  `is_achieved` tinyint(1) DEFAULT 0,
  `achieve_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`achievment_id`),
  KEY `achievment_id` (`achievment_id`),
  CONSTRAINT `User_Achievment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
  CONSTRAINT `User_Achievment_ibfk_2` FOREIGN KEY (`achievment_id`) REFERENCES `Achievment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Achievment`
--

LOCK TABLES `User_Achievment` WRITE;
/*!40000 ALTER TABLE `User_Achievment` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_Guide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Review`
--

DROP TABLE IF EXISTS `User_Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User_Review` (
  `user_id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `publish_date` timestamp NOT NULL,
  `view_mode` enum('Private','Public','Friends') DEFAULT NULL,
  PRIMARY KEY (`user_id`,`review_id`),
  KEY `review_id` (`review_id`),
  CONSTRAINT `User_Review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
  CONSTRAINT `User_Review_ibfk_2` FOREIGN KEY (`review_id`) REFERENCES `Review` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Review`
--

LOCK TABLES `User_Review` WRITE;
/*!40000 ALTER TABLE `User_Review` DISABLE KEYS */;
/*!40000 ALTER TABLE `User_User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'GameService'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_inventory_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_inventory_price`(IN _user_id int) RETURNS decimal(10,2)
BEGIN
	DECLARE res decimal(10,2) DEFAULT 0.00;
	SELECT SUM(price) into res FROM Item 
	WHERE id IN 
		(SELECT item_id FROM Inventory
			WHERE user_id = _user_id);
	RETURN res;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_played_hours` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_played_hours`(_user_id int, _game_id INT) RETURNS decimal(5,1)
BEGIN
	DECLARE hours decimal(5,1) DEFAULT -1;
	SELECT hours_played 
	INTO hours
	FROM Library
	WHERE _user_id = user_id and _game_id = game_id;
	RETURN hours;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `make_refund` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_refund`(
    IN _user_id INT,
    IN _game_id INT
)
proc_label:BEGIN
    IF get_played_hours(_user_id, _game_id) > 2 OR get_played_hours(_user_id, _game_id) < 0 THEN 
        SELECT 'Refund unavailable! Contact support.' AS message;
        LEAVE proc_label;
    END IF;

    UPDATE Library
    SET is_refunded = TRUE
    WHERE user_id = _user_id AND game_id = _game_id;
    
    SELECT 'Refund successful!' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `purchase_game` */;
/*!50003 SET @saved_cs_client      = @@characte/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-09-16  8:49:38
