 
CREATE DATABASE [IF NOT EXISTS*/`facial`] DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ [DEFAULT] ENCRYPTION='N' */;

USE `facial`;

/*Table structure for table `batch_master` */

DROP TABLE IF EXISTS `batch_master`;

CREATE TABLE batch_master (
  batch_id int NOT NULL AUTO_INCREMENT,
  batch_name varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  sdc_id int DEFAULT NULL,
  course_id int DEFAULT NULL,
  start_date date DEFAULT NULL,
  end_date date DEFAULT NULL,
  duration int DEFAULT NULL,
  start_time varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  end_time varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  day varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  status varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  tp_id int DEFAULT NULL,
  scheme_id int DEFAULT NULL,
  year_id int DEFAULT NULL,
  batch_strength int DEFAULT NULL,
  approved_batch_strength int DEFAULT NULL,
  batch_code varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (batch_id)
) ENGINE=InnoDB AUTO_INCREMENT=427 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `batch_master` */

insert  into `batch_master`(`batch_id`,`batch_name`,`sdc_id`,`course_id`,`start_date`,`end_date`,`duration`,`start_time`,`end_time`,`day`,`status`,`tp_id`,`scheme_id`,`year_id`,`batch_strength`,`approved_batch_strength`,`batch_code`) values 
(1,'Batch-01',1,1,'2022-01-01','2022-01-31',0,'10.00','12.00',NULL,'Active',1,1,2,NULL,NULL,NULL),
(2,'Batch-01',2,1,'2022-10-10','2023-12-10',0,'10.00','12.00',NULL,'Active',2,1,2,NULL,NULL,NULL),
(3,'Batch-01',3,2,'2022-07-03','2023-05-10',0,'10.00','12.00',NULL,'Active',3,2,2,NULL,NULL,NULL),
(4,'Batch-01',4,1,'2022-10-21','2023-12-10',0,'10.00','12.00',NULL,'Active',55,1,2,NULL,NULL,NULL);
 
 

DROP TABLE IF EXISTS `device_master`;

CREATE TABLE device_master (
  device_id int NOT NULL AUTO_INCREMENT,
  tp_id int DEFAULT NULL,
  sdc_id int DEFAULT NULL,
  batch_id int DEFAULT NULL,
  device_code varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  device_link varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  status varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  year_id int DEFAULT NULL,
  total_head int DEFAULT NULL,
  date datetime DEFAULT CURRENT_TIMESTAMP,
  net_speed int DEFAULT NULL,
  cameras varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  install_date datetime DEFAULT NULL,
  file_name varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  add_file_name varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  description varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  active_date datetime DEFAULT NULL,
  rand_no int DEFAULT NULL,
  device_inventory_id int DEFAULT '0',
  PRIMARY KEY (device_id)
) ENGINE=InnoDB AUTO_INCREMENT=1276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `device_master` */
UPDATE device_master
SET device_link = 'rtsp://admin:Password$133@182.70.123.103:557/Streaming/Channels/101'
WHERE device_id = 3;

insert  into `device_master`(`device_id`,`tp_id`,`sdc_id`,`batch_id`,`device_code`,`device_link`,`status`,`year_id`,`total_head`,`date`,`net_speed`,`cameras`,`install_date`,`file_name`,`add_file_name`,`description`,`active_date`,`rand_no`,`device_inventory_id`) values 
(1,1,1,1,'4108904886','rtmp://43.205.56.99:1935/live/a4108980194',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1),
(2,1,1,1,'4108975366','rtsp://admin:Password$133@182.70.123.103:557/Streaming/Channels/101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2),
(3,1,1,1,'4108976586','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,3);
 
/*Table structure for table `sdc_master` */

DROP TABLE IF EXISTS `sdc_master`;

CREATE TABLE `sdc_master` (
  `sdc_id` int NOT NULL AUTO_INCREMENT,
  `sdc_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sdc_address` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tp_id` int DEFAULT NULL,
  `pincode` int DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_person` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_no` bigint DEFAULT NULL,
  `email_id` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `sdc_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `sdc_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sdc_start_date` date DEFAULT NULL,
  `sdc_capacity` int DEFAULT NULL,
  `contact_no1` bigint DEFAULT NULL,
  `contact_no2` bigint DEFAULT NULL,
  PRIMARY KEY (`sdc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `sdc_master` */

insert  into `sdc_master`(`sdc_id`,`sdc_name`,`sdc_address`,`tp_id`,`pincode`,`status`,`contact_person`,`contact_no`,`email_id`,`district_id`,`sdc_password`,`year_id`,`from_date`,`to_date`,`sdc_code`,`sdc_start_date`,`sdc_capacity`,`contact_no1`,`contact_no2`) values 
(1,'Foundation Dausa','Dausa',1,303303,'Active','Singh ',0,'sdc@test.com',145,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,'Foundation karauli.MMYSY.Karauli','City, Karauli',2,322255,'Active','Singh',9649108395,'bjsingh.test@gmail.com',156,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
 
/*Table structure for table `storage_details` */

DROP TABLE IF EXISTS `storage_details`;

CREATE TABLE `storage_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tp_id` int DEFAULT NULL,
  `sdc_id` int DEFAULT NULL,
  `capure_datetime` date DEFAULT NULL,
  `file_name` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` int DEFAULT NULL,
  `batch_id` int DEFAULT NULL,
  `full_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160903 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `storage_details` */

insert  into `storage_details`(`id`,`tp_id`,`sdc_id`,`capure_datetime`,`file_name`,`type`,`batch_id`,`full_url`) values 
(1,26,32,'2022-12-13','1673439383-Meritorium-Education1301.mkv',1,NULL,'26/32/1673439383-Meritorium-Education1301.mkv'),
(2,26,32,'2022-12-14','1673439785-Meritorium-Education14.mkv',1,NULL,'26/32/1673439785-Meritorium-Education14.mkv'),
(3,26,32,'2022-12-14','1673439823-Meritorium-Education1401.mkv',1,NULL,'26/32/1673439823-Meritorium-Education1401.mkv'),
(4,26,32,'2022-12-14','1673439848-Meritorium-Education1402.mkv',1,NULL,'26/32/1673439848-Meritorium-Education1402.mkv'),
(5,26,32,'2022-12-14','1673439930-Meritorium-Education14013.mkv',1,NULL,'26/32/1673439930-Meritorium-Education14013.mkv')

/*Table structure for table `trainingpartner_master` */

DROP TABLE IF EXISTS `trainingpartner_master`;

CREATE TABLE `trainingpartner_master` (
  `tp_id` int NOT NULL AUTO_INCREMENT,
  `TP_name` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tp_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pan_no` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tp_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `pin_code` int DEFAULT NULL,
  `district_id` int DEFAULT NULL,
  `contact_no` bigint DEFAULT NULL,
  `email_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `admin_name` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `admin_contact` bigint DEFAULT NULL,
  `admin_email` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tp_password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  PRIMARY KEY (`tp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `trainingpartner_master` */

insert  into `trainingpartner_master`(`tp_id`,`TP_name`,`tp_code`,`pan_no`,`tp_address`,`pin_code`,`district_id`,`contact_no`,`email_id`,`admin_name`,`admin_contact`,`admin_email`,`status`,`tp_password`,`year_id`) values 
(1,'Aaruthal Foundation Dausa','TP0001','','Dausa\n',0,NULL,8209451574,'aaruthalkarauli@gmail.com','Brahmjeet Singh ',NULL,NULL,'Active',NULL,NULL),
(2,'Aaruthal Foundation karauli','TP0002','','karauli',0,NULL,9649108395,'brahmjeet@gmail.com','Brahmjeet Singh ',NULL,NULL,'Active',NULL,NULL);
 