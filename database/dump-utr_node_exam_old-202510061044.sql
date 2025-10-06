-- MySQL dump 10.13  Distrib 8.0.42, for macos15.2 (arm64)
--
-- Host: 134.209.154.181    Database: utr_node_exam_old
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.22.04.1

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
-- Table structure for table `aouth`
--

DROP TABLE IF EXISTS `aouth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aouth` (
  `id` int NOT NULL AUTO_INCREMENT,
  `a_master_name` varchar(512) NOT NULL,
  `a_master_password` varchar(40) NOT NULL,
  `a_last_password` varchar(40) DEFAULT NULL,
  `a_added_date` date DEFAULT NULL,
  `a_added_time` varchar(20) DEFAULT NULL,
  `a_time_stamp` varchar(20) DEFAULT NULL,
  `a_valid` int NOT NULL DEFAULT '0',
  `a_code` bigint NOT NULL,
  `a_app_code` int NOT NULL DEFAULT '1',
  `a_center_name` varchar(512) DEFAULT NULL,
  `a_center_address` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aouth`
--

LOCK TABLES `aouth` WRITE;
/*!40000 ALTER TABLE `aouth` DISABLE KEYS */;
INSERT INTO `aouth` VALUES (1,'u','u',NULL,NULL,NULL,NULL,0,101,101,'YSPM\'s Yashoda Technical Campus','S. No. 242/1, V. N. Road, Wadhe, NH-4, Satara, Maharashtra 415015');
/*!40000 ALTER TABLE `aouth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_final_student_question_paper`
--

DROP TABLE IF EXISTS `tm_final_student_question_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_final_student_question_paper` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sqp_question_id` bigint NOT NULL COMMENT 'this is question_paper_list_ table id',
  `sqp_student_id` bigint NOT NULL COMMENT 'student table id',
  `sqp_test_id` bigint NOT NULL,
  `sqp_publish_id` bigint NOT NULL,
  `sqp_is_remark` int NOT NULL DEFAULT '0',
  `sqp_index_value` int DEFAULT NULL,
  `sqp_time` varchar(10) DEFAULT NULL,
  `sqp_ans` varchar(5) DEFAULT NULL,
  `added_time` varchar(10) DEFAULT NULL,
  `sqp_min` int DEFAULT '0',
  `sqp_sec` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sqp_question_id` (`sqp_question_id`),
  KEY `sqp_student_id` (`sqp_student_id`),
  KEY `sqp_test_id` (`sqp_test_id`),
  KEY `sqp_publish_id` (`sqp_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_final_student_question_paper`
--

LOCK TABLES `tm_final_student_question_paper` WRITE;
/*!40000 ALTER TABLE `tm_final_student_question_paper` DISABLE KEYS */;
/*!40000 ALTER TABLE `tm_final_student_question_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_final_student_test_list`
--

DROP TABLE IF EXISTS `tm_final_student_test_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_final_student_test_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stl_test_id` bigint NOT NULL,
  `stl_stud_id` bigint NOT NULL,
  `stl_publish_id` bigint NOT NULL,
  `stl_date` date NOT NULL,
  `stl_test_url` longtext NOT NULL,
  `stl_time` varchar(20) NOT NULL,
  `stl_time_stamp` varchar(20) NOT NULL,
  `stl_test_compliet_in` varchar(20) NOT NULL DEFAULT '0',
  `stl_test_submition_time` varchar(20) DEFAULT NULL,
  `stl_test_status` int NOT NULL DEFAULT '2',
  `stl_agrement_accepted` int NOT NULL DEFAULT '1',
  `stm_min` int DEFAULT NULL,
  `stm_sec` int DEFAULT NULL,
  `stl_browser_info` longtext,
  `stl_user_ip` longtext,
  PRIMARY KEY (`id`),
  KEY `stl_test_id` (`stl_test_id`),
  KEY `stl_stud_id` (`stl_stud_id`),
  KEY `stl_publish_id` (`stl_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_final_student_test_list`
--

LOCK TABLES `tm_final_student_test_list` WRITE;
/*!40000 ALTER TABLE `tm_final_student_test_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `tm_final_student_test_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_publish_test_by_post`
--

DROP TABLE IF EXISTS `tm_publish_test_by_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_publish_test_by_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL COMMENT 'This is post id for which test is published',
  `post_name` varchar(255) NOT NULL COMMENT 'This is the post name.',
  `published_test_id` int NOT NULL COMMENT 'This is published test id.',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_publish_test_by_post`
--

LOCK TABLES `tm_publish_test_by_post` WRITE;
/*!40000 ALTER TABLE `tm_publish_test_by_post` DISABLE KEYS */;
INSERT INTO `tm_publish_test_by_post` VALUES (1,0,'',3,'2025-10-06 10:18:27','2025-10-06 10:18:27');
/*!40000 ALTER TABLE `tm_publish_test_by_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_publish_test_list`
--

DROP TABLE IF EXISTS `tm_publish_test_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_publish_test_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ptl_active_date` date NOT NULL,
  `ptl_time` int DEFAULT NULL,
  `ptl_link` longtext NOT NULL,
  `ptl_link_1` varchar(50) NOT NULL,
  `ptl_test_id` bigint NOT NULL,
  `ptl_master_exam_id` int NOT NULL DEFAULT '0',
  `ptl_master_exam_name` varchar(128) DEFAULT '0',
  `ptl_added_date` date NOT NULL,
  `ptl_added_time` varchar(20) NOT NULL,
  `ptl_time_tramp` varchar(20) NOT NULL,
  `ptl_test_description` mediumtext NOT NULL,
  `ptl_is_live` int NOT NULL DEFAULT '1',
  `ptl_aouth_id` bigint NOT NULL,
  `ptl_is_test_done` int NOT NULL DEFAULT '0',
  `ptl_test_info` longtext NOT NULL,
  `mt_name` mediumtext NOT NULL,
  `mt_added_date` date NOT NULL,
  `mt_descp` longtext NOT NULL,
  `mt_is_live` int NOT NULL DEFAULT '1',
  `mt_time_stamp` varchar(20) NOT NULL,
  `mt_type` int NOT NULL COMMENT '1: on tablet,2: on paper	',
  `tm_aouth_id` bigint NOT NULL,
  `mt_test_time` varchar(10) NOT NULL COMMENT 'test duration',
  `mt_total_test_takan` int NOT NULL DEFAULT '0',
  `mt_is_negative` varchar(10) NOT NULL DEFAULT '0',
  `mt_negativ_mark` varchar(10) NOT NULL DEFAULT '0',
  `mt_mark_per_question` varchar(10) NOT NULL DEFAULT '1',
  `mt_passing_out_of` varchar(10) NOT NULL COMMENT 'cut off',
  `mt_total_marks` int NOT NULL DEFAULT '0',
  `mt_pattern_type` int NOT NULL DEFAULT '0' COMMENT 'eg . 0 for genral',
  `mt_total_test_question` int NOT NULL DEFAULT '0',
  `mt_added_time` varchar(20) NOT NULL,
  `mt_pattern_name` varchar(30) DEFAULT '-',
  `is_test_generated` int DEFAULT '0',
  `ptl_test_mode` int NOT NULL DEFAULT '1',
  `tm_allow_to` int NOT NULL DEFAULT '0' COMMENT '0-all,1-eng&gen,2-med&gen',
  `is_test_loaded` int DEFAULT '0',
  `is_student_added` int DEFAULT '0',
  `is_uploaded` int DEFAULT '0',
  `is_start_exam` int DEFAULT '0',
  `is_absent_mark` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ptl_test_id` (`ptl_test_id`),
  KEY `ptl_link_1` (`ptl_link_1`),
  KEY `ptl_active_date` (`ptl_active_date`),
  KEY `ptl_master_exam_id` (`ptl_master_exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_publish_test_list`
--

LOCK TABLES `tm_publish_test_list` WRITE;
/*!40000 ALTER TABLE `tm_publish_test_list` DISABLE KEYS */;
INSERT INTO `tm_publish_test_list` VALUES (3,'2025-10-06',0,'NDY0NA==','4644',4,0,'-','2025-10-06','10:18:10','2025-10-06 10:18:10','-',1,1,0,'[{\"test_id\":\"2\",\"test_name\":\"New Exam Omkar-Type-1\",\"test_created_on\":\"2025-10-06\",\"test_descp\":\"-\",\"test_type\":\"Online\",\"test_duration\":\"120\",\"test_negative\":\"0\",\"test_mark_per_q\":\"1\",\"passing_out_of\":\"35\",\"test_total_marks\":30,\"test_pattern\":1,\"test_total_question\":30,\"id\":4,\"mt_name\":\"New Exam Omkar-Type-1\",\"mt_added_date\":\"2025-10-06\",\"mt_descp\":\"-\",\"mt_added_time\":\"10:18:10\",\"mt_is_live\":1,\"mt_time_stamp\":\"2025-10-06T04:41:43.\",\"mt_type\":1,\"tm_aouth_id\":1,\"mt_test_time\":\"120\",\"mt_total_test_takan\":0,\"mt_is_negative\":\"0\",\"mt_negativ_mark\":\"0\",\"mt_mark_per_question\":\"1\",\"mt_passing_out_of\":\"35\",\"mt_total_marks\":30,\"mt_pattern_type\":1,\"mt_total_test_question\":30}]','New Exam Omkar-Type-1','2025-10-06','TEST',1,'2025-10-06T04:41:43.',1,1,'120',0,'0','0','1','35',30,1,30,'10:11:43','-',0,0,1,1,NULL,0,1,0);
/*!40000 ALTER TABLE `tm_publish_test_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_stud_institute_list`
--

DROP TABLE IF EXISTS `tm_stud_institute_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_stud_institute_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `il_name` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_stud_institute_list`
--

LOCK TABLES `tm_stud_institute_list` WRITE;
/*!40000 ALTER TABLE `tm_stud_institute_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `tm_stud_institute_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_student_final_result_set`
--

DROP TABLE IF EXISTS `tm_student_final_result_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_student_final_result_set` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sfrs_publish_id` int NOT NULL,
  `sfrs_batch_id` int NOT NULL,
  `sfrs_master_exam_id` int NOT NULL,
  `sfrs_student_id` int NOT NULL,
  `sfrs_student_roll_no` varchar(50) NOT NULL,
  `sfrs_marks_gain` varchar(50) NOT NULL,
  `sfrs_correct` varchar(10) NOT NULL,
  `sfrs_wrong` varchar(10) NOT NULL,
  `sfrs_unattempted` varchar(10) NOT NULL,
  `sfrs_cutoff` varchar(20) NOT NULL,
  `sfrc_total_marks` varchar(10) NOT NULL,
  `sfrs_test_date` date NOT NULL,
  `sfrs_test_info` varchar(20) NOT NULL DEFAULT 'Test',
  `sfrs_rem_min` varchar(20) NOT NULL,
  `sfrs_rem_sec` varchar(20) NOT NULL,
  `sfrs_duration` int NOT NULL,
  `sfrs_sms` varchar(20) NOT NULL DEFAULT '0',
  `sfrs_sms_issue` varchar(512) NOT NULL DEFAULT 'No',
  `sfrs_sms_message` varchar(512) NOT NULL DEFAULT 'No',
  `sfrs_is_absent` int NOT NULL DEFAULT '1',
  `sfrs_percentile` double NOT NULL DEFAULT '0',
  `sfrs_sub_id_1` int NOT NULL DEFAULT '0',
  `sfrs_sub_name_1` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_1` double NOT NULL DEFAULT '0',
  `sfrs_sub_percentile_1` double NOT NULL DEFAULT '0',
  `sfrs_sub_id_2` int NOT NULL DEFAULT '0',
  `sfrs_sub_name_2` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_2` double NOT NULL DEFAULT '0',
  `sfrs_sub_percentile_2` double NOT NULL DEFAULT '0',
  `sfrs_sub_id_3` int NOT NULL DEFAULT '0',
  `sfrs_sub_name_3` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_3` double NOT NULL DEFAULT '0',
  `sfrs_sub_percentile_3` double NOT NULL DEFAULT '0',
  `sfrs_sub_id_4` int NOT NULL DEFAULT '0',
  `sfrs_sub_name_4` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_4` double NOT NULL DEFAULT '0',
  `sfrs_sub_percentile_4` double NOT NULL DEFAULT '0',
  `sfrs_dob` bigint NOT NULL DEFAULT '0',
  `sfrs_rank` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `sfrs_student_id` (`sfrs_student_id`),
  KEY `sfrs_student_roll_no` (`sfrs_student_roll_no`),
  KEY `sfrs_test_date` (`sfrs_test_date`),
  KEY `sfrs_publish_id` (`sfrs_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_student_final_result_set`
--

LOCK TABLES `tm_student_final_result_set` WRITE;
/*!40000 ALTER TABLE `tm_student_final_result_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `tm_student_final_result_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_student_question_paper`
--

DROP TABLE IF EXISTS `tm_student_question_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_student_question_paper` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sqp_question_id` bigint NOT NULL COMMENT 'this is question_paper_list_ table id',
  `sqp_student_id` bigint NOT NULL COMMENT 'student table id',
  `sqp_test_id` bigint NOT NULL,
  `sqp_publish_id` bigint NOT NULL,
  `sqp_is_remark` int NOT NULL DEFAULT '0',
  `sqp_index_value` int DEFAULT NULL,
  `sqp_time` varchar(10) DEFAULT NULL,
  `sqp_ans` varchar(5) DEFAULT NULL,
  `added_time` varchar(10) DEFAULT NULL,
  `sqp_min` int DEFAULT '0',
  `sqp_sec` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tm_student_question_paper_sqp_question_id` (`sqp_question_id`),
  KEY `idx_tm_student_question_paper_sqp_publish_id` (`sqp_publish_id`),
  KEY `idx_tm_student_question_paper_sqp_student_id` (`sqp_student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_student_question_paper`
--

LOCK TABLES `tm_student_question_paper` WRITE;
/*!40000 ALTER TABLE `tm_student_question_paper` DISABLE KEYS */;
INSERT INTO `tm_student_question_paper` VALUES (1,9,30001,4,3,0,NULL,NULL,'b',NULL,0,0),(2,19,30001,4,3,0,NULL,NULL,'c',NULL,0,0),(3,25,30001,4,3,0,NULL,NULL,'d',NULL,0,0),(4,2,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(5,1,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(6,27,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(7,20,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(8,13,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(9,23,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(10,5,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(11,4,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(12,6,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(13,24,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(14,21,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(15,29,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(16,3,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(17,12,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(18,10,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(19,8,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(20,26,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(21,22,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(22,17,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(23,16,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(24,11,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(25,30,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(26,18,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(27,7,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(28,28,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(29,14,30001,4,3,0,NULL,NULL,NULL,NULL,0,0),(30,15,30001,4,3,0,NULL,NULL,NULL,NULL,0,0);
/*!40000 ALTER TABLE `tm_student_question_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_student_test_attendance`
--

DROP TABLE IF EXISTS `tm_student_test_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_student_test_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sta_student_id` int NOT NULL,
  `sta_publish_id` int NOT NULL,
  `sta_is_present` int NOT NULL DEFAULT '0',
  `sta_is_block` int NOT NULL DEFAULT '0',
  `sta_date` date NOT NULL,
  `sta_time` varchar(20) NOT NULL,
  `sta_time_stamp` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sta_publish_id` (`sta_publish_id`),
  KEY `sta_student_id` (`sta_student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_student_test_attendance`
--

LOCK TABLES `tm_student_test_attendance` WRITE;
/*!40000 ALTER TABLE `tm_student_test_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `tm_student_test_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_student_test_list`
--

DROP TABLE IF EXISTS `tm_student_test_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_student_test_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stl_test_id` bigint NOT NULL,
  `stl_stud_id` bigint NOT NULL,
  `stl_publish_id` bigint NOT NULL,
  `stl_date` date NOT NULL,
  `stl_test_url` longtext,
  `stl_time` varchar(20) DEFAULT NULL,
  `stl_time_stamp` varchar(20) DEFAULT NULL,
  `stl_test_compliet_in` varchar(20) NOT NULL DEFAULT '0',
  `stl_test_submition_time` varchar(20) DEFAULT NULL,
  `stl_test_status` int NOT NULL DEFAULT '2',
  `stl_agrement_accepted` int NOT NULL DEFAULT '1',
  `stm_min` int DEFAULT NULL,
  `stm_sec` int DEFAULT NULL,
  `stl_browser_info` longtext,
  `stl_user_ip` longtext,
  PRIMARY KEY (`id`),
  KEY `stl_test_id` (`stl_test_id`),
  KEY `stl_stud_id` (`stl_stud_id`),
  KEY `stl_publish_id` (`stl_publish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_student_test_list`
--

LOCK TABLES `tm_student_test_list` WRITE;
/*!40000 ALTER TABLE `tm_student_test_list` DISABLE KEYS */;
INSERT INTO `tm_student_test_list` VALUES (1,4,30001,3,'2025-10-06',NULL,'10:41:53','2025-10-6 10:41:53','0',NULL,1,1,117,35,NULL,NULL);
/*!40000 ALTER TABLE `tm_student_test_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tm_test_question_sets`
--

DROP TABLE IF EXISTS `tm_test_question_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tm_test_question_sets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `q_id` int NOT NULL,
  `tqs_test_id` int NOT NULL,
  `section_id` int NOT NULL,
  `section_name` text NOT NULL,
  `sub_topic_id` int NOT NULL,
  `sub_topic_section` text NOT NULL,
  `main_topic_id` int NOT NULL,
  `main_topic_name` text,
  `q` longtext,
  `q_a` longtext,
  `q_b` longtext,
  `q_c` longtext,
  `q_d` longtext,
  `q_e` longtext,
  `q_display_type` int DEFAULT '1',
  `q_ask_in` longtext,
  `q_data_type` int DEFAULT '1',
  `q_mat_data` longtext,
  `q_col_a` longtext,
  `q_col_b` longtext,
  `q_mat_id` bigint DEFAULT NULL,
  `q_i_a` longtext,
  `q_i_b` longtext,
  `q_i_c` longtext,
  `q_i_d` longtext,
  `q_i_e` longtext,
  `q_i_q` longtext,
  `q_i_sol` longtext,
  `stl_topic_number` text,
  `sl_section_no` text,
  `q_sol` text,
  `q_ans` text,
  `q_mat_ans` text,
  `q_mat_ans_row` text,
  `q_col_display_type` int DEFAULT '1',
  `question_no` varchar(1024) DEFAULT NULL,
  `mark_per_question` varchar(1024) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `q_id` (`q_id`),
  KEY `tqs_test_id` (`tqs_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tm_test_question_sets`
--

LOCK TABLES `tm_test_question_sets` WRITE;
/*!40000 ALTER TABLE `tm_test_question_sets` DISABLE KEYS */;
INSERT INTO `tm_test_question_sets` VALUES (121,1,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>The Rashtrakuta king .......... Krishna, who lived in the 8th century, is credited with excavating the Kailasa cave.<br />\nआठव्या शतकामध्ये होऊन गेलेला राष्ट्रकूट राजा .......... कृष्ण याला कैलास लेणे खोदण्याचे श्रेय मिळते.</p>','<p>First (पहिला)</p>','<p>Second (दुसरा)</p>','<p>Third (तिसरा)</p>','<p>Fourth (चौथा)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','a',NULL,NULL,NULL,NULL,'1'),(122,2,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Malik Ambar built the Naukhanda Palace in which year?<br />\nमलिक अंबरने नवखंडा महल हे ....... मध्ये बांधला.</p>','<p>1516 (१५१६)</p>','<p>1616 (१६१६)</p>','<p>1716 (१७१६)</p>','<p>1816 (१८१६)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(123,3,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Shivakasi, a place famous for firecracker manufacturing, is located in which state?<br />\nशिवकाशी हे फटाका निर्मीतीचे प्रसिध्द ठिकाण कोणत्या राज्यात आहे?</p>','<p>&nbsp;Karnataka (कर्नाटक)</p>','<p>Kerala (केरळ)</p>','<p>&nbsp;Andhra Pradesh (आंध्रप्रदेश)</p>','<p>Tamil Nadu (तमिळनाडू)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(124,4,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Jhum is a type of ........<br />\nझुम हा एक ........ आहे.</p>\n','<p>a type of dance (नृत्याचा प्रकार)</p>\n','<p>a type of agriculture (शेतीचा प्रकार)</p>\n','<p>a type of rock (खडकाचा प्रकार)</p>\n','<p>a type of folk drama (लोकनाट्याचा प्रकार)</p>\n','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(125,5,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Which country has no mineral resources?<br />\nअसा कोणता देश आहे की ज्यात कोणतेही खनिज आढळत नाही?</p>','<p>France (फ्रांस)</p>','<p>Switzerland (स्वित्झर्लंड)</p>','<p>Sweden (स्वीडन)</p>','<p>Peru (पेरु)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(126,6,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Identify the correct sequence of planetary winds flowing from the equator towards the poles.<br />\nविषुववृत्तपासून ध्रुवाकडे वाहणाऱ्या ग्रहीय वाऱ्यांचा योग्य क्रम ओळखा.</p>','<p>Westerlies, Trade Winds, Polar Winds (पश्चिमी वारे, व्यापारी वारे, ध्रुवीय वारे)</p>','<p>Trade Winds, Westerlies, Polar Winds (व्यापारी वारे, पश्चिमी वारे, ध्रुवीय वारे)</p>','<p>Trade Winds, Polar Winds, Westerlies (व्यापारी वारे, ध्रुवीय वारे, पश्चिमी वारे)</p>','<p>Polar Winds, Westerlies, Trade Winds (ध्रुवीय वारे, पश्चिमी वारे, व्यापारी वारे)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(127,7,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>In the solar system, the planet ........... is located at a distance of ........... km from the Sun and takes 88 days to complete one revolution around it.<br />\nसूर्यमालेतील ........... ग्रह सूर्यापासून ........... कि.मी. अंतरावर असून सूर्याभोवती एक परिभ्रमण करण्यास त्याला 88 दिवस लागतात.</p>\n','<p>Venus, 88 million&nbsp;(शुक्र, ८८ दशलक्ष)</p>\n','<p>Mercury, 58 million (बुध, ५८&nbsp;दशलक्ष)</p>\n','<p>Mars, 28 million (मंगळ, २८&nbsp;दशलक्ष)</p>\n','<p>Saturn, 52&nbsp;million (शनि, ५२ दशलक्ष)</p>\n','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(128,8,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Important ISRO centres and their locations are listed below. Identify the pair that is incorrect.<br />\nइसरो (ISRO) ची महत्वाची केंद्रे व स्थळे खाली दिलेली आहेत. त्यापैकी एक जोडी चुकीची आहे. ती ओळखा.</p>\n','<p>Vikram Sarabhai Space Centre &ndash; Thiruvananthapuram<br />\n(विक्रम साराभाई स्पेस सेंटर - तिरुवनंतपुरम)</p>\n','<p>Space Applications Centre &ndash; Bengaluru<br />\n(स्पेस ॲप्लीकेशन सेंटर - बंगळुरु)</p>\n','<p>Satish Dhawan Space Centre &ndash; Sriharikota<br />\n(सतिश धवन स्पेस सेंटर - श्रीहरिकोटा)</p>\n','<p>ISRO Propulsion Complex &ndash; Mahendragiri<br />\n(इसरो प्रोपुल्शन सेंटर - महेंद्रगिरी)</p>\n','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(129,9,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Which nutrient deficiency causes interveinal chlorosis in plant leaves?<br />\nइंटर व्हेनल क्लोरोसिस हे वनस्पतींच्या पानावर कोणत्या घटकाच्या कमतरतेमुळे दिसून येते?</p>','<p>Nitrogen (नायट्रोजन)</p>','<p>Calcium (कॅल्शियम)</p>','<p>Boron (बोरॉन)</p>','<p>Iron (आयर्न)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(130,10,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>PAN (Peroxyacetyl Nitrate) is formed as a result of which of the following interactions?<br />\nPAN (पेरोक्सीअसेटाइल नायट्रेट) खालील परस्पर क्रियेच्या परिणामी तयार होतो.</p>\n','<p>Nitrogen oxides and Sulfur dioxide<br />\n(नायट्रोजन ऑक्साइड आणि सल्फर डायऑक्साइड)</p>\n','<p>Carbon monoxide and Volatile organic compounds<br />\n(कार्बन मोनोऑक्साइड आणि अस्थिर सेंद्रिय संयुगे)</p>\n','<p>Nitrogen oxides and Hydrocarbons<br />\n(नायट्रोजन ऑक्साइड आणि हायड्रोकार्बन्स)</p>\n','<p>Ozone and Particulates<br />\n(ओझोन आणि कण)</p>\n','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','c',NULL,NULL,NULL,NULL,'1'),(131,11,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Which of the following is not mentioned in the Constitution of India?<br />\nभारतीय राज्यघटनेत खालीलपैकी कोणत्या गोष्टींचा उल्लेख नाही?<br />\nA.Council of Ministers headed by the Chief Minister<br />\nअ. (मुख्यमंत्र्यांच्या अध्यक्षतेखाली मंत्री परिषद)<br />\nB. Collective responsibility of the Council of Ministers<br />\nब. (राज्यमंत्रीमंडळाची सामुहिक जबाबदारी)<br />\nC. Resignation of State Ministers<br />\nक. (राज्यमंत्र्यांचे राजीनामे)<br />\nD. Post of Deputy Chief Minister<br />\nड. (उप-मुख्यमंत्र्यांचे पद)</p>','<p>A &amp; B (अ आणि ब)</p>','<p>B &amp; C (ब आणि क)</p>','<p>C &amp; D (क आणि ड)</p>','<p>A &amp; C (अ आणि क)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','c',NULL,NULL,NULL,NULL,'1'),(132,12,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>While establishing the Bombay Mill Hand Association, which of the following individuals supported Narayan Meghaji Lokhande?<br />\nनारायण मेघाजी लोखंडे यांनी बॉम्बे मिल हॅण्ड असोसिएशन ही कामगार संघटना स्थापन करीत असताना त्यांना खालीलपैकी कोणत्या व्यक्तींचे सहकार्य मिळाले होते ?<br />\nA. Keshavrao Bagde, Keshavrao Bole<br />\nअ. (केशवराव बागडे, केशवराव बोले)<br />\nB. Raghu Bhikaji, Genu Babaji<br />\nब. (रघु भिकाजी, गेणू बाबाजी)<br />\nC. Narayan Surkaji, Vitthalrao Korgaonkar<br />\nक. (नारायण सुर्काजी, विठ्ठलराव कोरगांवकर)<br />\nD. Krishnaji Arjun Keluskar, Ramchandra Shinde, Narayan Pawar<br />\nड . (कृष्णाजी अर्जुन केळूसकर, रामचंद्र शिंदे, नारायण पवार)</p>','<p>A and B only (अ आणि ब फक्त)</p>','<p>B and D only (ब आणि ड फक्त)</p>','<p>A, B and C only (अ, ब आणि क फक्त)</p>','<p>B, C and D only (ब, क आणि ड फक्त)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(133,13,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Which of the following is the first indigenous kamikaze (suicide) drone inducted into the Indian Army?<br />\nभारतीय लष्करात दाखल झालेले पहिले स्वदेशी आत्मघातकी ड्रोन खालीलपैकी कोणते आहे ?</p>','<p>Bharat-1 (भारत-1)</p>','<p>Akash-1 (आकाश-1)</p>','<p>Nagastra-1 (नागास्त्र-1)</p>','<p>Brahmastra-1 (ब्रम्हास्त्र-1)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','c',NULL,NULL,NULL,NULL,'1'),(134,14,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Yahoo was founded by whom?<br />\nयाहूचे (Yahoo) निर्माते ....... हे आहेत.</p>','<p>David Filo and Jerry Yang (डेव्हिड फिलो व जेरी यांग)</p>','<p>Vint Cerf and Robert Kahn (व्हिंट कर्फ व रॉबर्ट काहन)</p>','<p>Bill Gates and Ken Thompson (बिल गेट्स व केन थॉम्सन)</p>','<p>Steve Case and Jeff Bezos (स्टिव्ह केस व जेफ बेझोस)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','a',NULL,NULL,NULL,NULL,'1'),(135,15,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>Which of the following is an example of a mechanical wave?<br />\nखालीलपैकी कोणते तरंग हे यांत्रिक तरंगाचे उदाहरण आहे ?</p>','<p>Light waves (प्रकाश तरंग)</p>','<p>Sound waves (ध्वनी तरंग)</p>','<p>Radio waves (रेडिओ तरंग)</p>','<p>Television waves (दूरचित्रवाणी तरंग)</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(136,16,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>पुढील कवितेचा रचनाप्रकार कोणता ?<br />\n&quot;सुसंगति सदा घडो, सुजनवाक्य कानी पडो,<br />\n&nbsp; कलंक मतिचा झडो, विषय सर्वथा नावडो,<br />\n&nbsp; सदंध्री कमळी दंडो, मुरडिता हटांने अडो,<br />\n&nbsp; वियोग घडता रडो, मन भवच्चरित्री जडो.&rsquo;&rsquo;</p>\n','<p>ओवी</p>\n','<p>आर्या</p>\n','<p>श्लोक</p>\n','<p>अभंग</p>\n','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(137,17,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>पुढीलपैकी शुद्ध वाक्य कोणते ?</p>','<p>ना. शि. फडकेंनी अनेक कादंबरी लिहिल्या.</p>','<p>ना. सि. फडके थोर साहित्यकार झाले होते.</p>','<p>ना. शी. फडकेंना थोर कवी म्हणतात.</p>','<p>ना. सी. फडके यांनी अनेक कादंबऱ्या लिहिल्या.</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(138,18,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>प्रचलित लेखन नियमानुसार अचूक शब्दगट कोणता ?<br />\nअ) उफराटा, महशूर, अविष्कार, मथितार्थ.<br />\nब) आशीर्वाद, चिकटविणे, माहात्म्य, आहेर.&nbsp;<br />\nक) तुषार, विषाद, विशेष, विशद.<br />\nड) नुकसान, अनसूया, अनुग्रह, खुशाली.</p>','<p>फक्त अ, ब बरोबर, क, ड चूक.</p>','<p>फक्त क, ड बरोबर, अ, ब चूक.</p>','<p>फक्त अ, ड बरोबर, ब, क चूक.</p>','<p>फक्त ब, ड बरोबर, अ, क चूक.</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(139,19,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>&lsquo;जलाभेद्य&rsquo; या शब्दाचा पुढीलपैकी कोणत्या वाक्यांमधील उपयोग योग्य आहे ?<br />\nअ) नदीच्या विशाल प्रवाहाने दोन्ही गावे जलाभेद्य झाली आहेत.<br />\nब) यंत्रांच्या खोक्यांवर जलाभेद्य आवरणे पाहिजेत.<br />\nक) मातीची भांडी जलाभेद्य असल्याने गार होतात.<br />\nड) जलाभेद्यतेमुळे सुती कापड अधिक पाणी शोषते.</p>','<p>फक्त अ</p>','<p>फक्त ब</p>','<p>अ आणि क</p>','<p>अ आणि ड</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(140,20,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>खालीलपैकी समानार्थी शब्दाबद्दल चुकीची जोडी शोधा.</p>','<p>अनल &ndash; विस्तव, पावक, अग्नी, वन्ही</p>','<p>घर &ndash; सदन, भवन, गृह, आलय</p>','<p>अमृत &ndash; सुधा, पीयूष, रस, चिरंजीवी</p>','<p>चंद्र &ndash; इंदु, सुधाकर, हिमांशू, शशी</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','c',NULL,NULL,NULL,NULL,'1'),(141,21,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>&nbsp;&lsquo;आसुडणे&rsquo; हि क्रिया खालील पर्यायांपैकी कशाशी संबंधित आहे?</p>','<p>दळणे</p>','<p>कांडणे</p>','<p>वेचणे</p>','<p>पाखडणे</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(142,22,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>बोलणाऱ्याच्या तोंडचे शब्द तशाच स्वरुपात दर्शविण्यासाठी कोणते विरामचिन्ह वापरले जाते ?</p>','<p>उद्गारवाचक चिन्ह</p>','<p>संयोग चिन्ह</p>','<p>प्रश्नचिन्ह</p>','<p>अवतरण चिन्ह&nbsp;</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(143,23,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>खालील पर्यायी उत्तरांतून &lsquo;व्यंजना शब्दशक्ती&rsquo; ओळखा.</p>','<p>तो पेला पिऊन टाक.</p>','<p>साखर कारखान्याला एक दोन ट्रकच येऊन काय उपयोगाचे?</p>','<p>सायंकाळचा देखावा छानच असतो.&nbsp;</p>','<p>वत्सलाबाई आपल्या सुनेला म्हणाल्या, &lsquo;सुनबाई, आता संध्याकाळ झाली.&rsquo;</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1'),(144,24,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>&lsquo;भर दरबारात माधवराव पेशव्यांनी गंगोबा चंद्रचुडांच्या <strong><ins>श्रीमुखात</ins></strong> दिली.&rsquo; अधोरेखित केलेल्या शब्दाची शब्दशक्ती कोणती ?<br />\nअ) अभिधा<br />\nब) लक्षणा<br />\nक) व्यंजना<br />\nड) यापैकी नाही</p>\n','<p>अ आणि ब बरोबर, अन्य सर्व चूक</p>\n','<p>फक्त ब बरोबर, अन्य सर्व चूक</p>\n','<p>फक्त क बरोबर, अन्य सर्व चूक</p>\n','<p>फक्त ड बरोबर, अन्य सर्व चूक</p>\n','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(145,25,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>खालील काव्यबंधातील अलंकार ओळखा.<br />\nश्रीकृष्ण नवरा मी नवरी !<br />\nशिशुपाल नवरा मी न-वरी !</p>','<p>श्लेष</p>','<p>अपन्हुती</p>','<p>अतिशयोक्ती</p>','<p>रूपक</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','a',NULL,NULL,NULL,NULL,'1'),(146,26,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>रिकाम्या जागी योग्य पर्याय शोधा.<br />\nएखाद्या गोष्टीचे हुबेहूब वर्णन जेथे केलेले असते तेथे ................ अलंकार होतो.</p>','<p>स्वभावोक्ती</p>','<p>पर्यायोक्ती</p>','<p>व्याज स्तुती</p>','<p>चेतन &ndash; गुणोक्ती</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','a',NULL,NULL,NULL,NULL,'1'),(147,27,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>&lsquo;य-य-य-य&rsquo; हे कोणत्या अक्षरवृत्ताचे गण आहेत ?</p>','<p>इंद्रवज्रा</p>','<p>भुजंग प्रयात</p>','<p>वसंत तालिका</p>','<p>पृथ्वी</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','b',NULL,NULL,NULL,NULL,'1'),(148,28,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>&nbsp;पुढील उद्गारार्थी वाक्याच्या रुपांतरीत केलेल्या वाक्यांपैकी कोणते वाक्य विधानार्थी आहे ?<br /><strong>&lsquo;केवढी उंच इमारत ही !&rsquo;</strong><br />\nअ) भलतीच उंच आहे ही इमारत.<br />\nब) उंचीला भरपूर असलेली ही इमारत आहे.<br />\nक) ही इमारत खूप उंच आहे.<br />\nड) काय उंची आहे या इमारतीची.</p>','<p>ब बरोबर, अ, क, ड चूक</p>','<p>अ बरोबर, ब, क, ड चूक</p>','<p>क बरोबर, ब, अ, ड चूक</p>','<p>ड बरोबर, अ, ब, क चूक&nbsp;</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','c',NULL,NULL,NULL,NULL,'1'),(149,29,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>शुद्धलेखनदृष्ट्या अचूक शब्द ओळखा.</p>','<p>ऊष्ण</p>','<p>नाविन्य</p>','<p>ऊहापोह</p>','<p>आधीन</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','c',NULL,NULL,NULL,NULL,'1'),(150,30,4,0,'-',1,'BATCH 1',1,'BATCH 1','<p>पुढे येणारी गोष्ट मागे सांगितलेल्या गोष्टींचे उदाहरण, यादी, सारांश, कोष्टक किंवा तत्सम काहीतरी आहे असे दाखविण्यासाठी वापरले जाणारे विरामचिन्ह कोणते ?</p>','<p>लोपचिन्ह</p>','<p>स्वल्पविराम</p>','<p>अर्धविराम</p>','<p>अपूर्णविराम</p>','',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'','d',NULL,NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `tm_test_question_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tn_main_student_list`
--

DROP TABLE IF EXISTS `tn_main_student_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tn_main_student_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `r_id` bigint NOT NULL,
  `sl_f_name` varchar(1024) NOT NULL,
  `sl_m_name` varchar(1024) NOT NULL,
  `sl_l_name` varchar(1024) NOT NULL,
  `msl_batch_id` int NOT NULL DEFAULT '0' COMMENT '2',
  `sl_institute_id` int NOT NULL,
  `sl_institute_name` varchar(512) NOT NULL,
  `sl_image` longtext,
  `sl_sign` longtext,
  `sl_email` varchar(1024) NOT NULL,
  `sl_father_name` varchar(50) NOT NULL,
  `sl_mother_name` varchar(50) NOT NULL,
  `sl_address` mediumtext NOT NULL,
  `sl_mobile_number_parents` varchar(15) NOT NULL,
  `sl_tenth_marks` int NOT NULL,
  `sl_contact_number` varchar(1024) NOT NULL,
  `sl_class` varchar(50) NOT NULL,
  `sl_roll_number` varchar(20) DEFAULT NULL,
  `sl_subject` varchar(50) NOT NULL,
  `sl_stream` varchar(70) NOT NULL COMMENT '1=JEE;2=MHT-CET;3=NEET',
  `sl_addmit_type` varchar(70) NOT NULL COMMENT '2= fresher;1=repeater',
  `sl_time` varchar(20) NOT NULL,
  `sl_date` date NOT NULL,
  `sl_time_stamp` varchar(20) NOT NULL,
  `sl_added_by_login_id` bigint NOT NULL,
  `sl_is_live` int NOT NULL DEFAULT '1',
  `sl_date_of_birth` date DEFAULT NULL,
  `sl_school_name` varchar(500) DEFAULT NULL,
  `sl_is_physical_handicap` int NOT NULL DEFAULT '0',
  `sl_application_number` varchar(100) DEFAULT NULL,
  `sl_student_document` varchar(255) DEFAULT NULL,
  `sl_coupon_id` int DEFAULT NULL,
  `sl_student_ref_by` varchar(255) DEFAULT NULL,
  `sl_catagory` varchar(50) DEFAULT NULL,
  `sl_post` varchar(100) DEFAULT NULL,
  `sl_password` varchar(50) DEFAULT NULL,
  `sl_exam_type` int DEFAULT '1' COMMENT '1:PCM, 2 PCB, 3 PCMB',
  `sl_publish_id` bigint DEFAULT '0',
  `sl_is_present` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sl_roll_number` (`sl_roll_number`),
  KEY `sl_password` (`sl_password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tn_main_student_list`
--

LOCK TABLES `tn_main_student_list` WRITE;
/*!40000 ALTER TABLE `tn_main_student_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `tn_main_student_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tn_student_list`
--

DROP TABLE IF EXISTS `tn_student_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tn_student_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sl_f_name` varchar(1024) NOT NULL,
  `sl_m_name` varchar(1024) DEFAULT NULL,
  `sl_l_name` varchar(1024) DEFAULT NULL,
  `sl_image` longtext,
  `sl_sign` longtext,
  `sl_email` varchar(1024) DEFAULT NULL,
  `sl_father_name` varchar(50) DEFAULT NULL,
  `sl_mother_name` varchar(50) DEFAULT NULL,
  `sl_address` mediumtext,
  `sl_mobile_number_parents` varchar(15) DEFAULT NULL,
  `sl_tenth_marks` int DEFAULT NULL,
  `sl_contact_number` varchar(1024) NOT NULL,
  `sl_class` varchar(50) DEFAULT NULL,
  `sl_roll_number` varchar(20) DEFAULT NULL,
  `sl_subject` varchar(50) DEFAULT NULL,
  `sl_stream` varchar(70) DEFAULT NULL,
  `sl_addmit_type` varchar(70) DEFAULT NULL,
  `sl_time` varchar(20) DEFAULT NULL,
  `sl_date` date DEFAULT NULL,
  `sl_time_stamp` varchar(20) DEFAULT NULL,
  `sl_added_by_login_id` bigint DEFAULT NULL,
  `sl_is_live` int NOT NULL DEFAULT '1',
  `sl_date_of_birth` date DEFAULT NULL,
  `sl_school_name` varchar(500) DEFAULT NULL,
  `sl_catagory` varchar(128) DEFAULT NULL,
  `sl_application_number` text,
  `sl_is_physical_handicap` int NOT NULL DEFAULT '1',
  `sl_is_physical_handicap_desc` text,
  `sl_post` text,
  `sl_center_code` bigint DEFAULT NULL,
  `sl_batch_no` int DEFAULT NULL,
  `sl_exam_date` date DEFAULT NULL,
  `sl_password` longtext,
  `sl_present_status` int DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tn_student_list_sl_roll_number` (`sl_roll_number`),
  KEY `sl_center_code` (`sl_center_code`),
  KEY `sl_batch_no` (`sl_batch_no`),
  KEY `sl_exam_date` (`sl_exam_date`)
) ENGINE=InnoDB AUTO_INCREMENT=50174 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tn_student_list`
--

LOCK TABLES `tn_student_list` WRITE;
/*!40000 ALTER TABLE `tn_student_list` DISABLE KEYS */;
INSERT INTO `tn_student_list` VALUES (30001,'SANDIP','PRAKASH','GHUGE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601106_2025-05-26 15_58_11.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601106_2025-05-26 15_58_37.jpeg','sandipghuge2000@gmail.com','PRAKASH ','ANUSAYA','AT POST DEVDAHIPHAl NEAR Z P SCHOOl','-',0,'8830835443','-','30001','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-07-08','भुईकाटा ऑपरेटर','open','601106',0,'0','भुईकाटा ऑपरेटर',101,1,'2025-07-05','08071990',1),(50001,'KAMLESH ','JAGANNATH ','CHAUDHARI ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600003_2025-05-19 11_35_09.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600003_2025-05-19 11_36_32.jpeg','kamleshchaudhari29210@gmail.com','JAGANNATH Chaudhari ','BHARTI Chaudhari ','F- 22/05 ,  AYODHYA NAGAR N-7 CIDCO NR.MARUTI MANDIR  F - 22/05, AYODHYA NAGAR N-7 CIDCO NR.MARUTI MANDIR ','-',0,'7378578477','-','50001','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-05-01','वाहन चालक','open','600003',0,'0','वाहन चालक',101,1,'2025-07-05','01051998',2),(50002,'BADAL ','VIJAY ','JONWAL ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600038_2025-05-19 15_09_36.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600038_2025-05-19 15_09_52.jpeg','badaljonwal46@gmail.com','VIjay ','DEVKa','AT.LANDAKWADI, POST KHODEGAON, CHH.SAMBHAJINAGAR, MAHArashtra  KACHANER ROAD.','-',0,'7620136263','-','50002','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-12-24','वाहन चालक','open','600038',0,'0','वाहन चालक',101,1,'2025-07-05','24122001',2),(50003,'VARDHAMAN','GANESH','GHULE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600124_2025-05-19 20_46_11.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600124_2025-05-19 20_46_40.jpeg','ghulevardhaman@gmail.com','GANESH','SAKUNTALa','AT.POST WAKHARI DT.JALNA TQ JALNA ','-',0,'8329693497','-','50003','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-08-24','वाहन चालक','open','600124',0,'0','वाहन चालक',101,1,'2025-07-05','24082000',2),(50004,'PRADIP','DADARAO','PALASKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600152_2025-05-22 14_32_35.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600152_2025-05-22 14_33_19.jpeg','pradippalaskar83@gmail.com','DADARAO JANARDHAN PALASKAR','SUNITA DADARAO PALASKAR','N11 K5\\6  HUDCO','-',0,'7841888719','-','50004','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2003-08-08','वाहन चालक','open','600152',0,'0','वाहन चालक',101,1,'2025-07-05','08082003',2),(50005,'SUNIL','INDAL','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600160_2025-05-20 00_35_58.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600160_2025-05-20 00_36_06.jpeg','jadhavshivraj501@gmail.com','INDAL RAMCHANDRA JADHAv','MENABAI ','2900 NEW HANUMAN NAGAR KAMLAPUR AURANGABAD Maharashtra  NEW HANUMAN NAGAR kamlapur ','-',0,'7841878843','-','50005','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-05-10','वाहन चालक','open','600160',0,'0','वाहन चालक',101,1,'2025-07-05','10052001',2),(50006,'RUPESH','MURALIDHAR','WAKLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600169_2025-05-20 06_41_28.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600169_2025-05-20 06_41_45.jpeg','rupeshwaklepbn@gmail.com','MURALIDHAR','PRAMILA','VIKAS NAGAR GANGAKHED ROAD','-',0,'9168349863','-','50006','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-11-27','वाहन चालक','open','600169',0,'0','वाहन चालक',101,1,'2025-07-05','27111997',2),(50007,'VIJAY','PRABHAKAR','WAGH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600170_2025-05-20 07_37_17.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600170_2025-05-20 07_37_46.jpeg','workpvtltd7875@gmail.com','PRABHAKAR SAKHARAM WAGH','MANGAL PRABHAKAR WAGH','FLAT NO 2, SHALINI VIHAR GARKHEADA','-',0,'7499272195','-','50007','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1999-02-10','वाहन चालक','open','600170',0,'0','वाहन चालक',101,1,'2025-07-05','10021999',2),(50008,'SAGAR ','VIJAY ','LOKHANDE ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600172_2025-05-20 09_00_06.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600172_2025-05-20 09_00_38.jpeg','sagar9689332293@gmail.com','VIJAY BHAGWAN LOKHANDE ','JIJABAI VIJAY LOKHANDE ','AT BHOGAWATI  AT BHOGAWATI ','-',0,'9689332293','-','50008','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1988-08-11','वाहन चालक','open','600172',0,'0','वाहन चालक',101,1,'2025-07-05','11081988',2),(50009,'SACHIN','AJINATH','THORAT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600209_2025-05-20 11_23_09.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600209_2025-05-20 11_22_55.jpeg','sachinthorat1510@gmail.com','AJINATH SADASHIV THORAT','MANGALA THORAT','G-27/7 SAMBHAJI COLONY','-',0,'7507328422','-','50009','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-10-15','वाहन चालक','open','600209',0,'0','वाहन चालक',101,1,'2025-07-05','15102001',2),(50010,'KUNAL','VASANT','CHAVHAN','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600250_2025-05-20 14_58_04.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600250_2025-05-20 15_00_51.jpeg','KVCHAVHAN1993@GMAIL.COM','VASANT GULAB CHAVHAN','VIMAL VASANT CHAVHAN','GREEN PARK 2, NEAR JAGDAMBA MATA TEMPLE, SHREERAMPUR. PUSAD GREEN PARK 2, NEAR JAGDAMBA MATA TEMPLE, SHREERAMPUR. PUSAD','-',0,'8380804354','-','50010','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-11-25','वाहन चालक','open','600250',0,'0','वाहन चालक',101,1,'2025-07-05','25111993',2),(50011,'VIKAS','VITTHAL','DEVKATE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600308_2025-05-20 18_51_12.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600308_2025-05-20 18_51_49.jpeg','vikasdevkate574@gmail.com','VITTHAL PUNDLIK DEVKATe','DEVBAI VITTHAL DEVKATe','AT.DONGARGAOn POST.TANDULWADi','-',0,'9511633351','-','50011','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-05-05','वाहन चालक','open','600308',0,'0','वाहन चालक',101,1,'2025-07-05','05051998',2),(50012,'GOPINATH','RAMBHAU','CHAUDHARI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600318_2025-05-20 19_22_45.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600318_2025-05-20 19_23_04.jpeg','gopinathchaudhary175@gmail.com','RAMBHAU CHAUDHARi','MEERa','AT GARKHEDA NO1 POST CHITTEPIMPALGAON ','-',0,'9673503539','-','50012','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-05-17','वाहन चालक','open','600318',0,'0','वाहन चालक',101,1,'2025-07-05','17051993',2),(50013,'SHAIKH NADEEM ','SHAIKH HABEEB ','SHAIKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600346_2025-05-20 21_40_19.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600346_2025-05-20 21_40_25.jpeg','shaikhnadeem2100@gmail.com','SHAIKH HABEEB KHANMOHAMMAD','NAFISA HABEEB SHAIKH ','PLOT NO. 13 CTS NO. 18788 / 1  SILK MILLS COLONY D 9 ','-',0,'8007541900','-','50013','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-09-23','वाहन चालक','open','600346',0,'0','वाहन चालक',101,1,'2025-07-05','23091996',2),(50014,'PAVAN ','VINAYAK ','JAWANEKAR ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600368_2025-05-20 23_48_39.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600368_2025-05-20 23_50_00.jpeg','pavanjawanekar@gmail.com','VINAYAK ANAJI jawanekar ','PUSHPALATA VINAYAK jawanekar ','WARD NO 2 BAZAR chowk  ','-',0,'7028372667','-','50014','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-11-14','वाहन चालक','open','600368',0,'0','वाहन चालक',101,1,'2025-07-05','14111998',2),(50015,'RAMESHWAR','JADUSING','KAKARWAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600375_2025-05-22 10_44_16.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600375_2025-05-22 10_44_34.jpeg','rameshwarkakarwal@gmail.com','JADusing ','SAVIta ','AT NIHALSINGWADI POST ROHILAGAD TQ AMBAD DIST Jalna  1','-',0,'9730810497','-','50015','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2003-04-05','वाहन चालक','open','600375',0,'0','वाहन चालक',101,1,'2025-07-05','05042003',2),(50016,'NILESH','VISHNUPANT','DHOLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600386_2025-05-27 10_17_26.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600386_2025-05-27 10_52_36.jpeg','dholenilesh143@gmail.com','VISHNUPANT','BEBITAI','AT POST RAJANA PURNA TQ CHANDUR BAZAR','-',0,'8698988185','-','50016','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1988-07-17','वाहन चालक','open','600386',0,'0','वाहन चालक',101,1,'2025-07-05','17071988',2),(50017,'KRISHNA','SHIVAJI','UKARDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600398_2025-05-21 10_46_21.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600398_2025-05-21 10_46_35.jpeg','KRUSHNAUKARDE726@GMAIL.COM','SHIVAJI EKANATH UKARDE','YAMUNA SHIVAJI UKARDE','NEAR POLICE STATION KARMAD AT,POST.KARMAD','-',0,'9665398514','-','50017','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2002-10-09','वाहन चालक','open','600398',0,'0','वाहन चालक',101,1,'2025-07-05','09102002',2),(50018,'CHANDRASHEKHAR','MADHUKAR','PATIL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600405_2025-05-21 11_13_44.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600405_2025-05-21 11_13_52.jpeg','cmpatil275@gmail.com','MADHUKAR BHATU PATIL','RAMABAI MADHUKAR PATIL','AT POST KUSUMBA TAL AND DIST DHULE','-',0,'9370838525','-','50018','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-05-27','वाहन चालक','open','600405',0,'0','वाहन चालक',101,1,'2025-07-05','27051992',2),(50019,'MAHESH','DHONDIRAM','KADAM','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600440_2025-05-21 14_36_02.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600440_2025-05-21 14_35_54.jpeg','maheshkadam9890@gmail.com','DHONDIRAm','BHAGYASHRi','DATTANAGAR  kANOL PATTI KHANDALi','-',0,'9049777164','-','50019','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1988-03-02','वाहन चालक','open','600440',0,'0','वाहन चालक',101,1,'2025-07-05','02031988',2),(50020,'AMIT','NARESH','SANAP','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600449_2025-05-21 14_10_11.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600449_2025-05-21 14_10_21.jpeg','sanapamit18@gmail.com','NARESH GULABRAO SANAp','KALPANA NARESH SANAp','MHADA COLONY NEAR RAM MEGHE COLLEGE BADNERA MHADA COLONY NEAR RAM MEGHE COLLEGE BADnera ','-',0,'9860951274','-','50020','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2005-01-03','वाहन चालक','open','600449',0,'0','वाहन चालक',101,1,'2025-07-05','03012005',2),(50021,'RAMESHAWAR','SHRIMANT','MHASKE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600469_2025-05-21 15_34_03.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600469_2025-05-21 15_34_26.jpeg','rameshwarmhaske530@gmail.com','SHRIMAN MHASKE','MATHURA MHASKE','NEAR HANUMAN MANDIr TAKLI VAIDYa','-',0,'9158514619','-','50021','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-03-04','वाहन चालक','open','600469',0,'0','वाहन चालक',101,1,'2025-07-05','04031995',2),(50022,'BALASAHEB','KAKAJI','MANKAPE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600475_2025-05-21 16_56_58.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600475_2025-05-21 16_57_41.jpeg','balasahebmankape7@gmail.com','KAKAJI MANOHAR MANKAPE','DROPDABAI KAKAI MANKAPE','AT POST JATEGAON TQ PHULAMBRI DIST CHATRAPATI SAMBHAJI NAGAR AT POST JATEGAOON TQ PHULAMBRI DIST CHATRAPATI SAMBHAJI NAGAR','-',0,'8600966886','-','50022','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-08-03','वाहन चालक','open','600475',0,'0','वाहन चालक',101,1,'2025-07-05','03081991',2),(50023,'HRUSHIKESH','SURESH','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600483_2025-05-22 16_23_28.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600483_2025-05-22 16_23_49.jpeg','hrushipawar29@gmail.com','SURESH BALKRUSHNA PAWAr','UMA SURESH PAWAr','MEHARE NAGAR  DABKI ROAd','-',0,'7058887056','-','50023','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-07-29','वाहन चालक','open','600483',0,'0','वाहन चालक',101,1,'2025-07-05','29071998',2),(50024,'NILESH','KAILAS','SURASHE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600485_2025-05-21 17_23_23.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600485_2025-05-21 17_23_45.jpeg','nileshsurashe21@gmail.com','KAILAS','KAVERI','AT POST DEOLANA   TQ KANNAD','-',0,'7719073215','-','50024','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-08-21','वाहन चालक','open','600485',0,'0','वाहन चालक',101,1,'2025-07-05','21081997',2),(50025,'SAURABH','SHIVKUMAR','PHULARI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600494_2025-05-29 15_48_22.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600494_2025-05-29 15_48_04.jpeg','saurabhphulari3@gmail.com','SHIVKUMAr','VIDHYa','AT POST MOHNAL LATUROAd OPPOSITE LATUROAD GRAM PANCHYAt','-',0,'8999401937','-','50025','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-10-13','वाहन चालक','open','600494',0,'0','वाहन चालक',101,1,'2025-07-05','13101991',2),(50026,'VIJAY','MOHAN','RATHOD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600498_2025-05-21 19_08_12.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600498_2025-05-21 19_08_22.jpeg','vijayrathod0552@gmail.com','MOHAn','SAKHUBAi','AT BORWADI TANDA POST ADGAON SARAK TQ CHHATRAPATI SAMBHAJINAGAR','-',0,'8483878482','-','50026','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-08-23','वाहन चालक','open','600498',0,'0','वाहन चालक',101,1,'2025-07-05','23081989',2),(50027,'GANESH','DADARAO','GORDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600512_2025-05-28 16_06_26.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600512_2025-05-28 16_06_34.jpeg','gordeganesh0@gmail.com','DADARAO GORDE','MATHURABAI','ADUL KH  ADUL BL ','-',0,'9146440962','-','50027','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-10-20','वाहन चालक','open','600512',0,'0','वाहन चालक',101,1,'2025-07-05','20102000',2),(50028,'PRAVIN','UTTAM','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600518_2025-05-21 21_19_35.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600518_2025-05-21 21_19_23.jpeg','PAWAR.PRAVIN1819@GMAIL.COM','UTTAM EKNATH PAWAR','PRAMILA UTTAM PAWAR',' A TYPE 14 ROOM NO 12 SECTOR 15 VASHI NAVI MUMBAI','-',0,'9833594301','-','50028','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-03-25','वाहन चालक','open','600518',0,'0','वाहन चालक',101,1,'2025-07-05','25031989',2),(50029,'VITTHAL','DEVIDAS','GOLDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600521_2025-05-21 22_01_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600521_2025-05-21 22_01_58.jpeg','vitthalgolde@gmail.com','DEVIDAS AGAJI GOLDE','SAKHUBAI DEVIDAS GOLDE','AT POST REVGAON REVGAON','-',0,'9579419767','-','50029','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-04-02','वाहन चालक','open','600521',0,'0','वाहन चालक',101,1,'2025-07-05','02041990',2),(50030,'SANKET','RAJENDRA','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600530_2025-05-22 08_18_41.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600530_2025-05-22 08_19_06.jpeg','sanketjadhav10092002@gmail.com','RAJENDRA ','MANGAL','AT.POST WAREGAON TAL.PHULAMBRI DIST.CHHATRAPTI SAMBHAJINAGR  ','-',0,'7887302993','-','50030','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2002-09-10','वाहन चालक','open','600530',0,'0','वाहन चालक',101,1,'2025-07-05','10092002',2),(50031,'NITIN','DIGAMBARRAO','THORAT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600594_2025-05-22 18_48_57.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600594_2025-05-22 18_50_37.jpeg','nitinthorat2598@gmail.com','DIGAMBARRAo','SHILa','AT. SAGARWADI POST. PIMPLOd','-',0,'8788411171','-','50031','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-09-06','वाहन चालक','open','600594',0,'0','वाहन चालक',101,1,'2025-07-05','06091993',2),(50032,'AMOL','FAKIRCHAND','THORAT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600598_2025-05-22 18_52_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600598_2025-05-22 18_53_05.jpeg','amolt515@gmail.com','FAKIRCHAND THORAT','SUMAN','H NO 666 BEHIND JANTA CLINIC JAYBHIM NAGAR','-',0,'9730005423','-','50032','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-04-04','वाहन चालक','open','600598',0,'0','वाहन चालक',101,1,'2025-07-05','04041991',2),(50033,'SOMINATH','ANNASAHEB','WAGH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600616_2025-06-01 10_30_06.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600616_2025-06-01 10_30_17.jpeg','sominathwagh304@gmai.com','ANNASAHEB WAGh','SANGITA WAGH','AT POST CHAUKA TQ DIST CHHATRAPATI SAMBHAJINAGAr AT POST CHAUKA TQ DIST CHHATRAPATI SAMBHAJINAGAR','-',0,'9767104678','-','50033','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1999-07-05','वाहन चालक','open','600616',0,'0','वाहन चालक',101,1,'2025-07-05','05071999',2),(50034,'ARJUN','BHAGWAN ','BAKAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600624_2025-05-22 22_19_51.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600624_2025-05-22 22_20_27.jpeg','arjunbakal2260@gmail.com','BHAGWAN DHONDIBA BAKAL','ANUSAYA BHAGWAN BAKAL','at post pirbawada tq.Phulambri dist.chhatrapati sambhajinagar (Aurangabad ) ','-',0,'9665503168','-','50034','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-01-08','वाहन चालक','open','600624',0,'0','वाहन चालक',101,1,'2025-07-05','08012000',2),(50035,'AMOL','DEVIDAS','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600647_2025-05-23 11_31_15.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600647_2025-05-23 11_32_19.jpeg','amooljadhav11ind@gmail.com','DEVIDAS','HARSHADA','NATHNAGAR  NEAR MONDHANAKA ROAD','-',0,'7887775768','-','50035','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-08-01','वाहन चालक','open','600647',0,'0','वाहन चालक',101,1,'2025-07-05','01081990',2),(50036,'PRASAD','DINKAR','PATIL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600670_2025-05-23 15_15_58.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600670_2025-05-23 15_16_21.jpeg','pp6556.pp@gmail.com','DINKAR PATIl','REKHA PATIl','N7 B1 PLOT NO.6 NEAR CIDCO POLICE STATIOn ','-',0,'9370145393','-','50036','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-02-01','वाहन चालक','open','600670',0,'0','वाहन चालक',101,1,'2025-07-05','01021991',2),(50037,'RAHUL','BABULAL','CHUNGADE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600672_2025-05-23 16_03_53.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600672_2025-05-23 16_04_12.jpeg','ajaychungade03@gmail.com','BABULAL CHUNGADe','SHOBHA CHUNGADe','BANSHENDRA  KANNAD ','-',0,'7350489935','-','50037','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-01-03','वाहन चालक','open','600672',0,'0','वाहन चालक',101,1,'2025-07-05','03011992',2),(50038,'TULSHIDAS ','RAMKRUSHNA ','KASHTI ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600675_2025-05-23 15_53_43.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600675_2025-05-23 15_54_34.jpeg','tulshidaskashti@gmail.com','RAMKRUSHNA KESHORAV KASHTi ','VARSha ','INDIRANAGAR MUL ROAD CHANDRapur  ','-',0,'7304965545','-','50038','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-10-31','वाहन चालक','open','600675',0,'0','वाहन चालक',101,1,'2025-07-05','31101997',2),(50039,'DIPAK','MADANSING','DOBHAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600681_2025-05-23 16_18_44.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600681_2025-05-23 16_19_16.jpeg','dipakdobhal051@gmail.com','MADANSING','DHAWALABAI','AT PIRWADI POST DHASLA TQ BADNAPUR DIST JALNA','-',0,'9158418958','-','50039','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-06-10','वाहन चालक','open','600681',0,'0','वाहन चालक',101,1,'2025-07-05','10062001',2),(50040,'DEEPAK','BHAGWAT','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600690_2025-05-23 17_33_11.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600690_2025-05-23 17_33_19.jpeg','DEEPAKBJADHAV1992@GMAIL.COM','BHAGWAT MOTIRAM JADHAV','SUREKHA BHAGWAT JADHAV','HOUSE NO.25, STREET NO.03, SIDHHESHWAR COLONY, JADHAVWADI, AURANGABAD ','-',0,'9022339103','-','50040','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-11-06','वाहन चालक','open','600690',0,'0','वाहन चालक',101,1,'2025-07-05','06111992',2),(50041,'SAGAR','REVANATH','KATKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600712_2025-05-23 21_22_12.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600712_2025-05-23 21_22_19.jpeg','sagarkatkar.lic@gmail.com','REVANATh','LATA','PLOT NO 46/47 SIDDHESHWAR COLONy JADHAVWADI','-',0,'9156060402','-','50041','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-09-07','वाहन चालक','open','600712',0,'0','वाहन चालक',101,1,'2025-07-05','07091994',2),(50042,'SURAJ ','MORESHWAR','AHER','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600719_2025-05-23 22_02_31.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600719_2025-05-23 22_02_58.jpeg','ahersuraj8149@gmail.com','MORESHWAR ASARAM AHEr','KUSHAWARTA MORESHWAR AHER','PLOT NO 116 GURUVANDAN APARTMENT NEAR KHIVANSARA Nilgiris  OPP WHITE HOUSe','-',0,'7823899300','-','50042','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2006-02-20','वाहन चालक','open','600719',0,'0','वाहन चालक',101,1,'2025-07-05','20022006',2),(50043,'ANAND ','ASHOKRAO ','KEDARE ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600725_2025-05-24 09_26_47.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600725_2025-05-24 09_27_00.jpeg','anandkedare615@gmail.com','ASHokrao ','MEERA ','PLOT NO 35 S. T COLONY JADHAVWADI HARSOOL ','-',0,'8275321309','-','50043','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-03-08','वाहन चालक','open','600725',0,'0','वाहन चालक',101,1,'2025-07-05','08031993',2),(50044,'ASLAM','MUSHTAK','SHAIKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600780_2025-05-24 16_54_19.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600780_2025-05-24 16_54_28.jpeg','saslam563@gmail.com','MUSHTAK IBRAHIM SHAIKH','AASHUBI','AT POST TAKLI R R  TQ KHULDABAD','-',0,'9665524858','-','50044','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-12-24','वाहन चालक','open','600780',0,'0','वाहन चालक',101,1,'2025-07-05','24121989',2),(50045,'RUSHIKESH','SANJAY','RAUT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600786_2025-05-24 18_33_30.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600786_2025-05-24 18_33_40.jpeg','rautrushikesh085@gmail.com','SANJAY','SUNITA','SAWANGI NAIGAoN PHATA','-',0,'9112831533','-','50045','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-01-21','वाहन चालक','open','600786',0,'0','वाहन चालक',101,1,'2025-07-05','21012001',2),(50046,'NIKHIL','RAMNATH','PANDURE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600823_2025-05-26 15_10_57.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600823_2025-05-26 15_11_05.jpeg','nikhilpandure@gmail.com','RAMNATH PANDURe','SUNITA PANDURe','307, maruti complex,near Sharda school,Vada road, bhiwandi. ','-',0,'7039253567','-','50046','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-05-09','वाहन चालक','open','600823',0,'0','वाहन चालक',101,1,'2025-07-05','09052001',2),(50047,'AKASH ','KISAN','WAGH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600875_2025-05-25 20_59_30.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600875_2025-05-25 20_59_44.jpeg','akashwagh5285@gmail.com','KISAN WAGH','SHILA','AT.AMKHED,POST.AMBASHI,TQ.CHIKHALI, DIST BULDHANA  AT.AMKHED,POST.AMBASHI,TQ.CHIKHALI,DIST.BULDANA','-',0,'7887629960','-','50047','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-04-24','वाहन चालक','open','600875',0,'0','वाहन चालक',101,1,'2025-07-05','24042000',2),(50048,'SHUBHAM','RAJENDRA','PANCHAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600883_2025-05-25 00_01_10.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600883_2025-05-25 00_01_20.jpeg','shubhampanchal8552@gmail.com','RAJENDRA','RASHMI','A-20 Dattaguru CHS Sector 4 Sanpada Navi Mumbai','-',0,'9702441398','-','50048','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-12-05','वाहन चालक','open','600883',0,'0','वाहन चालक',101,1,'2025-07-05','05122000',2),(50049,'GURUDEV','RAMCHANDRA','PATIL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600885_2025-05-25 00_17_26.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600885_2025-05-25 00_17_47.jpeg','Shreepatil220792@gmail.com','RAMCHANDRA PATIL ','SUVARNA PATIL','Shree Krupa Shree siddheshwar temple near phupere','-',0,'9324128955','-','50049','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-07-22','वाहन चालक','open','600885',0,'0','वाहन चालक',101,1,'2025-07-05','22071992',2),(50050,'DATTU','NARAYAN','GAIKWAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600923_2025-06-01 13_18_03.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600923_2025-06-01 13_18_16.jpeg','gaikwaddattu@gmail.com','NARAYAN KHANDU GAIKWAD','MAINABAI','AT RAMANAGAR ,KANNAD DIS.CHA. SAMBHAJINAGAR PIN 431104 ','-',0,'9922824854','-','50050','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-04-22','वाहन चालक','open','600923',0,'0','वाहन चालक',101,1,'2025-07-05','22041995',2),(50051,'SAGAR','PRAKASH','BOTRE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600957_2025-05-25 16_04_03.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600957_2025-05-25 16_04_17.jpeg','SAGARBOTRE230@GMAIL.COM','PRAKASH','VIJAYA','S No-110,Ashirwad Colony,Dhanori Road, Vishrantwadi,Near Jagaram Complex,Pune-411015','-',0,'9767959663','-','50051','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-10-17','वाहन चालक','open','600957',0,'0','वाहन चालक',101,1,'2025-07-05','17101990',2),(50052,'KAKASAHEB','RANGNATH','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600974_2025-05-26 16_29_36.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600974_2025-05-26 16_28_28.jpeg','Kakapawar500@gmail.com','RANGnath ','LILABAi','AT DONWADA CH.SAMBHAJINAGAr AT DONWADA.CH.SAMBHAJINAGAr','-',0,'8698039181','-','50052','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1999-01-24','वाहन चालक','open','600974',0,'0','वाहन चालक',101,1,'2025-07-05','24011999',2),(50053,'BHARAT','SHIVAJI','AMBHORE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_600982_2025-05-25 18_56_05.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_600982_2025-05-25 18_56_22.jpeg','bharatambhore8087@gmail.com','SHIVAJI','KALAVATI','AT POST MANGRUL NAVGHARE TQ CHIKHLI DIST BULDHANA','-',0,'8087807011','-','50053','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-11-24','वाहन चालक','open','600982',0,'0','वाहन चालक',101,1,'2025-07-05','24111991',2),(50054,'GAJANAN','SUKA','RATHOD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601002_2025-05-25 21_32_18.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601002_2025-05-25 21_31_57.jpeg','gajananrathod181989@gmail.com','SUKA RATHOd','SAVITRIBAi','3rd floor room no 10 shivneri co Housing society Vijay nagar Kalyan East','-',0,'9967497284','-','50054','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-08-01','वाहन चालक','open','601002',0,'0','वाहन चालक',101,1,'2025-07-05','01081989',2),(50055,'SWARAJ','RAJENDRA ','WAGH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601007_2025-05-25 21_17_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601007_2025-05-25 21_17_46.jpeg','swarajwagh3737@gmail.com','RAJENDRA','ANITa','AT POST CHAUKA TQ DIST CHHATRAPATI SAMBAJINAGAR ','-',0,'9665659894','-','50055','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-04-08','वाहन चालक','open','601007',0,'0','वाहन चालक',101,1,'2025-07-05','08042001',2),(50056,'ARJUN','BABULAL','BIGHOT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601028_2025-05-26 08_34_44.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601028_2025-05-26 08_37_31.jpeg','arjunbighot4@gmail.com','BABULAL BIGHOt','BABULAL BIGHOt','AT. JAWKHEDA  Bk ','-',0,'9823566854','-','50056','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-07-16','वाहन चालक','open','601028',0,'0','वाहन चालक',101,1,'2025-07-05','16071994',2),(50057,'AMOL','SHESHRAO','NIKAM','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601036_2025-05-26 09_15_55.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601036_2025-05-26 09_16_14.jpeg','amolnikam281290@gmail.com','SHESHRAO NIKAm','NIRMALA NIKAm','AT POST KESAPUR TQ DIST BULDANa NEAR ZP SCHOOL KESAPUr','-',0,'8552894028','-','50057','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-12-28','वाहन चालक','open','601036',0,'0','वाहन चालक',101,1,'2025-07-05','28121990',2),(50058,'GOPAL','BABASAHEB','CHAUDHARI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601062_2025-05-26 11_44_23.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601062_2025-05-26 11_44_43.jpeg','gopalchaudhari7775@gmail.com','BABASAHEB','LAXMI','CHAUDHARI COLONY CHIKALTHANA','-',0,'7775921507','-','50058','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2002-04-03','वाहन चालक','open','601062',0,'0','वाहन चालक',101,1,'2025-07-05','03042002',2),(50059,'ROHIT','PRAKASH','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601076_2025-05-28 14_55_52.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601076_2025-05-28 14_55_04.jpeg','rohitjadhav18379@gmail.com','PRAKASH','SHUBHANGI','PLOT NO 32 SEC 3 FLAT 201 SKYLINE CORNER KARANJADe KARANJADE PANVEl','-',0,'9834377432','-','50059','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-06-24','वाहन चालक','open','601076',0,'0','वाहन चालक',101,1,'2025-07-05','24061990',2),(50060,'BALKRISHNA','PRAKASH','THORAT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601140_2025-05-30 10_39_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601140_2025-05-30 10_39_58.jpeg','krushnathorat9202@gmail.com','PRAKASh','SUNITa','AT BOMBALEWADi SHALGAOn','-',0,'7028454516','-','50060','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-01-14','वाहन चालक','open','601140',0,'0','वाहन चालक',101,1,'2025-07-05','14011998',2),(50061,'KARAN','APPASAHEB','PALASKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601155_2025-05-27 21_11_15.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601155_2025-05-27 21_07_02.jpeg','shirishbadag214@gmail.com','APPASAHEB SHESHRAO PALASKAR ','BHIMABAI APPASAHEB PALASKAR','AT POST PALASHI SHAHAr PALASHI SHAHAR MAIN RAOD NEAR MARUTI MANDIr','-',0,'9421419939','-','50061','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-05-13','वाहन चालक','open','601155',0,'0','वाहन चालक',101,1,'2025-07-05','13052000',2),(50062,'SANKET','RAMESH','BALANDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601156_2025-05-26 20_57_37.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601156_2025-05-26 21_00_27.jpeg','sanketbalande6262@gmail.com','RAMESH','MIRA','AT BORGAON ARJ TQ PHULAMBRI DIST CHH SAMBHAJINAGAR','-',0,'6262101026','-','50062','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-09-13','वाहन चालक','open','601156',0,'0','वाहन चालक',101,1,'2025-07-05','13092000',2),(50063,'SACHIN','RAMESH','SARODE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601165_2025-05-26 21_24_59.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601165_2025-05-26 21_25_23.jpeg','sachinsarode7506@gmail.com','RAMESH','CHHaYA','CHAWL NO 9 ROOM NO 102 LABOUR CAMp','-',0,'8169610276','-','50063','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1987-06-10','वाहन चालक','open','601165',0,'0','वाहन चालक',101,1,'2025-07-05','10061987',2),(50064,'SHANKAR','MAROTI','MANJARME','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601183_2025-05-26 23_06_25.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601183_2025-05-26 23_06_33.jpeg','shankarmanjarme1998@gmail.com','MAROTI','REKHABAI','S/O. MAROTI MANJARME FRONT OF BALAJI MANDIR','-',0,'9860681841','-','50064','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-11-07','वाहन चालक','open','601183',0,'0','वाहन चालक',101,1,'2025-07-05','07111998',2),(50065,'AKSHAY ','SANJAY','AMLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601192_2025-05-27 06_58_11.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601192_2025-05-27 06_58_51.jpeg','amlea471@gmail.com','SANJAy','SUNITA ','H/N 147,NEAR HANUMAN MANdir  BAJRANG CHOWK ,PADEGAOn','-',0,'9158182729','-','50065','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-10-15','वाहन चालक','open','601192',0,'0','वाहन चालक',101,1,'2025-07-05','15101997',2),(50066,'SATISH','NAYHALSINGH','SUNDARDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601194_2025-05-27 07_59_48.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601194_2025-05-27 07_52_02.jpeg','satishsundarde2015@gmail.com','Nyahalsingh ','RUKHAmanbai ','Krushnpurwadi Sawangi harsul','-',0,'9049379284','-','50066','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-10-08','वाहन चालक','open','601194',0,'0','वाहन चालक',101,1,'2025-07-05','08101995',2),(50067,'DIPAK ','SHIVAJI ','GAWALI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601199_2025-05-27 08_36_57.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601199_2025-05-27 08_38_22.jpeg','s9158659330@gmail.com','SHIVAJI DEUBA GAWALI ','PRABHAVTABAI ','AT WADHONA POST DHAWDA  ','-',0,'9637611409','-','50067','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-05-25','वाहन चालक','open','601199',0,'0','वाहन चालक',101,1,'2025-07-05','25051996',2),(50068,'AMAR','VISHWANATH','GAWALI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601210_2025-05-27 11_08_00.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601210_2025-05-27 11_10_39.jpeg','amargawalipatil@gmail.com','VISHWANATH BALAJI GAWALi','JAYSHRI VISHWANATH GAWALi','AMBIKA NAGAR  VERUl','-',0,'9552393001','-','50068','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-09-20','वाहन चालक','open','601210',0,'0','वाहन चालक',101,1,'2025-07-05','20091994',2),(50069,'ANAND','BHAGWAT','SHINGARE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601216_2025-05-27 10_43_13.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601216_2025-05-27 10_43_19.jpeg','anandshingare111@gmail.com','BHAGWAT ','MANDAKINI','JADHAV GALLI DHARUR POST DHARUR','-',0,'8956483348','-','50069','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-01-01','वाहन चालक','open','601216',0,'0','वाहन चालक',101,1,'2025-07-05','01011997',2),(50070,'KRUSHNA','NAGANATH','BHOPE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601234_2025-05-27 12_14_10.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601234_2025-05-27 12_15_48.jpeg','krushnabhope0@gmail.com','NAGANATh','LAXMEEBAi','AT.POST.UNDEGAON  ','-',0,'8080726924','-','50070','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-07-05','वाहन चालक','open','601234',0,'0','वाहन चालक',101,1,'2025-07-05','05071998',2),(50071,'AKSHAY','KISAN','JARHAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601250_2025-05-27 13_31_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601250_2025-05-27 13_32_34.jpeg','akshayjarhad.7194@gmail.com','KISAN','SAVITA','DHANGAR GALLI HATGAON','-',0,'8329009599','-','50071','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-06-07','वाहन चालक','open','601250',0,'0','वाहन चालक',101,1,'2025-07-05','07061998',2),(50072,'MAHESH ','NATHA','PALVE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601262_2025-05-30 13_31_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601262_2025-05-30 13_32_07.jpeg','maheshpalve063@gmail.com','NATHA ','SANGITA','Prabhakar Patil, House At- Belavali Gaon,','-',0,'8605285233','-','50072','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-11-18','वाहन चालक','open','601262',0,'0','वाहन चालक',101,1,'2025-07-05','18111993',2),(50073,'VISHAL','PANDURANG','WAKUDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601270_2025-05-27 15_54_19.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601270_2025-05-27 15_54_36.jpeg','vishalpwakude358@gmail.com','PANDURANG BALIRAM WAKUDE','VIJAYA','AT TARODI POST KENWAD','-',0,'9075756724','-','50073','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-05-14','वाहन चालक','open','601270',0,'0','वाहन चालक',101,1,'2025-07-05','14051991',2),(50074,'YOGESH','KRUSHNA','PHALKE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601274_2025-05-27 15_56_35.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601274_2025-05-27 15_56_50.jpeg','phalkeyogesh1993@gmail.com','KRUSHNA PHALKE','RANJANA PHALKE','PLOT NO 348 S.NO 22 NEW HANUMAN NAGAR','-',0,'9970614753','-','50074','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-09-17','वाहन चालक','open','601274',0,'0','वाहन चालक',101,1,'2025-07-05','17091993',2),(50075,'BABASAHEB','EKNATH','DEVKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601275_2025-05-27 17_20_00.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601275_2025-05-27 17_20_19.jpeg','babasahebdevkar98@gmail.com','EKNATH ABAJI DEVKAr','VIJAYKALA EKNATH DEVKAr','AT POST BHALGAOn BHALGAOn','-',0,'7387572330','-','50075','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-07-20','वाहन चालक','open','601275',0,'0','वाहन चालक',101,1,'2025-07-05','20071996',2),(50076,'GANESH','SAMPAT','SHINDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601288_2025-05-27 18_09_31.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601288_2025-05-27 18_09_40.jpeg','shivajimaharaj5488@gmail.com','SAMPAT VITHOBA SHINDE','SINDHU SAMPAT SHINDE','OPP NAVJIVAN SOCEITY KOKAN NAGAR  BEST CHAWL NO 4 ROOM NO 2 RC MARG ','-',0,'8108115488','-','50076','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1988-04-05','वाहन चालक','open','601288',0,'0','वाहन चालक',101,1,'2025-07-05','05041988',2),(50077,'IMRAN','BABAR','MULLA','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601304_2025-05-27 20_18_35.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601304_2025-05-27 20_18_45.jpeg','mullaimran197@gmail.com','BABAr','HAMEEDa','128/12 VISHNU MILL CHAL DONGAON ROAD SOLAPUR','-',0,'9823573834','-','50077','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-02-23','वाहन चालक','open','601304',0,'0','वाहन चालक',101,1,'2025-07-05','23021991',2),(50078,'ANANDSING','BABULAL ','SHIHIRE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601311_2025-05-27 21_30_33.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601311_2025-05-27 21_30_45.jpeg','ar6917985@gmail.com','BABulal ','BARKAbai ','H.NO,04,AMBIKANAGAR LANE NO.06,NEAR DESHMUKH COMPLAX MUKUNDWADI AURANGABAd ','-',0,'9922744442','-','50078','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-07-16','वाहन चालक','open','601311',0,'0','वाहन चालक',101,1,'2025-07-05','16071993',2),(50079,'ALANKAR','MADAN','GUNJAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601316_2025-05-28 22_58_36.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601316_2025-05-28 22_58_16.jpeg','alankargunjal38@gmail.com','MADAn','VANDANa','FLAT NO 13 SAI AANGAN APARTMENT KADVE NAGAR NEAR SHELAR HALL ','-',0,'8623976916','-','50079','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-06-26','वाहन चालक','open','601316',0,'0','वाहन चालक',101,1,'2025-07-05','26061989',2),(50080,'DINKAR ','BALBHIM ','SASE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601321_2025-05-28 07_28_30.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601321_2025-05-28 07_23_46.jpeg','sasedinkar1999@gmail.com','BALBHIM MANJABAPU SASE ','SANGITA ','AT PO SHINGAVE KEAHAV TALUKA PATHARDI DISTRICT AHILYANAGAR  ','-',0,'8408862521','-','50080','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1999-01-26','वाहन चालक','open','601321',0,'0','वाहन चालक',101,1,'2025-07-05','26011999',2),(50081,'VISHAL','RAMSING','BARVAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601333_2025-05-28 10_53_10.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601333_2025-05-28 10_53_20.jpeg','ranavishal4969@gmail.com','RAMSING ','BHAGABAI','AT MURADABAD POST ADOOL BK TQ PAITHAN DIST CHH. SAMBHAJINAGAR','-',0,'8080762329','-','50081','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-11-26','वाहन चालक','open','601333',0,'0','वाहन चालक',101,1,'2025-07-05','26112000',2),(50082,'RAMESH','DWARKADAS','HARANE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601334_2025-05-28 11_02_18.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601334_2025-05-28 11_02_25.jpeg','rameshharne0560@gmail.com','DWARKADAS HARANE','SHOBHA DWARKADAS HARANE','SARVEY NO.154 GOKUL NAGAR','-',0,'9011754847','-','50082','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-09-16','वाहन चालक','open','601334',0,'0','वाहन चालक',101,1,'2025-07-05','16091994',2),(50083,'LAKHAN','RAJKUMAR','THAKUR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601341_2025-05-28 11_39_48.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601341_2025-05-28 11_40_33.jpeg','lakhanthakur803@gmail.com','RAJKUMAR','SHAKUNTALA','KOLHE NAGAR LATUR LATUR','-',0,'7875875871','-','50083','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-05-05','वाहन चालक','open','601341',0,'0','वाहन चालक',101,1,'2025-07-05','05051990',2),(50084,'VITTHAL ','GANESH ','MANE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601349_2025-05-28 12_39_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601349_2025-05-28 12_42_42.jpeg','aryamane397@gmail.com','GANESH MANe','SUBHADRABAI ','AT. BABHULAGAON  ( BK.) POST. BANKINHOLA ','-',0,'9309799193','-','50084','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-01-04','वाहन चालक','open','601349',0,'0','वाहन चालक',101,1,'2025-07-05','04011993',2),(50085,'SHUBHAM','DATTATRAY','KASAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601353_2025-05-28 12_42_17.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601353_2025-05-28 12_42_34.jpeg','skasar614@gmail.com','DATATRAY','SWATI','MOTHI ALI KHULTABAD KHULTABAD','-',0,'9689815004','-','50085','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-05-08','वाहन चालक','open','601353',0,'0','वाहन चालक',101,1,'2025-07-05','08051997',2),(50086,'AKSHAY','DILIP','KHARAT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601380_2025-05-28 15_21_32.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601380_2025-05-28 15_18_18.jpeg','kharatakshay659@gmail.com','DILIP','SHAILABAI','H NO D 6 29 BEHIND FAMILY CORT KRANTI NAGAR CHH SAMBHAJI NAGAR','-',0,'7972790932','-','50086','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-09-24','वाहन चालक','open','601380',0,'0','वाहन चालक',101,1,'2025-07-05','24091997',2),(50087,'PAVAN','VASRAM','CHAVHAN','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601389_2025-05-28 15_44_10.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601389_2025-05-28 15_44_20.jpeg','pavanchavhan081@gmail.com','VASRAM AMARSING CHAVHAn','RATNAKALA VASRAM CHAVHAn','AT POST TIWASa TQ YAVATMAl','-',0,'7218719821','-','50087','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-01-08','वाहन चालक','open','601389',0,'0','वाहन चालक',101,1,'2025-07-05','08012000',2),(50088,'YOGESH','BALASAHEB','KHARAT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601391_2025-05-28 16_40_55.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601391_2025-05-28 16_40_09.jpeg','YOGESHK435300@GMAIL.COM','KHARAT BALASAHEB LAXMAN','VANDANA','near rammandir gandhinagar chitegaon','-',0,'9503434169','-','50088','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-01-15','वाहन चालक','open','601391',0,'0','वाहन चालक',101,1,'2025-07-05','15011996',2),(50089,'SANTOSH','PARAJI','DHANGE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601394_2025-05-28 18_56_29.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601394_2025-05-28 19_05_55.jpeg','santoshdhange01@gmail.com','PARAJI AMBADAS DHANGe','SAVITRA PARAJI DHANGe','PLOT NO.73 SHIVPARK SOCIETY, CAMBRIDGE SCHOOL   SAWANGI BY PASS ROAD, CHIKHALTHANa','-',0,'9527921271','-','50089','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-07-28','वाहन चालक','open','601394',0,'0','वाहन चालक',101,1,'2025-07-05','28071994',2),(50090,'RUSHIKESH','SANJAY','GAVALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601403_2025-05-28 17_46_25.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601403_2025-05-28 17_48_18.jpeg','rushigavale5130@gmail.com','SANJAY','SHUBHANGI','VIHAMANDWA VIHAMANDWA','-',0,'8408925354','-','50090','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-02-10','वाहन चालक','open','601403',0,'0','वाहन चालक',101,1,'2025-07-05','10021998',2),(50091,'SACHIN','RATAN','TELANGRE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601430_2025-05-28 21_20_17.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601430_2025-05-28 21_21_02.jpeg','smtelangre@gmail.com','RATAN SAKHARAM TELANGRe','KAMALBAI RATAN TELANGRe','AT.PO. WALSA WADALA TQ BHOKARDAN DIST JALANa ','-',0,'9923690047','-','50091','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-01-16','वाहन चालक','open','601430',0,'0','वाहन चालक',101,1,'2025-07-05','16011993',2),(50092,'GOPAL','DEVIDAS ','YEWATKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601431_2025-05-28 21_29_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601431_2025-05-28 21_29_56.jpeg','gopalyewatkar154@gmail.com','DEVIDAS','BEBITAI','AT KHOLAPURI GATE  MALIYE PURA DARYAPUR ','-',0,'9130166350','-','50092','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-06-27','वाहन चालक','open','601431',0,'0','वाहन चालक',101,1,'2025-07-05','27061995',2),(50093,'SURAJ','RAJU','JONWAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601482_2025-05-29 12_00_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601482_2025-05-29 12_00_36.jpeg','jonwalsuraj50@gmail.com','RAJU','LATABAI','AT.LANADAKWADI POST KHODEGAON  TQ CHHATRAPATI SAMBHAJINAGAR ','-',0,'9356200966','-','50093','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2003-03-05','वाहन चालक','open','601482',0,'0','वाहन चालक',101,1,'2025-07-05','05032003',2),(50094,'AJAY','VIJAY','BHOSALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601497_2025-05-29 13_49_37.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601497_2025-05-29 13_49_54.jpeg','ajaybhosale7897@gmail.com','VIJAY','ANITA','konchi ','-',0,'9834439958','-','50094','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-12-28','वाहन चालक','open','601497',0,'0','वाहन चालक',101,1,'2025-07-05','28121993',2),(50095,'DNYANDEO','SHESHRAO','CHINTAMANI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601507_2025-05-29 15_17_43.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601507_2025-05-29 15_17_52.jpeg','chintamaninamdev@gmail.com','SHESHRAo','SUSHILa','AT ADGAON POST ANTARWALI KHANDi TQ PAITHAN DIST CHH SAMBHAJINAGAr','-',0,'8888544471','-','50095','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-07-18','वाहन चालक','open','601507',0,'0','वाहन चालक',101,1,'2025-07-05','18071989',2),(50096,'DIPAK ','SOPAN','CHIKTE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601519_2025-05-30 14_53_57.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601519_2025-05-30 14_56_39.jpeg','dipakchikte610@gmail.com','SOPAN LAXMAN CIKATe','NANUBAI SOPAN CIKATe','AT.TANDULWADI PO. TANDA BAJAR TQ.BHOKARDAN DIST.JALNa ','-',0,'7020492015','-','50096','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-07-03','वाहन चालक','open','601519',0,'0','वाहन चालक',101,1,'2025-07-05','03071996',2),(50097,'NARAYAN','SHIVAJIRAO','AGHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601524_2025-05-29 18_35_45.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601524_2025-05-29 18_36_12.jpeg','nsaghav@gmail.com','SHIVAJi','SHINDHu','BELKHEDA .PACHLEGON  .JINTUR. PARBHANI BELKHEDA.PACHLEGAON. JINTUR.PARBHANI','-',0,'8605901431','-','50097','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-07-01','वाहन चालक','open','601524',0,'0','वाहन चालक',101,1,'2025-07-05','01071995',2),(50098,'MANGESH','RAJU','PARASKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601527_2025-05-29 19_04_01.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601527_2025-05-29 19_04_10.jpeg','priyankasahare1991@gmail.com','RAJU PARASKAR','KANTA PARASKAR','AMBEDKAR NAGAR, JAY BHIM CHOWK TQ.DIST.YAVATMAL','-',0,'8855097276','-','50098','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-09-03','वाहन चालक','open','601527',0,'0','वाहन चालक',101,1,'2025-07-05','03091996',2),(50099,'DHANANJAY','GANESH','JAGTAP','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601536_2025-05-29 19_34_48.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601536_2025-05-29 19_34_42.jpeg','dhananjayjagtap50@gmail.com','GANESH JAGTAP','RAJAMATI JAGTAP','AT POST BHATANGALI TQ LOHARA','-',0,'8888275345','-','50099','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-01-05','वाहन चालक','open','601536',0,'0','वाहन चालक',101,1,'2025-07-05','05011992',2),(50100,'ALTAF KHAN','WAHAB','KHAN','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601541_2025-05-29 19_56_47.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601541_2025-05-29 19_57_00.jpeg','altafkhan171715@gmail.com','WAHAB KHAN','KHAIRUNNISA','AT MATHANI POST GARADGAON','-',0,'9075171715','-','50100','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-10-01','वाहन चालक','open','601541',0,'0','वाहन चालक',101,1,'2025-07-05','01101997',2),(50101,'MAYUR','PRABHAKAR','DEVRE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601543_2025-05-29 19_51_53.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601543_2025-05-29 19_52_16.jpeg','mayurdevre6@gmail.com','PRABHAKAR DEVRE','LANKABAI DEVRE','HOUSE NO 346 GALLI NO 3 NEAR BHUSHAN MEDICAL NEW HANUMAAN NAGAR ','-',0,'8080691002','-','50101','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2002-03-10','वाहन चालक','open','601543',0,'0','वाहन चालक',101,1,'2025-07-05','10032002',2),(50102,'SAYYAD KAYYUM','AYYUB','SAYYAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601569_2025-05-31 16_10_47.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601569_2025-05-31 16_11_17.jpeg','kayyumsayyad1411@gmail.com','AYYUB SAYYAD','SHAKILA','JILHA PARISHAD DAG BANGALA ROAD','-',0,'7620024599','-','50102','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-11-14','वाहन चालक','open','601569',0,'0','वाहन चालक',101,1,'2025-07-05','14111995',2),(50103,'SUNIL','FAKIRCHAND','GUSINGE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601585_2025-05-30 10_21_39.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601585_2025-05-30 10_21_51.jpeg','sunilgusinge1@gmail.com','FAKIRCHANd','LALABAi','AT MURADABAD POST ADUl ','-',0,'9637013458','-','50103','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-05-14','वाहन चालक','open','601585',0,'0','वाहन चालक',101,1,'2025-07-05','14051992',2),(50104,'NAVNATH','LAXMAN','KARHALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601586_2025-05-30 10_15_22.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601586_2025-05-30 10_15_33.jpeg','karhalen8@gmail.com','LAXMAN KARHALE','INDUBAI KARHALE','Bori 1home','-',0,'7378759032','-','50104','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-10-28','वाहन चालक','open','601586',0,'0','वाहन चालक',101,1,'2025-07-05','28101989',2),(50105,'PRATIK','VIKRAM','PATIL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601602_2025-06-01 23_08_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601602_2025-06-01 23_08_36.jpeg','sunnypatil5153@gmail.com','VIKRAM ','KRANTI','AP-TAMBAVE ,  TAL-KARAD','-',0,'9322200207','-','50105','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-07-03','वाहन चालक','open','601602',0,'0','वाहन चालक',101,1,'2025-07-05','03072001',2),(50106,'DHANDNJAY','DINKAR','THITE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601616_2025-05-30 13_52_58.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601616_2025-05-30 13_53_10.jpeg','danupatil62@gmail.com','DINKAr','GODAVARi','AT.WARUD NARSIHA TA JINTUR PARBHANi ','-',0,'9325664188','-','50106','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2005-02-22','वाहन चालक','open','601616',0,'0','वाहन चालक',101,1,'2025-07-05','22022005',2),(50107,'GAJANAN','PANDHARI','PALODE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601651_2025-05-30 17_43_52.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601651_2025-05-30 17_47_27.jpeg','gajananpalode123@gmail.com','PANDHARI','CHANDRAKALABAI','AT CHANDAPUR POST MANGRUL TQ SILLOD','-',0,'7972763611','-','50107','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-05-15','वाहन चालक','open','601651',0,'0','वाहन चालक',101,1,'2025-07-05','15051992',2),(50108,'SAGAR','BHASKAR','NIKAM','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601659_2025-06-02 21_55_41.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601659_2025-06-02 21_55_53.jpeg','sagarnikam1657@gmail.com','BHASKAR','ALKA','PLOTT NO. 29,  MARUTI NAGAR, MAYUR PARK','-',0,'7758864572','-','50108','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-05-14','वाहन चालक','open','601659',0,'0','वाहन चालक',101,1,'2025-07-05','14051995',2),(50109,'SHUBHAM','SUBHASH','PATIL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601667_2025-05-30 20_07_25.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601667_2025-05-30 20_07_04.jpeg','sp36536@gmail.com','SUBHASH','SANGITA','NBH 6 NEW BALAJI NAGAR AURANGABAD ','-',0,'9730202610','-','50109','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-10-07','वाहन चालक','open','601667',0,'0','वाहन चालक',101,1,'2025-07-05','07101996',2),(50110,'MAHESH','MILIND','SABLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601676_2025-05-30 21_37_08.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601676_2025-05-30 21_37_24.jpeg','maheshsable94@gmail.com','MILIND KASHINATH SABLE','RAJESHREE','NEAR DR AMBEDKAR STATUE BAPUNAGAR','-',0,'8855095557','-','50110','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-11-06','वाहन चालक','open','601676',0,'0','वाहन चालक',101,1,'2025-07-05','06111989',2),(50111,'SADASHIV ','DAGDIRAM ','PHAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601694_2025-06-02 19_41_07.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601694_2025-06-02 19_41_42.jpeg','sadashiv07phad@gmail.com','DAGDIRAM HARIBHAU Phad ','RUKMIN ','AT dhebewadi  POST DONGArpimpla ','-',0,'7028774341','-','50111','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-05-03','वाहन चालक','open','601694',0,'0','वाहन चालक',101,1,'2025-07-05','03051993',2),(50112,'AMOL','SANJAY','FUKE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601698_2025-05-31 08_57_29.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601698_2025-05-31 08_57_43.jpeg','amolfuke10@gmail.com','SANJAY FUKE','LANKABAI FUKe','AT TAKLI JIWRAG POST KAIGAOn ','-',0,'9766842702','-','50112','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-05-15','वाहन चालक','open','601698',0,'0','वाहन चालक',101,1,'2025-07-05','15051998',2),(50113,'VISHAL ','BHAGAWAT ','KHOBRAGADE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601712_2025-05-31 11_39_36.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601712_2025-05-31 11_40_29.jpeg','vishalkhobragade26896@gmail.com','BHAGAWAT ','DAMYANTI ','N41/AF3/1/10 VIJAY NAGAR CIDCO NASHIK  N41/AF3/1/10 VIJAY NAGAR CIDCO NASHIK ','-',0,'8855810105','-','50113','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-08-26','वाहन चालक','open','601712',0,'0','वाहन चालक',101,1,'2025-07-05','26081996',2),(50114,'MAHADEO','MAROTI','SAROKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601737_2025-05-31 13_09_46.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601737_2025-05-31 13_10_10.jpeg','mahadevsarokh@gmail.com','MAROTI','ANITA','AT NAKHEGAON POST TARNOLI TQ DARWHA DIST YAVATMAL','-',0,'9130455600','-','50114','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-11-01','वाहन चालक','open','601737',0,'0','वाहन चालक',101,1,'2025-07-05','01111992',2),(50115,'PRADEEP','SHESHRAO','KOLTE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601739_2025-05-31 13_19_10.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601739_2025-05-31 13_19_17.jpeg','pradeepkolte88@gmail.com','SHESHRAO KOLTe','KASTURI KOLTe','POLICE QUARTER SARVE NO 488 HOUUSE NO 100','-',0,'8857084095','-','50115','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1999-04-13','वाहन चालक','open','601739',0,'0','वाहन चालक',101,1,'2025-07-05','13041999',2),(50116,'SANDEEPAN','MANSUBRAO','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601745_2025-05-31 14_26_34.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601745_2025-05-31 14_28_11.jpeg','sandipj754@gmail.com','MANSUBRAO','MANGALBAI','N12 F116 SWAMIVIVEKANANAD NAGAR  HUDCO','-',0,'9890985123','-','50116','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-08-15','वाहन चालक','open','601745',0,'0','वाहन चालक',101,1,'2025-07-05','15081995',2),(50117,'ALTAF','RASHID','SHAIKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601759_2025-05-31 17_28_36.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601759_2025-05-31 17_28_55.jpeg','SHAIKHALTA9343@GMAIL.COM','RASHID','KHALEDABI','PLOT NO 48 S NO 130 ARTI NAGAR  PISADEVI ROAD ','-',0,'9960080078','-','50117','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-05-28','वाहन चालक','open','601759',0,'0','वाहन चालक',101,1,'2025-07-05','28052000',2),(50118,'SAGAR','MANGESHRAO','GAIKWAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601767_2025-05-31 16_55_21.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601767_2025-05-31 16_55_28.jpeg','monalijondhale2017@gmail.com','MANGESHRAO','ASHA','CIDCO N 2 M1 16/4 RAM NAGAR AURANGABAD','-',0,'8975664648','-','50118','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-10-09','वाहन चालक','open','601767',0,'0','वाहन चालक',101,1,'2025-07-05','09101991',2),(50119,'SHUBHAM','RAMESH','VARPE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601815_2025-05-31 21_01_39.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601815_2025-05-31 21_02_30.jpeg','shubamvarpe3424@gmail.com','RAMESH VARPe','LAXMIBAI VARPe','NEAR TULJA BHAWANIMATA MANDIR, FAKIRWADI, AURANGABAd ','-',0,'9637591017','-','50119','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-12-11','वाहन चालक','open','601815',0,'0','वाहन चालक',101,1,'2025-07-05','11122000',2),(50120,'SAGAR','RAJENDRA','SHENDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601846_2025-06-01 09_11_21.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601846_2025-06-01 09_12_25.jpeg','shendesagar3107@gmail.com','RAJENDRA','PRATIBHA','NANDGAON PETH AMRAVATI','-',0,'7720969314','-','50120','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2003-07-31','वाहन चालक','open','601846',0,'0','वाहन चालक',101,1,'2025-07-05','31072003',2),(50121,'SUJAL','MOTILAL','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601854_2025-06-01 10_40_15.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601854_2025-06-01 10_40_22.jpeg','sujalpawar5636@gmail.com','MOTILAL','VAISHALI','AT BORWADI TANDA POST KHAMKHEDA','-',0,'9764571325','-','50121','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2004-01-12','वाहन चालक','open','601854',0,'0','वाहन चालक',101,1,'2025-07-05','12012004',2),(50122,'SHANKAR','RANGNATH','SHELKE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601858_2025-06-01 10_56_34.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601858_2025-06-01 10_56_42.jpeg','shankarshelke92@gmail.com','RANGNATH','SINDUBAI','N 12 E F 44/05 SHIV CHHATRAPATI NAGAR','-',0,'9595959143','-','50122','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-03-25','वाहन चालक','open','601858',0,'0','वाहन चालक',101,1,'2025-07-05','25031992',2),(50123,'SHRAVAN','DAMU','GAWALI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601860_2025-06-01 14_13_59.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601860_2025-06-01 14_16_16.jpeg','shrawangavali@gmail.com','DAMU','JAYAWANTABAI','AT SUNDARWADI  POST WALSAVANGI','-',0,'8983863261','-','50123','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-04-15','वाहन चालक','open','601860',0,'0','वाहन चालक',101,1,'2025-07-05','15041995',2),(50124,'SAGAR','DHANRAJ','MAHORE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601882_2025-06-01 12_02_09.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601882_2025-06-01 12_02_22.jpeg','sagar.mahore1771@gmail.com','DHANRAJ PREMRAJ MAHORE','ALKA','H NO 5/13/55 MAMA CHOWK AURANGABAD','-',0,'9373139758','-','50124','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-06-04','वाहन चालक','open','601882',0,'0','वाहन चालक',101,1,'2025-07-05','04061991',2),(50125,'HARSHAL','WASUDEO','GHODE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601883_2025-06-01 12_44_15.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601883_2025-06-01 12_44_28.jpeg','harshghode113@gmail.com','WASUDEO GOVINDRAO GHODe','MADHURI WASUDEO GHODe','NEAR MATOSHRI SCHOOL KHANKE LAY-OUt D.G,TUKUm','-',0,'9579478666','-','50125','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-02-21','वाहन चालक','open','601883',0,'0','वाहन चालक',101,1,'2025-07-05','21021990',2),(50126,'PRAKASH','KARBHARI','NALAWADE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601885_2025-06-01 12_29_37.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601885_2025-06-01 12_24_08.jpeg','prakashpatil2184@gmail.com','KARBHARI','ASHABAi','ohar post jatwada ohar jatwada','-',0,'8788487382','-','50126','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-04-07','वाहन चालक','open','601885',0,'0','वाहन चालक',101,1,'2025-07-05','07042000',2),(50127,'ZAFAR','ZAHOOR','SHAIKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601890_2025-06-01 12_41_38.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601890_2025-06-01 12_41_46.jpeg','zafarshaikh218@gmail.com','TEHZIN FATEMa','SHEHNAZ  BEGUm','KATKAT GATE NEHRU NAGAr NEAR SHALIMAR HOTEl','-',0,'8087490883','-','50127','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1988-01-01','वाहन चालक','open','601890',0,'0','वाहन चालक',101,1,'2025-07-05','01011988',2),(50128,'VIJAY','GANPAT','TALEKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601898_2025-06-01 13_40_15.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601898_2025-06-01 13_40_45.jpeg','jaygunvantbaba27@gmail.com','GANPAT TALEKAR','YASHODABAI','AT POST CHANDAI ekko  .','-',0,'7767828859','-','50128','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-06-12','वाहन चालक','open','601898',0,'0','वाहन चालक',101,1,'2025-07-05','12061993',2),(50129,'SANJAY','NARAYAN','CHATE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601903_2025-06-01 13_47_18.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601903_2025-06-01 13_47_25.jpeg','sanjaychate8899@gmail.com','NARAYAN','SAKHUBAI','RADHASWAMI COLONy JATWADA ROAD','-',0,'9370958684','-','50129','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-06-05','वाहन चालक','open','601903',0,'0','वाहन चालक',101,1,'2025-07-05','05061992',2),(50130,'ATMARAM','KARBHARI','GHUGE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601905_2025-06-01 18_39_56.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601905_2025-06-01 18_34_47.jpeg','atmaramghuge123@gmail.com','KARBHARI LIMBA GHUGe','YAMUNABAI KARBHARI GHUGe','AT KANKORA POST CHOUKA TQ DIST CHHATRAPATI SAMBHAJINAGAR AT KANKORA PO CHOUKA TQ DIST CHHATRAPATI SAMBHAJINAGAr','-',0,'9637845214','-','50130','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-11-04','वाहन चालक','open','601905',0,'0','वाहन चालक',101,1,'2025-07-05','04111995',2),(50131,'MAHESH','DILIP','MAGAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601906_2025-06-01 14_06_03.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601906_2025-06-01 14_06_17.jpeg','magarmahesh1990@gmail.com','DILIP BHANUDAS MAGAR','SAVITA','AT POST WARUDA TQ DIST DHARASHIV','-',0,'9049367368','-','50131','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-08-14','वाहन चालक','open','601906',0,'0','वाहन चालक',101,1,'2025-07-05','14081990',2),(50132,'SHUBHAM','VILAS','SATHE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601913_2025-06-01 14_50_10.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601913_2025-06-01 14_50_46.jpeg','satheshubham300@gmail.com','VILAS VITHOBA SATHE','KALPANA ','At. Post. Narayandoho Tal. Nagar ','-',0,'9767295367','-','50132','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-08-15','वाहन चालक','open','601913',0,'0','वाहन चालक',101,1,'2025-07-05','15081996',2),(50133,'VIKAS','SHANKAR','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601955_2025-06-02 14_04_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601955_2025-06-02 14_04_55.jpeg','vms851149@gmail.com','SHANKAr','SONABAi','AT. POST. LADSAWANGi TQ. DIST. AURANGABAd','-',0,'9673087984','-','50133','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-06-24','वाहन चालक','open','601955',0,'0','वाहन चालक',101,1,'2025-07-05','24062000',2),(50134,'GANESH','VACHISHTA','BAVKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601956_2025-06-01 19_04_37.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601956_2025-06-01 19_04_58.jpeg','gvbavkar@gmail.com','VACHISHTA NARAYAN BAVKAR','SHARAD VACHISHT Bavkar ','AT.DEVANGRA. SAWARGAON. TA.BHOOM. DIST.DHARASHIv ','-',0,'9922255408','-','50134','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-01-06','वाहन चालक','open','601956',0,'0','वाहन चालक',101,1,'2025-07-05','06011992',2),(50135,'RAMJAN','SIDDIKI','SHAIKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601959_2025-06-01 19_30_19.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601959_2025-06-01 19_30_24.jpeg','ramjan.shriramcity@gmail.com','SIDDIKi','HALIMA','AP AMBIKA NAGAR NEAR TEMBHURNI NAKA ','-',0,'7720096400','-','50135','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1988-03-08','वाहन चालक','open','601959',0,'0','वाहन चालक',101,1,'2025-07-05','08031988',2),(50136,'TUKARAM','SHIVAJI','DESHMUKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601996_2025-06-01 22_22_32.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601996_2025-06-01 22_22_59.jpeg','tukaramdeshmukh98@gmail.com','SHIVAJI GUNDERAO DESHMUKH','RUKMINBAI','AT. KOTGYALWADI POST. GOJEGOAN TQ. MUKHED DIST. NANDED MUKHED','-',0,'9284599235','-','50136','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-07-11','वाहन चालक','open','601996',0,'0','वाहन चालक',101,1,'2025-07-05','11071998',2),(50137,'AMOL','RAJENDRA','TUPE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_601997_2025-06-01 22_30_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_601997_2025-06-01 22_31_12.jpeg','tupeamol2617@gmail.com','RATJENDRA ','DWARKABAi','AT BHILPURI POST SHELGAON TQ.BADNAPUR DIST JALNA','-',0,'7798798727','-','50137','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-07-06','वाहन चालक','open','601997',0,'0','वाहन चालक',101,1,'2025-07-05','06072001',2),(50138,'SUYOG','SURAJ','SURYATAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602001_2025-06-01 22_52_59.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602001_2025-06-01 22_53_33.jpeg','suyogsuryatal@gmail.com','SURAJ SUYATAL','SUMANBAI','AT POST YELDARI CAMP SAWANGI MAHALSA','-',0,'8408818625','-','50138','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-11-17','वाहन चालक','open','602001',0,'0','वाहन चालक',101,1,'2025-07-05','17111992',2),(50139,'RAHIM','PASHAMIYAN','SAYAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602002_2025-06-01 23_39_38.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602002_2025-06-01 23_43_20.jpeg','sd.rahim7867@gmail.com','PASHAMIYAN','MAHEMUDa','H.NO.55 AT POST waghi  WAGHi','-',0,'9561928618','-','50139','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-09-17','वाहन चालक','open','602002',0,'0','वाहन चालक',101,1,'2025-07-05','17091990',2),(50140,'RUSHIKESH','KAILAS','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602004_2025-06-01 23_07_53.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602004_2025-06-01 23_08_01.jpeg','rishipawar626@gmail.com','KAILAs','KALPANa','N-11 F-12/1 NAVJIVAN COLONy HUDCO CHH SAMBHAJINAGAR','-',0,'9545793490','-','50140','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-11-03','वाहन चालक','open','602004',0,'0','वाहन चालक',101,1,'2025-07-05','03111997',2),(50141,'AMOL','BALU','DAUND','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602016_2025-06-02 09_23_42.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602016_2025-06-02 09_23_57.jpeg','amoldound1995@gmail.com','BALU EKNATH DAUNd','GANGUBAI BALU DAUNd','AT POST. PARUNDI,  TQ.PAITHAn','-',0,'9503950078','-','50141','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1995-05-14','वाहन चालक','open','602016',0,'0','वाहन चालक',101,1,'2025-07-05','14051995',2),(50142,'KRISHNA','SOPAN','GARJE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602034_2025-06-02 12_35_06.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602034_2025-06-02 12_35_37.jpeg','krishnagarje5050@gmail.com','SOPAN MARUTI GARJE','KALPANA SOPAN GARJE','K K R ROAD TURBHE STORE ROOM NO 2569  NEAR BY PRAMOD KIRANA STORE','-',0,'9833907744','-','50142','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1999-12-20','वाहन चालक','open','602034',0,'0','वाहन चालक',101,1,'2025-07-05','20121999',2),(50143,'RUSHIKESH','TRIMBAK','DAKLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602046_2025-06-02 11_13_50.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602046_2025-06-02 11_15_35.jpeg','rushikeshdakle1998@gmail.com','TRIMBAK','PUSHPABAI','AT DGAONGARGAON KAWAD TA PHULAMBRI','-',0,'8805981608','-','50143','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-03-19','वाहन चालक','open','602046',0,'0','वाहन चालक',101,1,'2025-07-05','19031998',2),(50144,'BHAUSAHEB','ONKAR','GAIKWAD','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602048_2025-06-02 12_01_55.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602048_2025-06-02 12_02_18.jpeg','kaushalya51251@gmail.com','ONKAR NARSU GAIKWAd','KAUSHALYABAI ONKAR GAIKWAd','AT.CHINCHOLi POST GALLEBORGAON ','-',0,'9665259247','-','50144','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1987-11-09','वाहन चालक','open','602048',0,'0','वाहन चालक',101,1,'2025-07-05','09111987',2),(50145,'KISHOR','DILIPSING','RAJPUT','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602057_2025-06-02 11_57_20.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602057_2025-06-02 11_57_56.jpeg','rajput.kish@gmail.com','DILIPSING BABUSING RAJPUT','RATNABAI DILIPSING RAJPUT','AARTI NAGAR HOUSE NO 188 PISADEVI ROAD NEAR VISHALI DHABA IN FRONT CHAVDHAR HOSPITAL ','-',0,'9730406002','-','50145','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-08-04','वाहन चालक','open','602057',0,'0','वाहन चालक',101,1,'2025-07-05','04081989',2),(50146,'RAJKUMAR','VASANT','PAWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602072_2025-06-02 12_48_45.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602072_2025-06-02 12_49_50.jpeg','rajkumarpawarrajkumar@gmail.com','VASANT RAJARAM PAWAR','SUNITA','AT GAUNDGAON POST MALEGAON ( YATRA ) TQ LOHA','-',0,'9404785466','-','50146','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2000-07-10','वाहन चालक','open','602072',0,'0','वाहन चालक',101,1,'2025-07-05','10072000',2),(50147,'CHOTIRAM','SITARAM','BAHURE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602074_2025-06-02 12_49_34.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602074_2025-06-02 12_49_50.jpeg','yogesharda777@gmail.com','SITARAM BAHURE','KASTURABAI','AT BEBLYACHIWADI POST KHODEGAON Kachaner road tq Chhatrapati sambhajinagar','-',0,'8767648255','-','50147','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-03-22','वाहन चालक','open','602074',0,'0','वाहन चालक',101,1,'2025-07-05','22031997',2),(50148,'ANKUSH','JAGANNATH','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602077_2025-06-02 13_16_48.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602077_2025-06-02 13_11_55.jpeg','jadhavankush8408@gmail.com','JAGANNATH','NIRMALABAI','AT WADALI POST MADNI TQ SILLOD DIST CHH SAMBHAJINAGAR','-',0,'9146181777','-','50148','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-09-12','वाहन चालक','open','602077',0,'0','वाहन चालक',101,1,'2025-07-05','12091993',2),(50149,'AZHAR','VAJIR','MOMIN','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602082_2025-06-02 13_38_34.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602082_2025-06-02 13_38_47.jpeg','azharmomin730@gmail.com','VAJIR YASIN MOMIn','HABIBa','GANESH NAGAR  HUSENPURa','-',0,'9763274882','-','50149','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-05-01','वाहन चालक','open','602082',0,'0','वाहन चालक',101,1,'2025-07-05','01051998',2),(50150,'SHANTARAM','DADAPATIL','TATHE ','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602116_2025-06-02 15_20_25.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602116_2025-06-02 15_20_59.jpeg','shantaramtathe234@gmail.com','DADAPATIL TATHE ','LAKSHIMIBAI DADAPATIL TATHe','AT.GEORAI SHEMI  POST . GEORAI SHEMi','-',0,'8482978957','-','50150','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-07-03','वाहन चालक','open','602116',0,'0','वाहन चालक',101,1,'2025-07-05','03071990',2),(50151,'KHABIL','A LATIF','KAJI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602117_2025-06-02 15_37_15.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602117_2025-06-02 15_37_24.jpeg','khabilkaji007@gmail.com','A LATIf','KOUSARBi','AT POST HANEGAON TA DEGLOR DIST NANDEd AT POST HANEGAON TA DEGLOOR DIST NANDEd','-',0,'9823057892','-','50151','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-04-21','वाहन चालक','open','602117',0,'0','वाहन चालक',101,1,'2025-07-05','21041994',2),(50152,'PRASHANT','NARAYAN','PUNDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602133_2025-06-02 16_39_45.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602133_2025-06-02 16_39_59.jpeg','punde8294@gmail.com','NARAYAn','MANDa','at post dhokari tal akole district ahemadnagar','-',0,'9970342741','-','50152','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-02-08','वाहन चालक','open','602133',0,'0','वाहन चालक',101,1,'2025-07-05','08021994',2),(50153,'ASHISH','BABURAO','PANDHARE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602138_2025-06-02 20_18_26.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602138_2025-06-02 20_19_02.jpeg','iashish.pandhare@gmail.com','BABURAO PANDHARe','LAXMI PANDHARe','PLOT NO. 1, GALLI NO. 2, S.NO. 156 SUREWADi','-',0,'9673311118','-','50153','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-01-09','वाहन चालक','open','602138',0,'0','वाहन चालक',101,1,'2025-07-05','09011997',2),(50154,'SHIVAJI','NARAYAN','DIGHULE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602144_2025-06-02 16_48_58.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602144_2025-06-02 16_49_03.jpeg','sdighule42@gmail.com','NARAYAN','CHANDRAKALA','AT.POST.BHALGAON ','-',0,'7620193300','-','50154','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1998-08-17','वाहन चालक','open','602144',0,'0','वाहन चालक',101,1,'2025-07-05','17081998',2),(50155,'KIRAN','PANDURANG','SONWANE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602145_2025-06-02 17_03_19.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602145_2025-06-02 17_03_26.jpeg','kiranpsonwane358@gmail.com','PANDURANG SONWANE','VIMALBAI PANDURANG SONWANE','AT KAUDGAON, TA. BASMAT, KAUDGAOn ERANDESHWAR, HINGOLi','-',0,'7030702277','-','50155','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-05-17','वाहन चालक','open','602145',0,'0','वाहन चालक',101,1,'2025-07-05','17051994',2),(50156,'FARDIN','MUSTAFA','SHAIKH','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602168_2025-06-02 17_53_59.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602168_2025-06-02 17_55_27.jpeg','fardimshaikh645@gmail.com','MUSTAFA SHAIKh','RESHMA SHAIKh','MADNI NAGAr BHANGI COLONy','-',0,'7058208202','-','50156','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2003-09-22','वाहन चालक','open','602168',0,'0','वाहन चालक',101,1,'2025-07-05','22092003',2),(50157,'RATANHARI','MUNJAJI','MUNDHE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602175_2025-06-02 18_13_35.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602175_2025-06-02 18_13_50.jpeg','rmmundhe143@gmail.com','MUNJAJI','PRABHAVATI','AT.ATNTARWELI POST.BADWANI TQ.GANGAKHED DIST.PARBHANI','-',0,'9579055673','-','50157','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-01-02','वाहन चालक','open','602175',0,'0','वाहन चालक',101,1,'2025-07-05','02011993',2),(50158,'RAJU','SURESH','KASARE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602192_2025-06-02 18_49_54.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602192_2025-06-02 18_50_00.jpeg','rajukasare58@gmail.com','SURESh','SHANTABAi','NEAR Z P SCHOOL  SAWANGI','-',0,'9763230813','-','50158','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-07-15','वाहन चालक','open','602192',0,'0','वाहन चालक',101,1,'2025-07-05','15071996',2),(50159,'UDHAV','NARAYAN','SURYAWANSHI','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602194_2025-06-02 18_58_57.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602194_2025-06-02 18_59_05.jpeg','suryawanshiudhav55@gmail.com','NARAYAN','JAYABAI','AT SATEPHAL POST HAYATNAGAR','-',0,'9112157358','-','50159','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1991-06-08','वाहन चालक','open','602194',0,'0','वाहन चालक',101,1,'2025-07-05','08061991',2),(50160,'NAMADEO','CHANDRAKANT','BHOSALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602199_2025-06-02 19_08_57.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602199_2025-06-02 19_09_04.jpeg','bhosalenamadeo2018@gmail.com','CHANDRAKANT REVAJAI BHOSALE','HIRABAI','AT POST MORACHI CHINCHOLI  SHIRUR ROAD ','-',0,'9359913656','-','50160','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-05-01','वाहन चालक','open','602199',0,'0','वाहन चालक',101,1,'2025-07-05','01051997',2),(50161,'PRAMOD','ASHOK','BORDE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602208_2025-06-02 19_13_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602208_2025-06-02 19_13_55.jpeg','pramodborde1431993@gmail.com','ASHOK BORDE','SHIVNANDA','AT POST WAHEGAON TQ PHULAMBRI','-',0,'8888318281','-','50161','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-05-30','वाहन चालक','open','602208',0,'0','वाहन चालक',101,1,'2025-07-05','30051993',2),(50162,'ROHIT','ASHOK','SALVE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602211_2025-06-02 19_31_47.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602211_2025-06-02 19_31_53.jpeg','salverohit0011@gmail.com','ASHOK SALVE','PRAMILA ASHOK SALVE','NEW NANDANVAN COLONY CHANDMARI MASJID BUJBALNAGAR','-',0,'7028454279','-','50162','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-06-20','वाहन चालक','open','602211',0,'0','वाहन चालक',101,1,'2025-07-05','20061994',2),(50163,'RUPESH','ASHOK','INGALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602213_2025-06-02 19_30_12.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602213_2025-06-02 19_30_33.jpeg','rupeshingale93@gmail.com','ASHOK','REKHA','AT. NARDODA POST. KANHOLI','-',0,'8412039302','-','50163','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-09-13','वाहन चालक','open','602213',0,'0','वाहन चालक',101,1,'2025-07-05','13091993',2),(50164,'PRAVIN','SUDHAKAR','SAVLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602216_2025-06-02 19_41_42.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602216_2025-06-02 19_41_51.jpeg','savlepravin255@gmail.com','SUDHAKAR SAVLE','SHOBHA SAVLE','PADALI EKGHAR AT POST-NIDHONA TQ-PHULAMBRI DIST-CHHATRAPATI SAMBHAJI NAGAR ','-',0,'9168361940','-','50164','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-07-19','वाहन चालक','open','602216',0,'0','वाहन चालक',101,1,'2025-07-05','19071993',2),(50165,'AJAY','AMBADAS','KALWELWAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602218_2025-06-02 19_38_24.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602218_2025-06-02 19_38_34.jpeg','aakalwelwar@gmail.com','AMBADAS JALAL KALWELWAR','JAYA','AT AMBEDKAR WARD PANDHARKAWADA TAH KELAPUR DIST YAVATMAL','-',0,'9545659165','-','50165','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1990-04-07','वाहन चालक','open','602218',0,'0','वाहन चालक',101,1,'2025-07-05','07041990',2),(50166,'KISHOR','RAGHUNATH','INGLE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602221_2025-06-02 19_53_22.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602221_2025-06-02 19_54_27.jpeg','kishoringle99@gmail.com','RAGHUNATH JAMAJI INGLE','REKHA','AT POST SHIRLA ANDHARE TQ PATUR DIST AKOLA','-',0,'9011868826','-','50166','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-01-22','वाहन चालक','open','602221',0,'0','वाहन चालक',101,1,'2025-07-05','22011993',2),(50167,'NITIN','JAGANNATH','PALASKAR','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602236_2025-06-02 20_13_00.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602236_2025-06-02 20_13_13.jpeg','nitinpalaskarnew@gmail.com','JAGANNATH PANDHARINATH PALASKAr','SHOBHA JAGANNATH PALASKAr','AT POST PALSHI TQ DIST CHHATRAPATI SAMBHAJINAGAr ','-',0,'9049166280','-','50167','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1994-10-12','वाहन चालक','open','602236',0,'0','वाहन चालक',101,1,'2025-07-05','12101994',2),(50168,'GANGADHAR','DAGDU','GUNJAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602249_2025-06-02 20_25_08.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602249_2025-06-02 20_25_17.jpeg','raajgunjal3173@gmail.com','DAGDU','HIRABAI','JAMN JYOTI HARSUL HARSUL','-',0,'7507059392','-','50168','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1996-11-15','वाहन चालक','open','602249',0,'0','वाहन चालक',101,1,'2025-07-05','15111996',2),(50169,'SANDIP','SAMBHAJI ','ADAGALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602282_2025-06-02 22_05_49.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602282_2025-06-02 22_06_11.jpeg','sandip28189@gmail.com','SAMBAHJI SHIVAJI ADAGALe','NANDABAI SAMBHAJI ADAGALe','C/O: Sambhaji Adagale  House No 2 14/1 Madhuban Society NEAR BANANA STORE LEN NO 1  OLD SANGVI PUNE.','-',0,'9657939996','-','50169','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1989-01-28','वाहन चालक','open','602282',0,'0','वाहन चालक',101,1,'2025-07-05','28011989',2),(50170,'RAJESH','SURESH','SURYATAL','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602290_2025-06-02 22_02_20.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602290_2025-06-02 22_03_13.jpeg','rajeshsuryatal9991@gmail.com','SURESH SURYATAl','SUMAn','AT POST YELDARI CAMP SAWANGI MAHALSA','-',0,'8007429284','-','50170','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1997-02-05','वाहन चालक','open','602290',0,'0','वाहन चालक',101,1,'2025-07-05','05021997',2),(50171,'ASHOK','RAMDAS','GHADAGE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602304_2025-06-02 22_29_51.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602304_2025-06-02 22_30_19.jpeg','ashokghadge7007@gmail.com','RAMDAS DADARAO GHADAGe','ASHABAI RAMDAS GHADAGe','AT RUI LIMBA  POST MURSHADPUr','-',0,'9613967007','-','50171','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1993-05-22','वाहन चालक','open','602304',0,'0','वाहन चालक',101,1,'2025-07-05','22051993',2),(50172,'MANOJ','RAOSAHEB','JADHAV','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602313_2025-06-02 22_55_30.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602313_2025-06-02 22_55_41.jpeg','manoj6804@gmail.com','RAOSAHEB','SHAKUNTALA','PLOT NO 10 SERVE NO 156 GALLI NO 05 SUREWADI CHHATRAPATI SAMBHAJINAGAR','-',0,'9673296465','-','50172','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'1992-04-25','वाहन चालक','open','602313',0,'0','वाहन चालक',101,1,'2025-07-05','25041992',2),(50173,'SOMNATH','PANDHARINATH ','DAGALE','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_photo_602316_2025-06-02 23_08_16.jpeg','उच्चतम कृषी उत्पन्न बाजार समिती, छत्रपती संभाजीनगर_sign_602316_2025-06-02 23_09_00.jpeg','dagalesomnath2@gmail.com','PANDHARINATH Dagale ','NANDABAI DAGALe','N6 CIDCO AURANGABAD 431001 N6 CIDCO AURANGABAD 431001','-',0,'7058455930','-','50173','-','-','-','09:20:56','2025-07-04','2025-07-04 21:20:56',1,1,'2001-05-17','वाहन चालक','open','602316',0,'0','वाहन चालक',101,1,'2025-07-05','17052001',2);
/*!40000 ALTER TABLE `tn_student_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utr_images`
--

DROP TABLE IF EXISTS `utr_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utr_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_type` varchar(20) NOT NULL,
  `code` longtext NOT NULL,
  `image_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utr_images`
--

LOCK TABLES `utr_images` WRITE;
/*!40000 ALTER TABLE `utr_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `utr_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utr_master_exams_list`
--

DROP TABLE IF EXISTS `utr_master_exams_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utr_master_exams_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msl_name` varchar(512) NOT NULL,
  `msl_disc` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utr_master_exams_list`
--

LOCK TABLES `utr_master_exams_list` WRITE;
/*!40000 ALTER TABLE `utr_master_exams_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `utr_master_exams_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utr_student_attendance`
--

DROP TABLE IF EXISTS `utr_student_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utr_student_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utr_student_attendance`
--

LOCK TABLES `utr_student_attendance` WRITE;
/*!40000 ALTER TABLE `utr_student_attendance` DISABLE KEYS */;
INSERT INTO `utr_student_attendance` VALUES (1,30001);
/*!40000 ALTER TABLE `utr_student_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utr_time_table`
--

DROP TABLE IF EXISTS `utr_time_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utr_time_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tt_exam_id` int NOT NULL,
  `tt_exam_name` varchar(100) NOT NULL,
  `tt_batch_id` int NOT NULL,
  `tt_batch_name` varchar(100) NOT NULL,
  `tt_exam_data` date NOT NULL,
  `tt_exam_start_time` varchar(50) NOT NULL,
  `tt_exam_end_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utr_time_table`
--

LOCK TABLES `utr_time_table` WRITE;
/*!40000 ALTER TABLE `utr_time_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `utr_time_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utr_unlock_list`
--

DROP TABLE IF EXISTS `utr_unlock_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utr_unlock_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ul_student_id` int NOT NULL,
  `ul_unlock_cause` longtext NOT NULL,
  `ul_time_stamp` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utr_unlock_list`
--

LOCK TABLES `utr_unlock_list` WRITE;
/*!40000 ALTER TABLE `utr_unlock_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `utr_unlock_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'utr_node_exam_old'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-06 10:44:57
