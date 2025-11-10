

-- MySQL dump 10.13  Distrib 8.0.42, for macos15.2 (arm64)
--
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
) ENGINE=InnoDB AUTO_INCREMENT=15121 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `sqp_time` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `sqp_ans` varchar(5) DEFAULT NULL,
  `added_time` varchar(10) DEFAULT NULL,
  `sqp_min` int DEFAULT '0',
  `sqp_sec` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tm_student_question_paper_sqp_question_id` (`sqp_question_id`),
  KEY `idx_tm_student_question_paper_sqp_publish_id` (`sqp_publish_id`),
  KEY `idx_tm_student_question_paper_sqp_student_id` (`sqp_student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15301 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=1091 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=2000112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPRESSED;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `utr_student_attendance`
--

DROP TABLE IF EXISTS `utr_student_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utr_student_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-08 16:10:29
