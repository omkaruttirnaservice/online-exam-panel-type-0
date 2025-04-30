-- Adminer 4.7.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DELIMITER ;;

DROP PROCEDURE IF EXISTS `test_question_set_proc`;;
CREATE PROCEDURE `test_question_set_proc`(IN `test_id` INT(10), OUT `data_list_1` LONGTEXT)
BEGIN
	SELECT  main_test.id as main_test_id,
			main_test.mt_name as main_test_name,
			main_test.mt_test_time as test_time,
			main_test.mt_type as test_type,
            test_topic.tta_sub_topic_id as sub_topic_id,
            test_topic.tta_total_question as tota_question_count,
            test_topic.tta_sub_topic_name as sub_topic_name,
            test_topic.tta_main_topic_name as topic_id
			 FROM
				 tm_master_test as main_test INNER JOIN
				 tm_test_topic_area as test_topic
			 ON
				 main_test.id = test_topic.tta_master_test_id
		 	 WHERE
			  main_test.id = test_id ;
END;;

DROP PROCEDURE IF EXISTS `test_question_set_proc_get_question_set`;;
CREATE PROCEDURE `test_question_set_proc_get_question_set`(IN `sub_topic_id` INT(10), IN `question_count` INT(10), OUT `data` LONGTEXT)
BEGIN
	
	SELECT 
		*
	FROM
     (
        SELECT  @cnt := COUNT(*) + 1,
                @lim := question_count
        FROM    tm_question_list
        ) vars   

	STRAIGHT_JOIN
        (
        SELECT 
        question.id as question_id,
        question.ql_question as question,
        question.ql_opt_one as opt_a,
        question.ql_sub_topic_id as qtopic_id,
        question.ql_opt_thee as opt_c ,
        question.ql_opt_two as opt_b,
        question.ql_opt_four as opt_d,
        question.ql_opt_five as opt_e,
        question.ql_ans as ans,
        IFNULL((''),'-') as student_ans,
        IFNULL((''),'-') as ans_time,
		@lim := @lim - 1
        FROM    tm_question_list as question 
        WHERE  question.ql_sub_topic_id = sub_topic_id  AND 
				(@cnt := @cnt - 1)  AND 
                RAND(20090301) < @lim
        ) i;
    
END;;

DELIMITER ;

DROP TABLE IF EXISTS `aouth`;
CREATE TABLE `aouth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a_master_name` varchar(512) NOT NULL,
  `a_master_password` varchar(40) NOT NULL,
  `a_last_password` varchar(40) DEFAULT NULL,
  `a_added_date` date DEFAULT NULL,
  `a_added_time` varchar(20) DEFAULT NULL,
  `a_time_stamp` varchar(20) DEFAULT NULL,
  `a_valid` int(1) NOT NULL DEFAULT 0,
  `a_code` bigint(255) NOT NULL,
  `a_app_code` int(5) NOT NULL DEFAULT 1,
  `a_center_name` varchar(512) DEFAULT NULL,
  `a_center_address` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `aouth` (`id`, `a_master_name`, `a_master_password`, `a_last_password`, `a_added_date`, `a_added_time`, `a_time_stamp`, `a_valid`, `a_code`, `a_app_code`, `a_center_name`, `a_center_address`) VALUES
(1,	'utr',	'utr',	NULL,	NULL,	NULL,	NULL,	0,	101,	101,	'EXAMS  CENTER',	'3rd Floor,Thakurdas Building,Akola.');

DROP TABLE IF EXISTS `tm_final_student_question_paper`;
CREATE TABLE `tm_final_student_question_paper` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `sqp_question_id` bigint(255) NOT NULL COMMENT 'this is question_paper_list_ table id',
  `sqp_student_id` bigint(255) NOT NULL COMMENT 'student table id',
  `sqp_test_id` bigint(255) NOT NULL,
  `sqp_publish_id` bigint(255) NOT NULL,
  `sqp_is_remark` int(11) NOT NULL DEFAULT 0,
  `sqp_index_value` int(255) DEFAULT NULL,
  `sqp_time` varchar(10) DEFAULT NULL,
  `sqp_ans` varchar(5) DEFAULT NULL,
  `added_time` varchar(10) DEFAULT NULL,
  `sqp_min` int(3) DEFAULT 0,
  `sqp_sec` int(7) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sqp_question_id` (`sqp_question_id`),
  KEY `sqp_student_id` (`sqp_student_id`),
  KEY `sqp_test_id` (`sqp_test_id`),
  KEY `sqp_publish_id` (`sqp_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `tm_final_student_test_list`;
CREATE TABLE `tm_final_student_test_list` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `stl_test_id` bigint(255) NOT NULL,
  `stl_stud_id` bigint(255) NOT NULL,
  `stl_publish_id` bigint(255) NOT NULL,
  `stl_date` date NOT NULL,
  `stl_test_url` longtext NOT NULL,
  `stl_time` varchar(20) NOT NULL,
  `stl_time_stamp` varchar(20) NOT NULL,
  `stl_test_compliet_in` varchar(20) NOT NULL DEFAULT '0',
  `stl_test_submition_time` varchar(20) DEFAULT NULL,
  `stl_test_status` int(1) NOT NULL DEFAULT 2,
  `stl_agrement_accepted` int(1) NOT NULL DEFAULT 1,
  `stm_min` int(3) DEFAULT NULL,
  `stm_sec` int(3) DEFAULT NULL,
  `stl_browser_info` longtext DEFAULT NULL,
  `stl_user_ip` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stl_test_id` (`stl_test_id`),
  KEY `stl_stud_id` (`stl_stud_id`),
  KEY `stl_publish_id` (`stl_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `tm_publish_test_list`;
CREATE TABLE `tm_publish_test_list` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `ptl_active_date` date NOT NULL,
  `ptl_time` int(11) DEFAULT NULL,
  `ptl_link` longtext NOT NULL,
  `ptl_link_1` varchar(50) NOT NULL,
  `ptl_test_id` bigint(255) NOT NULL,
  `ptl_master_exam_id` int(255) NOT NULL DEFAULT 0,
  `ptl_master_exam_name` varchar(128) DEFAULT '0',
  `ptl_added_date` date NOT NULL,
  `ptl_added_time` varchar(20) NOT NULL,
  `ptl_time_tramp` varchar(20) NOT NULL,
  `ptl_test_description` mediumtext NOT NULL,
  `ptl_is_live` int(1) NOT NULL DEFAULT 1,
  `ptl_aouth_id` bigint(255) NOT NULL,
  `ptl_is_test_done` int(11) NOT NULL DEFAULT 0,
  `ptl_test_info` longtext NOT NULL,
  `mt_name` mediumtext NOT NULL,
  `mt_added_date` date NOT NULL,
  `mt_descp` longtext NOT NULL,
  `mt_is_live` int(1) NOT NULL DEFAULT 1,
  `mt_time_stamp` varchar(20) NOT NULL,
  `mt_type` int(11) NOT NULL COMMENT '1: on tablet,2: on paper	',
  `tm_aouth_id` bigint(255) NOT NULL,
  `mt_test_time` varchar(10) NOT NULL COMMENT 'test duration',
  `mt_total_test_takan` int(11) NOT NULL DEFAULT 0,
  `mt_is_negative` varchar(10) NOT NULL DEFAULT '0',
  `mt_negativ_mark` varchar(10) NOT NULL DEFAULT '0',
  `mt_mark_per_question` varchar(10) NOT NULL DEFAULT '1',
  `mt_passing_out_of` varchar(10) NOT NULL COMMENT 'cut off',
  `mt_total_marks` int(4) NOT NULL DEFAULT 0,
  `mt_pattern_type` int(1) NOT NULL DEFAULT 0 COMMENT 'eg . 0 for genral',
  `mt_total_test_question` int(4) NOT NULL DEFAULT 0,
  `mt_added_time` varchar(20) NOT NULL,
  `mt_pattern_name` varchar(30) DEFAULT '-',
  `is_test_generated` int(1) DEFAULT 0,
  `ptl_test_mode` int(11) NOT NULL DEFAULT 1,
  `tm_allow_to` int(1) NOT NULL DEFAULT 0 COMMENT '0-all,1-eng&gen,2-med&gen',
  `is_test_loaded` int(1) DEFAULT 0,
  `is_student_added` int(1) DEFAULT 0,
  `is_uploaded` int(1) DEFAULT 0,
  `is_start_exam` int(1) DEFAULT 0,
  `is_absent_mark` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ptl_test_id` (`ptl_test_id`),
  KEY `ptl_link_1` (`ptl_link_1`),
  KEY `ptl_active_date` (`ptl_active_date`),
  KEY `ptl_master_exam_id` (`ptl_master_exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `tm_student_final_result_set`;
CREATE TABLE `tm_student_final_result_set` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `sfrs_publish_id` int(255) NOT NULL,
  `sfrs_batch_id` int(3) NOT NULL,
  `sfrs_master_exam_id` int(3) NOT NULL,
  `sfrs_student_id` int(255) NOT NULL,
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
  `sfrs_duration` int(5) NOT NULL,
  `sfrs_sms` varchar(20) NOT NULL DEFAULT '0',
  `sfrs_sms_issue` varchar(512) NOT NULL DEFAULT 'No',
  `sfrs_sms_message` varchar(512) NOT NULL DEFAULT 'No',
  `sfrs_is_absent` int(1) NOT NULL DEFAULT 1,
  `sfrs_percentile` double NOT NULL DEFAULT 0,
  `sfrs_sub_id_1` int(255) NOT NULL DEFAULT 0,
  `sfrs_sub_name_1` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_1` double NOT NULL DEFAULT 0,
  `sfrs_sub_percentile_1` double NOT NULL DEFAULT 0,
  `sfrs_sub_id_2` int(255) NOT NULL DEFAULT 0,
  `sfrs_sub_name_2` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_2` double NOT NULL DEFAULT 0,
  `sfrs_sub_percentile_2` double NOT NULL DEFAULT 0,
  `sfrs_sub_id_3` int(255) NOT NULL DEFAULT 0,
  `sfrs_sub_name_3` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_3` double NOT NULL DEFAULT 0,
  `sfrs_sub_percentile_3` double NOT NULL DEFAULT 0,
  `sfrs_sub_id_4` int(255) NOT NULL DEFAULT 0,
  `sfrs_sub_name_4` varchar(30) NOT NULL DEFAULT '0',
  `sfrs_sub_marks_4` double NOT NULL DEFAULT 0,
  `sfrs_sub_percentile_4` double NOT NULL DEFAULT 0,
  `sfrs_dob` bigint(255) NOT NULL DEFAULT 0,
  `sfrs_rank` int(11) NOT NULL DEFAULT -1,
  PRIMARY KEY (`id`),
  KEY `sfrs_student_id` (`sfrs_student_id`),
  KEY `sfrs_student_roll_no` (`sfrs_student_roll_no`),
  KEY `sfrs_test_date` (`sfrs_test_date`),
  KEY `sfrs_publish_id` (`sfrs_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `tm_student_question_paper`;
CREATE TABLE `tm_student_question_paper` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `sqp_question_id` bigint(255) NOT NULL COMMENT 'this is question_paper_list_ table id',
  `sqp_student_id` bigint(255) NOT NULL COMMENT 'student table id',
  `sqp_test_id` bigint(255) NOT NULL,
  `sqp_publish_id` bigint(255) NOT NULL,
  `sqp_is_remark` int(11) NOT NULL DEFAULT 0,
  `sqp_index_value` int(255) DEFAULT NULL,
  `sqp_time` varchar(10) DEFAULT NULL,
  `sqp_ans` varchar(5) DEFAULT NULL,
  `added_time` varchar(10) DEFAULT NULL,
  `sqp_min` int(3) DEFAULT 0,
  `sqp_sec` int(3) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_tm_student_question_paper_sqp_question_id` (`sqp_question_id`),
  KEY `idx_tm_student_question_paper_sqp_publish_id` (`sqp_publish_id`),
  KEY `idx_tm_student_question_paper_sqp_student_id` (`sqp_student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;


DROP TABLE IF EXISTS `tm_student_test_attendance`;
CREATE TABLE `tm_student_test_attendance` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `sta_student_id` int(255) NOT NULL,
  `sta_publish_id` int(255) NOT NULL,
  `sta_is_present` int(1) NOT NULL DEFAULT 0,
  `sta_is_block` int(1) NOT NULL DEFAULT 0,
  `sta_date` date NOT NULL,
  `sta_time` varchar(20) NOT NULL,
  `sta_time_stamp` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sta_publish_id` (`sta_publish_id`),
  KEY `sta_student_id` (`sta_student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `tm_student_test_list`;
CREATE TABLE `tm_student_test_list` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `stl_test_id` bigint(255) NOT NULL,
  `stl_stud_id` bigint(255) NOT NULL,
  `stl_publish_id` bigint(255) NOT NULL,
  `stl_date` date NOT NULL,
  `stl_test_url` longtext DEFAULT NULL,
  `stl_time` varchar(20) DEFAULT NULL,
  `stl_time_stamp` varchar(20) DEFAULT NULL,
  `stl_test_compliet_in` varchar(20) NOT NULL DEFAULT '0',
  `stl_test_submition_time` varchar(20) DEFAULT NULL,
  `stl_test_status` int(1) NOT NULL DEFAULT 2,
  `stl_agrement_accepted` int(1) NOT NULL DEFAULT 1,
  `stm_min` int(3) DEFAULT NULL,
  `stm_sec` int(3) DEFAULT NULL,
  `stl_browser_info` longtext DEFAULT NULL,
  `stl_user_ip` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stl_test_id` (`stl_test_id`),
  KEY `stl_stud_id` (`stl_stud_id`),
  KEY `stl_publish_id` (`stl_publish_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `tm_stud_institute_list`;
CREATE TABLE `tm_stud_institute_list` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `il_name` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `tm_stud_institute_list` (`id`, `il_name`) VALUES
(1,	'Utirna'),
(2,	'Aakash Institute'),
(5,	'Jaiswal Coaching Classes'),
(6,	'Deshmukh Sir\'s Saraswati Classes'),
(7,	'Wasim Sir\'s \'Wasim Chaudhary Classes\''),
(8,	'Rainbow Classes'),
(9,	'Ali Sir\'s Autocrat Coaching Classes'),
(10,	'The Horizon Classes'),
(11,	'Bhaltilak Coaching Classes'),
(12,	'Aware Classes'),
(13,	'Surve Sir\'s Siddhant Coaching Classes'),
(14,	'Nalkande Sir\'s Coaching Class'),
(15,	'Bathe Sir\'s Samarth Coaching Classes'),
(16,	'Science Coaching Classes'),
(17,	'Maths Corner Classes'),
(18,	'Jaiswal Sir\'s Coaching Classes'),
(19,	'Infinity Classes'),
(20,	'Nalanda Academy'),
(21,	'BOND COACHING CLASS');

DROP TABLE IF EXISTS `tm_test_question_sets`;
CREATE TABLE `tm_test_question_sets` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `q_id` int(255) NOT NULL,
  `tqs_test_id` int(255) NOT NULL,
  `section_id` int(255) NOT NULL,
  `section_name` text NOT NULL,
  `sub_topic_id` int(255) NOT NULL,
  `sub_topic_section` text NOT NULL,
  `main_topic_id` int(255) NOT NULL,
  `main_topic_name` text DEFAULT NULL,
  `q` longtext DEFAULT NULL,
  `q_a` longtext DEFAULT NULL,
  `q_b` longtext DEFAULT NULL,
  `q_c` longtext DEFAULT NULL,
  `q_d` longtext DEFAULT NULL,
  `q_e` longtext DEFAULT NULL,
  `q_display_type` int(1) DEFAULT 1,
  `q_ask_in` longtext DEFAULT NULL,
  `q_data_type` int(1) DEFAULT 1,
  `q_mat_data` longtext DEFAULT NULL,
  `q_col_a` longtext DEFAULT NULL,
  `q_col_b` longtext DEFAULT NULL,
  `q_mat_id` bigint(255) DEFAULT NULL,
  `q_i_a` longtext DEFAULT NULL,
  `q_i_b` longtext DEFAULT NULL,
  `q_i_c` longtext DEFAULT NULL,
  `q_i_d` longtext DEFAULT NULL,
  `q_i_e` longtext DEFAULT NULL,
  `q_i_q` longtext DEFAULT NULL,
  `q_i_sol` longtext DEFAULT NULL,
  `stl_topic_number` text DEFAULT NULL,
  `sl_section_no` text DEFAULT NULL,
  `q_sol` text DEFAULT NULL,
  `q_ans` text DEFAULT NULL,
  `q_mat_ans` text DEFAULT NULL,
  `q_mat_ans_row` text DEFAULT NULL,
  `q_col_display_type` int(1) DEFAULT 1,
  `question_no` varchar(1024) DEFAULT NULL,
  `mark_per_question` varchar(1024) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `q_id` (`q_id`),
  KEY `tqs_test_id` (`tqs_test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `tn_main_student_list`;
CREATE TABLE `tn_main_student_list` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `r_id` bigint(255) NOT NULL,
  `sl_f_name` varchar(1024) NOT NULL,
  `sl_m_name` varchar(1024) NOT NULL,
  `sl_l_name` varchar(1024) NOT NULL,
  `msl_batch_id` int(255) NOT NULL DEFAULT 0 COMMENT '2',
  `sl_institute_id` int(255) NOT NULL,
  `sl_institute_name` varchar(512) NOT NULL,
  `sl_image` longtext DEFAULT NULL,
  `sl_sign` longtext DEFAULT NULL,
  `sl_email` varchar(1024) NOT NULL,
  `sl_father_name` varchar(50) NOT NULL,
  `sl_mother_name` varchar(50) NOT NULL,
  `sl_address` mediumtext NOT NULL,
  `sl_mobile_number_parents` varchar(15) NOT NULL,
  `sl_tenth_marks` int(5) NOT NULL,
  `sl_contact_number` varchar(1024) NOT NULL,
  `sl_class` varchar(50) NOT NULL,
  `sl_roll_number` varchar(20) DEFAULT NULL,
  `sl_subject` varchar(50) NOT NULL,
  `sl_stream` varchar(70) NOT NULL COMMENT '1=JEE;2=MHT-CET;3=NEET',
  `sl_addmit_type` varchar(70) NOT NULL COMMENT '2= fresher;1=repeater',
  `sl_time` varchar(20) NOT NULL,
  `sl_date` date NOT NULL,
  `sl_time_stamp` varchar(20) NOT NULL,
  `sl_added_by_login_id` bigint(255) NOT NULL,
  `sl_is_live` int(11) NOT NULL DEFAULT 1,
  `sl_date_of_birth` date DEFAULT NULL,
  `sl_school_name` varchar(500) DEFAULT NULL,
  `sl_is_physical_handicap` int(1) NOT NULL DEFAULT 0,
  `sl_application_number` varchar(100) DEFAULT NULL,
  `sl_student_document` varchar(255) DEFAULT NULL,
  `sl_coupon_id` int(255) DEFAULT NULL,
  `sl_student_ref_by` varchar(255) DEFAULT NULL,
  `sl_catagory` varchar(50) DEFAULT NULL,
  `sl_post` varchar(100) DEFAULT NULL,
  `sl_password` varchar(50) DEFAULT NULL,
  `sl_exam_type` int(2) DEFAULT 1 COMMENT '1:PCM, 2 PCB, 3 PCMB',
  `sl_publish_id` bigint(255) DEFAULT 0,
  `sl_is_present` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sl_roll_number` (`sl_roll_number`),
  KEY `sl_password` (`sl_password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `tn_student_list`;
CREATE TABLE `tn_student_list` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `sl_f_name` varchar(1024) NOT NULL,
  `sl_m_name` varchar(1024) DEFAULT NULL,
  `sl_l_name` varchar(1024) DEFAULT NULL,
  `sl_image` longtext DEFAULT NULL,
  `sl_sign` longtext DEFAULT NULL,
  `sl_email` varchar(1024) DEFAULT NULL,
  `sl_father_name` varchar(50) DEFAULT NULL,
  `sl_mother_name` varchar(50) DEFAULT NULL,
  `sl_address` mediumtext DEFAULT NULL,
  `sl_mobile_number_parents` varchar(15) DEFAULT NULL,
  `sl_tenth_marks` int(5) DEFAULT NULL,
  `sl_contact_number` varchar(1024) NOT NULL,
  `sl_class` varchar(50) DEFAULT NULL,
  `sl_roll_number` varchar(20) DEFAULT NULL,
  `sl_subject` varchar(50) DEFAULT NULL,
  `sl_stream` varchar(70) DEFAULT NULL,
  `sl_addmit_type` varchar(70) DEFAULT NULL,
  `sl_time` varchar(20) DEFAULT NULL,
  `sl_date` date DEFAULT NULL,
  `sl_time_stamp` varchar(20) DEFAULT NULL,
  `sl_added_by_login_id` bigint(255) DEFAULT NULL,
  `sl_is_live` int(11) NOT NULL DEFAULT 1,
  `sl_date_of_birth` date DEFAULT NULL,
  `sl_school_name` varchar(500) DEFAULT NULL,
  `sl_catagory` varchar(128) DEFAULT NULL,
  `sl_application_number` text DEFAULT NULL,
  `sl_is_physical_handicap` int(1) NOT NULL DEFAULT 1,
  `sl_is_physical_handicap_desc` text DEFAULT NULL,
  `sl_post` text DEFAULT NULL,
  `sl_center_code` bigint(10) DEFAULT NULL,
  `sl_batch_no` int(2) DEFAULT NULL,
  `sl_exam_date` date DEFAULT NULL,
  `sl_password` longtext DEFAULT NULL,
  `sl_present_status` int(1) DEFAULT 2,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tn_student_list_sl_roll_number` (`sl_roll_number`),
  KEY `sl_center_code` (`sl_center_code`),
  KEY `sl_batch_no` (`sl_batch_no`),
  KEY `sl_exam_date` (`sl_exam_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


DROP TABLE IF EXISTS `utr_images`;
CREATE TABLE `utr_images` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `image_type` varchar(20) NOT NULL,
  `code` longtext NOT NULL,
  `image_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `utr_images` (`id`, `image_type`, `code`, `image_name`) VALUES
(1,	'banner',	'data:image/jpeg;base64,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N3q3eg4y7aTxJg6Ji3HPIZxHA4C5VJN1Tp4PWfod2/27v3tJTfodfo+76XGvxXKJJK0erijTRnt+jxp8EgMcEEBgI1B07rlEktVaPVu9FxBdtJHBMSnJqLtx27hwdJ/11XJpJK0esJqJDiWlw4OkhMBQAQAwB3IEa/FcokkrR6z9Dt2+3b4aR4pooMaM9v0eNPguUSSVo9Y30WCG7Wg+EBcl9dOjdU6tl45xMTEy8eqpzZusfW9r3n3tmm6ndW5ja9v7idJS4eL3Bw1xa7/+grMvDwHi+Xwel6d6rOn4zMr02ZDamC5lWlbXho3sq1d+ja76CnlvYcW4Bw/m3d/Irl07fpD4qM7nzXjZ/9n/7Q6YUGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAccAgAAAl/+ADhCSU0EJQAAAAAAEPM5WQXUU/env234Rb7SCXM4QklNBC8AAAAAAEqyAAEAWAIAAFgCAAAAAAAAAAAAAAgZAAAAEwAAoP///6D///9oGQAAjBMAAAABKAUAAPwDAAABAA8nAQBsbHVuAAAAAAAAAAAAeThCSU0D7QAAAAAAEAEr/9kAAQABASv/2QABAAE4QklNBCYAAAAAAA4AAAAAAAAAAAAAP4AAADhCSU0EDQAAAAAABAAAAB44QklNBBkAAAAAAAQAAAAeOEJJTQPzAAAAAAAJAAAAAAAAAAABADhCSU0ECgAAAAAAAQAAOEJJTScQAAAAAAAKAAEAAAAAAAAAAThCSU0D9QAAAAAASAAvZmYAAQBsZmYABgAAAAAAAQAvZmYAAQChmZoABgAAAAAAAQAyAAAAAQBaAAAABgAAAAAAAQA1AAAAAQAtAAAABgAAAAAAAThCSU0D+AAAAAAAcAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAA4QklNBAAAAAAAAAIABThCSU0EAgAAAAAADgAAAAAAAAAAAAAAAAAAOEJJTQQwAAAAAAAHAQEBAQEBAQA4QklNBC0AAAAAAAYAAQAAABs4QklNBAgAAAAAABAAAAABAAACQAAAAkAAAAAAOEJJTQQeAAAAAAAEAAAAADhCSU0E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czpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhhcE1NOkRvY3VtZW50SUQ9InV1aWQ6M0JEMjE3MDc1MkJFRTkxMUFERDJCMjdEOEZDNkIxNDMiIHhhcE1NOkluc3RhbmNlSUQ9InV1aWQ6M0NEMjE3MDc1MkJFRTkxMUFERDJCMjdEOEZDNkIxNDMiIHRpZmY6T3JpZW50YXRpb249IjEiIHRpZmY6WFJlc29sdXRpb249IjI5OTk5OTQvMTAwMDAiIHRpZmY6WVJlc29sdXRpb249IjI5OTk5OTQvMTAwMDAiIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiIHRpZmY6TmF0aXZlRGlnZXN0PSIyNTYsMjU3LDI1OCwyNTksMjYyLDI3NCwyNzcsMjg0LDUzMCw1MzEsMjgyLDI4MywyOTYsMzAxLDMxOCwzMTksNTI5LDUzMiwzMDYsMjcwLDI3MSwyNzIsMzA1LDMxNSwzMzQzMjs0RDEzMDI2NkQzODIxQTk5MzU4OTIzNDc3ODMyQjY5NCIgeGFwOk1vZGlmeURhdGU9IjIwMTktMDgtMTRUMTA6NDQ6NDMrMDU6MzAiIHhhcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTMyBXaW5kb3dzIiB4YXA6Q3JlYXRlRGF0ZT0iMjAxOS0wOC0xNFQxMDo0NDo0MyswNTozMCIgeGFwOk1ldGFkYXRhRGF0ZT0iMjAxOS0wOC0xNFQxMDo0NDo0MyswNTozMCIgZXhpZjpDb2xvclNwYWNlPSIxIiBleGlmOlBpeGVsWERpbWVuc2lvbj0iODAwIiBleGlmOlBpeGVsWURpbWVuc2lvbj0iMTI2IiBleGlmOk5hdGl2ZURpZ2VzdD0iMzY4NjQsNDA5NjAsNDA5NjEsMzcxMjEsMzcxMjIsNDA5NjIsNDA5NjMsMzc1MTAsNDA5NjQsMzY4NjcsMzY4NjgsMzM0MzQsMzM0MzcsMzQ4NTAsMzQ4NTIsMzQ4NTUsMzQ4NTYsMzczNzcsMzczNzgsMzczNzksMzczODAsMzczODEsMzczODIsMzczODMsMzczODQsMzczODUsMzczODYsMzczOTYsNDE0ODMsNDE0ODQsNDE0ODYsNDE0ODcsNDE0ODgsNDE0OTIsNDE0OTMsNDE0OTUsNDE3MjgsNDE3MjksNDE3MzAsNDE5ODUsNDE5ODYsNDE5ODcsNDE5ODgsNDE5ODksNDE5OTAsNDE5OTEsNDE5OTIsNDE5OTMsNDE5OTQsNDE5OTUsNDE5OTYsNDIwMTYsMCwyLDQsNSw2LDcsOCw5LDEwLDExLDEyLDEzLDE0LDE1LDE2LDE3LDE4LDIwLDIyLDIzLDI0LDI1LDI2LDI3LDI4LDMwO0Q1QjQwMDM2NzlBMjczMzA1OTFCMzgxQ0ZEMzE4MzY0IiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgcGhvdG9zaG9wOkhpc3Rvcnk9IiI+IDx4YXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ1dWlkOjM4RDIxNzA3NTJCRUU5MTFBREQyQjI3RDhGQzZCMTQzIiBzdFJlZjpkb2N1bWVudElEPSJ1dWlkOjBFNzczRTdERjVCOEU5MTE4MjFCRDdGNTZDOTIzMUYyIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw/eHBhY2tldCBlbmQ9InciPz7/4gxYSUNDX1BST0ZJTEUAAQEAAAxITGlubwIQAABtbnRyUkdCIFhZWiAH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RuGHb1FBkc3JjaJo1lXG0NVWY+nqaomUWV54l/qw9luy7Tdb7utjs9kUF3cSBF1Ehan1IBIH5Hox3ndbXY9rvt3vQ5tbeMu2kVag9ASAT+Y6ldLdv7I7+6o2B3P1xXzZHZHZG2cdunb1RVQrTV0dHkItUlDk6RJZ1o8ti6pZKarhDuIamF01HTc13farzZNzvtov0C3lvIyMBkVB4g4qpGVNBUEHq207pZ73ttlu1g5azuIw6kihofIjyYGoYeRBHQn+y7ox697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de6ZNy7iwuz9uZ/du46+DFbe2vhMruLPZSpbRTY3DYShnyWUr6h/7MFHQ0zyOfwqn29b2813cQWtuhaeV1RQOJZiAB+ZNOmbieK1gnurhwsEaFmJ4BVBJJ+wCvRQPgN80sJ88ekMj3ft3YuT6+xFJ2JunYlHh8vm6bO1tbDtynw9XFmpKilx2NipDkIcwt6bTIYWQjyOCD7FXO/KM3JW8R7PPerPKbdJCyqVA1lhpoSa008cV9B0F+SubIec9nk3iCzaCITvGFZgxOkKdVQBSurhmnqemWb567Jx/z/j+A2b2rWYnc2W6rh7F2pv6XO0smM3FlGpqjKVGzUwBx8VTR10WBx1ZVpUfdSrKKVk8allJeHJN5JyOed4bkPbrdeE8QU1ReHiaq0I1FVppFNQNemTzpaR87Dkqa2K3DW3ipJqFGNCfD00qDpDEGprSlOj6ewT0NOve/de697917r3v3Xuve/de697917r3v3Xuve/de697917qt/5g/wDMy8H/AOGLjP8A3f7m96PV14df/9HbY+H3/My85/4YuT/93+2feh1duHVkHvfVOve/de697917r3v3Xuve/de697917rpmVFZ3YKqgszMQqqqi5ZibAAAcn37r3WkJu75aH5ffz1uh96YfItXdc7F+QnX3VnVwSVpKOTae0NzSU8+bpBqKePdm4Zq3JqwAbw1UaG+ge8xbXlc8qey+9Wc8encZrGWab11utQp+aJpQ/MH16xCuuZ/60+8ey3kMmrb4b2KGH00I2WH+ncs4PGhAPDrZ+/mof9u7vl3/AOIa3D/1spPeOXtr/wAr5yt/z1p/l6yH9x/+VF5o/wCeRv8AJ1T9/wAJwflsm5OvOxfh5urJ6sz17VVPZnV0dVOuuo2XuGtig3lgaJHkB0bf3TUR16oqlmGXmbhYz7lX3/5X+nvtv5stk/RnAhmp/vxQTGx/0yAr/wA2x69Rd7C8zfUWO4crXMn60B8aGvnGxAkUfJHKt/zcPp1s/wDvHLrIfr3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917qg/wD4UCfLdOkfilS9DbZyi0+//klWzYKvip5gtbjerMDJTVm8axlRjJDHuCsekxK6gFnpqirCm8ZtNvsbyud55nbe7hK2O3AMK8GmcERj/ajVJ8iq149Qt728z/uflpdlt5KX24EqaHIhWhkP+3qsdPNWf06cf+E6/wD277rf/E+dkf8Auk2P7p79f8r0n/PDF/x6Tpz2K/5Uhv8Antl/47H1TP8Azru191dFfza9ndx7IqTSbr612V0nvHCuWZYZ6rCVeWrGoKsJzJj8nBG9NUx/SSCV0NwT7lr2g2y23r2vu9pvFra3E1xG3rRgoqPmOIPkQD1FHu5uVzs/uZa7rZtS6t4bd19KqWND8jwI8wSOtyDovuHaXyB6d637q2NUrU7W7K2jh91Yv9wSS0f8RplauxFWyqoGRwmRWajqVsNFRA6/j3idvW1XOx7tuOz3gpc20zRt89JoGH9FhRlPmCD1lVs+6Wu97Vt+72TVtriJXX1GoVKn+kpqrDyYEdCv7LOjLr3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuq3/AJg/8zLwf/hi4z/3f7m96PV14df/0ttj4ff8zLzn/hi5P/3f7Z96HV24dWQe99U697917r3v3Xuve/de697917r3v3Xuqdv52nzJb4p/D3Obc2rlzju2e/3rutNktTTNFkcVgJ6VG7C3XTFCskJxe36oUUMysrw12Tp5FN0PuVvZ/lIcz81Qz3UWra7Gk0lQCGYH9KM1wQzCpHmqsPPqLPdzms8tcrSw20unc70mKOhyq0/VkH+lU6QfJnU9acn8sv8A7eC/D3/xPvXv/u7g95Ye4n/Ki81/88Mv/HesVvb3/ld+Vv8Anti/491vTfzUP+3d3y7/APENbh/62UnvDH21/wCV85W/560/y9Zje4//ACovNH/PI3+TrQB+I/yO3X8TPkV1Z33tCSZqzYm5aSrzOLilaKPcm0q2+P3dtipIZVMOd29VVFOGa/ildJR6kUjOHmnYLbmfYdy2S6A0zRkKSK6HGUcfNWAP2VHn1hPyxv1zyzvu3b1a1LwyAsoNNaHDof8ATKSPkaHiOvpmdfb82v2jsTZ3ZOycnFmdob82zhN3baykJUpW4TcGOp8njpyqs/ilamqV1oTqjcFW5B988b+xudtvbrb7yMpdQyMjj0ZTQ/l6HzGeuglleW242drf2coe0mjV0YeasAQf2H8ulh7SdKuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de6iZCvocVQVuUydXT0GNxtJU1+QrquZKekoqGjheoq6uqnlZY4KemgjZ3diFVVJJsPd443lkSKJC0jEAAZJJNAAPMk4HVXdI0aSRgqKCSTgADJJPkB1827+ZJ8t675ofLfszt6KqqpNj0td/cvqqgqC6rjuudsTT0mElSnYt9tPuCd58tUpc6aqvkW9gAOgPt9yunKPK237UVH1hHiTEecrgavyUAIPkoPEnrAfn7md+beZ9w3QMTZhvDhHpEhIU08i+XI9WI8utr3/hOv/277rf/ABPnZH/uk2P7xl9+v+V6T/nhi/49J1kr7Ff8qQ3/AD2y/wDHY+qG/wDhQt/28Ryn/iGusP8ArXnPc1exP/Khx/8APXN/z71DHvj/AMr1J/zyQ/8AP3Vgn/CcP5jmSLf3wp3nlSxh/iHafTArJhxExhTsPZ9DrFyFcxZmngU8XyEp9gf3+5TzZc32keKCGen/AFSc/wA4z/tOhv7C81VF9yjdyZFZoK+n+ioP5OB85D1tf+8Y+sleve/de697917r3v3Xuve/de697917r3v3Xuve/de6rf8AmD/zMvB/+GLjP/d/ub3o9XXh1//T22Ph9/zMvOf+GLk//d/tn3odXbh1ZB731Tr3v3Xuve/de697917r3v3XuuiQASSAACSSbAAckkn6Ae/de6+d1/N5+YsvzD+Y29szhMg1V1Z1VLVdWdWxRVCzUNZh9vZCpTObsp/ExgkbeO4fPVxyga2oBSxsT4h7zy9rOVBypynZwzJTcrmk02MhnA0p/tFopH8Wo+fWC/uhzUeaea7yWKSu22xMMOcFVNGcUwfEerA/w6R5dBD/ACy/+3gnw9/8T517/wC7uD2ae4n/ACovNf8Azwy/8d6K/b7/AJXflb/nti/491vTfzUP+3d3y7/8Q1uH/rZSe8MfbX/lfOVv+etP8vWY3uP/AMqLzR/zyN/k6+bl76A9YE9bl3/CdL5jPv3qjefxA3jlRNuXp4zb16x+7qNdVkOttw5Rv7w4amWS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2z/kLvj53/E3sHH7Nwe8KTHYHBb429jsgmY3Lt6t25BkUqcluaSmVKOjyc9xbVdhbn2DeffcDdObeWrrYrPkrdIJJXjJZo2I0owcigSuSB0MOReQdr5U5jtd8vOctsnSJHAVZFB1OpQGpemAT1tF7W3htLfWHh3FsndG3d47fqJZ4KfO7WzeM3Dh556WQw1MMOTxNTV0UstPMpSRVclGFjY+8cLm0urKUwXltJFOAKq6lWFeGGAOfLrIq2ura8iE9pcRywGtGRgymmDlSRg8elF7T9P9e9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+690xbo3Lgdl7a3DvHdOTp8LtnaeDy25dxZmsLikxOCwVBUZTLZKqMaSSfb0NBSySvpVm0qbAnj29bW893cQWltGXuJXVFUcWZiAoHzJIHTNxcQ2lvPdXMgS3iRnZjwVVBLE/IAEnrWh/mH7m/lFfzDt1dbbw3j8+qHrnL9dbfzm24pNrbSz2TGbxuXyNJlKdK45bagaE4uqinMWg2b7l7/Qe8h+Q7f3S5DttwtLTkhriKeRX73UaSoKmml/MUr9g6x/55uPbDnm5sLq651WCWBGTsRjqDEEV1J5GtPtPVdX+yK/yYP+9pWf8A/RfT/wD2K+x5/XT3c/8ACbJ/zlH/AEH0BP6m+0//AIUZ/wDnF/0J17/ZFf5MH/e0rP8A/ovp/wD7Fffv66e7n/hNk/5yj/oPr39Tfaf/AMKM/wDzi/6E62Jfgh8tP5d/W/XfRnwy6M+U+2eyM9hKObaGzYJ8PuHFZvduVra/LbhqpJFl29RYiCvrqqsnfT5VDtwCWIBgbnXlfnzcL/eebd55akt4HOuSjKyooAUfjLEAADh+wdTpyZzNyLYWOzcp7NzHHcTIuhKqwZ2JLH8IUEknFflk9W1+4v6k3r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuq3/AJg/8zLwf/hi4z/3f7m96PV14df/09tj4ff8zLzn/hi5P/3f7Z96HV24dWQe99U697917r3v3Xuve/de697917r3v3XutQP/AIU3dfNSdkfFrtWOAmPP7I371/WVAvZX2jncRuPHQt/ZBkXe1UR9CdJ+tuMqfu7X2vb+ZNsLZjmjlA/06sh/6tr+3rF37wliVv8AlzcguHhkiJ/0jKwH/VQ9auHvJDrHXr3v3Xuve/de6+hX/JI67/0efy2+ghKjpXb4XefYlcGBGr+8+882cTIoJPok27R0TC31vf8APvBT3hv/AK/3A3unwQ+HEP8AaItf+NFus4vaKx+h5B2So75vElP+3kan/GQvVsHuMepK697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917pIdhbTo9/bB3xsXIIklBvTaG5dp10cgDRvR7jwtbh6lHVgVZGhrGBB4I9qrG6exvrO9jP6kMqOPtRgw/mOkt7bLeWV3Zv8EsTofsZSp/w9fK3zeJrMDmsvgsghir8LlK/E10ZBBjrMdVy0dShB5BSaFhz76VwypPDFNGao6hh9hFR1zhmiaCWWFx3oxU/aDQ9Nftzpvr3v3Xurgf5FPXUe/wD+ZF0/WVMH3FF11gewexapCLqkmL2lkcJiZ2uCB9vuDcVG4P8AqgPcVe89+bH2/wB1VTR7h4oh/tnDN/xlT1KPs3Yi95+2p2FUgSWU/khUfsZwevoFe8G+s2+ve/de697917r3v3Xuve/de697917r3v3Xuve/de6rf+YP/My8H/4YuM/93+5vej1deHX/1Ntj4ff8zLzn/hi5P/3f7Z96HV24dWQe99U697917r3v3Xuve/de697917r3v3Xuqaf52Hwh7b+a/wAdev8ADdE7fx+6ezuuOz6fcdJgq/O4PbbZHa+YwGVw24YaLL7jr8Xh4qqCsagqDHNURCSKB9JLhFaWvZ/nHa+UN/vpt6uGj224tihYKz0dXVkJVAWpTWMA5Ir6iKfdzlDc+btisYdmgWTcYLkOFLKlUZWVgGYha10nJGBjODq//wDDFX8z7/vHjG/+jm6P/wDti+8jf9ef25/6Pzf84Lj/AK1dY7/6znuH/wBGJf8AnPb/APW3r3/DFX8z7/vHjG/+jm6P/wDti+/f68/tz/0fm/5wXH/Wrr3+s57h/wDRiX/nPb/9beucX8ij+Z48kaP8fcVCjuitNJ3J0m0cSswDSOsXYUspSMG5CqzWHAJ496PvR7cgEjfWJ/5oXH/WrrY9nPcP/oxr/wA57f8A629b1fxw6s/0HfH/AKT6cLU0k3WHVmxNjVs1GzNSVOS21trG4rJ1dMzqjvDV5CmllUsAxD3Iv7ww5g3L9877vG7Cum5uZJBXiA7lgD9gIHWY+w7aNn2TadqqCba2jjJHAlECkj7SCeho9lHRt1737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvde9+691737r3Xvfuvdag3yS/4Tt/JLsfv7uPsPq7tnoPG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pp4knSKdGKE6grqbWI966sOHX//W2KveunOve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuve/de697917r3v3Xuv//Z',	'mock'),
(2,	'banner',	'',	'main_exam');

DROP TABLE IF EXISTS `utr_master_exams_list`;
CREATE TABLE `utr_master_exams_list` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `msl_name` varchar(512) NOT NULL,
  `msl_disc` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `utr_master_exams_list` (`id`, `msl_name`, `msl_disc`) VALUES
(1,	'MOCK 1',	NULL),
(2,	'MOCK 2',	NULL),
(3,	'MOCK 3',	NULL),
(4,	'MOCK 4',	NULL),
(5,	'MOCK 5',	NULL),
(6,	'MOCK 6',	NULL),
(7,	'MOCK 1-2',	NULL),
(8,	'MOCK 2-2',	NULL);

DROP TABLE IF EXISTS `utr_student_attendance`;
CREATE TABLE `utr_student_attendance` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `student_id` bigint(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `utr_time_table`;
CREATE TABLE `utr_time_table` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `tt_exam_id` int(255) NOT NULL,
  `tt_exam_name` varchar(100) NOT NULL,
  `tt_batch_id` int(255) NOT NULL,
  `tt_batch_name` varchar(100) NOT NULL,
  `tt_exam_data` date NOT NULL,
  `tt_exam_start_time` varchar(50) NOT NULL,
  `tt_exam_end_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `utr_time_table` (`id`, `tt_exam_id`, `tt_exam_name`, `tt_batch_id`, `tt_batch_name`, `tt_exam_data`, `tt_exam_start_time`, `tt_exam_end_time`) VALUES
(3,	3,	'MOCK 3',	2,	'FIRST',	'2019-04-23',	'09:00 am',	'12:00 pm'),
(4,	4,	'MOCK 4',	2,	'FIRST',	'2019-04-25',	'09:00 am',	'12:00 pm'),
(5,	5,	'MOCK 5',	2,	'FIRST',	'2019-04-27',	'09:00 am',	'12:00 pm'),
(6,	6,	'MOCK 6',	2,	'FIRST',	'2019-04-29',	'09:00 am',	'12:00 pm');

DROP TABLE IF EXISTS `utr_unlock_list`;
CREATE TABLE `utr_unlock_list` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `ul_student_id` int(255) NOT NULL,
  `ul_unlock_cause` longtext NOT NULL,
  `ul_time_stamp` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2020-02-04 10:54:07
