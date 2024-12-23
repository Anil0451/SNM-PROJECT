-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: snpproject
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `filedata`
--

DROP TABLE IF EXISTS `filedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filedata` (
  `fid` int unsigned NOT NULL AUTO_INCREMENT,
  `fdata` blob,
  `filename` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`fid`),
  KEY `added_by` (`added_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filedata`
--

LOCK TABLES `filedata` WRITE;
/*!40000 ALTER TABLE `filedata` DISABLE KEYS */;
INSERT INTO `filedata` VALUES (2,_binary 'Microsoft Windows [Version 10.0.22631.4317]\r\n(c) Microsoft Corporation. All rights reserved.\r\n\r\nC:\\Users\\ANIL TALLURI>mysql -u root -p\r\nEnter password: *****\r\nWelcome to the MySQL monitor.  Commands end with ; or \\g.\r\nYour MySQL connection id is 15\r\nServer version: 8.0.37 MySQL Community Server - GPL\r\n\r\nCopyright (c) 2000, 2024, Oracle and/or its affiliates.\r\n\r\nOracle is a registered trademark of Oracle Corporation and/or its\r\naffiliates. Other names may be trademarks of their respective\r\nowners.\r\n\r\nType \'help;\' or \'\\h\' for help. Type \'\\c\' to clear the current input statement.\r\n\r\nmysql> show databases;\r\n+--------------------+\r\n| Database           |\r\n+--------------------+\r\n| employee           |\r\n| information_schema |\r\n| institute          |\r\n| library            |\r\n| library_management |\r\n| movie              |\r\n| mysql              |\r\n| performance_schema |\r\n| practice           |\r\n| sample             |\r\n| student            |\r\n| studentmangsystem  |\r\n| sys                |\r\n| work               |\r\n+--------------------+\r\n14 rows in set (0.01 sec)\r\n\r\nmysql> use work\r\nDatabase changed\r\nmysql> show tables;\r\n+----------------+\r\n| Tables_in_work |\r\n+----------------+\r\n| dept           |\r\n| emp            |\r\n+----------------+\r\n2 rows in set (0.01 sec)\r\n\r\nmysql> select * from emp;\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n| emp_id | emp_name | salary      | email             | doj        | exp_year | dept_id |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n|    101 | mahi     | 98989898.99 | mahi@gmail.com    | 2024-04-05 |        2 |       1 |\r\n|    102 | sai      | 98989898.99 | sai@gmail.com     | 2023-03-05 |        3 |       1 |\r\n|    103 | khiladi  | 98989899.99 | khiladi@gmail.com | 2012-03-05 |        3 |       2 |\r\n|    104 | likhith  | 99989899.99 | likhith@gmail.com | 2015-06-05 |        2 |       3 |\r\n|    105 | vamsi    | 99988899.99 | vamsi@gmail.com   | 2019-08-13 |        2 |       3 |\r\n|    106 | khasim   | 99998899.98 | khasim@gmail.com  | 2020-08-13 |        1 |       3 |\r\n|    107 | anil     | 88888899.88 | anil@gmail.com    | 2020-07-12 |        1 |       4 |\r\n|    108 | pichi    | 88888898.98 | pichi@gmail.com   | 2024-08-19 |        1 |       4 |\r\n|    109 | dhanush  | 66666666.77 | dhanu@gmail.com   | 2024-09-23 |        4 |    NULL |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n9 rows in set (0.00 sec)\r\n\r\nmysql> select salary,emp_name from emp where salary=(select min(salary) from emp);\r\n+-------------+----------+\r\n| salary      | emp_name |\r\n+-------------+----------+\r\n| 66666666.77 | dhanush  |\r\n+-------------+----------+\r\n1 row in set (0.00 sec)\r\n\r\nmysql> select salary,emp_name from emp where salary=(select max(salary) from emp);\r\n+-------------+----------+\r\n| salary      | emp_name |\r\n+-------------+----------+\r\n| 99998899.98 | khasim   |\r\n+-------------+----------+\r\n1 row in set (0.00 sec)\r\n\r\nmysql> select salary,emp_name from emp where salary=(select avg(salary) from emp);\r\nEmpty set (0.00 sec)\r\n\r\nmysql> select salary,emp_name from emp where avg(salary) from emp;\r\nERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'from emp\' at line 1\r\nmysql> select emp_id,salary,(select max(salary) from emp) from emp;\r\n+--------+-------------+-------------------------------+\r\n| emp_id | salary      | (select max(salary) from emp) |\r\n+--------+-------------+-------------------------------+\r\n|    101 | 98989898.99 |                   99998899.98 |\r\n|    102 | 98989898.99 |                   99998899.98 |\r\n|    103 | 98989899.99 |                   99998899.98 |\r\n|    104 | 99989899.99 |                   99998899.98 |\r\n|    105 | 99988899.99 |                   99998899.98 |\r\n|    106 | 99998899.98 |                   99998899.98 |\r\n|    107 | 88888899.88 |                   99998899.98 |\r\n|    108 | 88888898.98 |                   99998899.98 |\r\n|    109 | 66666666.77 |                   99998899.98 |\r\n+--------+-------------+-------------------------------+\r\n9 rows in set (0.00 sec)\r\n\r\nmysql> select emp_id,salary,(select min(salary) from emp) from emp;\r\n+--------+-------------+-------------------------------+\r\n| emp_id | salary      | (select min(salary) from emp) |\r\n+--------+-------------+-------------------------------+\r\n|    101 | 98989898.99 |                   66666666.77 |\r\n|    102 | 98989898.99 |                   66666666.77 |\r\n|    103 | 98989899.99 |                   66666666.77 |\r\n|    104 | 99989899.99 |                   66666666.77 |\r\n|    105 | 99988899.99 |                   66666666.77 |\r\n|    106 | 99998899.98 |                   66666666.77 |\r\n|    107 | 88888899.88 |                   66666666.77 |\r\n|    108 | 88888898.98 |                   66666666.77 |\r\n|    109 | 66666666.77 |                   66666666.77 |\r\n+--------+-------------+-------------------------------+\r\n9 rows in set (0.00 sec)\r\n\r\nmysql> select emp_id,salary,(select avg(salary) from emp) from emp;\r\n+--------+-------------+-------------------------------+\r\n| emp_id | salary      | (select avg(salary) from emp) |\r\n+--------+-------------+-------------------------------+\r\n|    101 | 98989898.99 |               93487984.840000 |\r\n|    102 | 98989898.99 |               93487984.840000 |\r\n|    103 | 98989899.99 |               93487984.840000 |\r\n|    104 | 99989899.99 |               93487984.840000 |\r\n|    105 | 99988899.99 |               93487984.840000 |\r\n|    106 | 99998899.98 |               93487984.840000 |\r\n|    107 | 88888899.88 |               93487984.840000 |\r\n|    108 | 88888898.98 |               93487984.840000 |\r\n|    109 | 66666666.77 |               93487984.840000 |\r\n+--------+-------------+-------------------------------+\r\n9 rows in set (0.00 sec)\r\n\r\nmysql> select emp_id,salary,(select count(salary) from emp) from emp;\r\n+--------+-------------+---------------------------------+\r\n| emp_id | salary      | (select count(salary) from emp) |\r\n+--------+-------------+---------------------------------+\r\n|    101 | 98989898.99 |                               9 |\r\n|    102 | 98989898.99 |                               9 |\r\n|    103 | 98989899.99 |                               9 |\r\n|    104 | 99989899.99 |                               9 |\r\n|    105 | 99988899.99 |                               9 |\r\n|    106 | 99998899.98 |                               9 |\r\n|    107 | 88888899.88 |                               9 |\r\n|    108 | 88888898.98 |                               9 |\r\n|    109 | 66666666.77 |                               9 |\r\n+--------+-------------+---------------------------------+\r\n9 rows in set (0.01 sec)\r\n\r\nmysql> -- fetch emp details where the dept has count emp >= 3;\r\nmysql> select * from where dept_id = (select dept_id from emp group by dept_id having count(emp_id)>=3);\r\nERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'where dept_id = (select dept_id from emp group by dept_id having count(emp_id)>=\' at line 1\r\nmysql> select * from emp where dept_id = (select dept_id from emp group by dept_id having count(emp_id)>=3);\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n| emp_id | emp_name | salary      | email             | doj        | exp_year | dept_id |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n|    104 | likhith  | 99989899.99 | likhith@gmail.com | 2015-06-05 |        2 |       3 |\r\n|    105 | vamsi    | 99988899.99 | vamsi@gmail.com   | 2019-08-13 |        2 |       3 |\r\n|    106 | khasim   | 99998899.98 | khasim@gmail.com  | 2020-08-13 |        1 |       3 |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n3 rows in set (0.00 sec)\r\n\r\nmysql> select * from emp where dept_id = (select dept_id from emp group by dept_id having count(emp_id)<=3);\r\nERROR 1242 (21000): Subquery returns more than 1 row\r\nmysql> select * from emp where dept_id = (select dept_id from emp group by dept_id having count(emp_id)<=1);\r\nERROR 1242 (21000): Subquery returns more than 1 row\r\nmysql> select * from emp where dept_id = (select dept_id from emp group by dept_id having count(emp_id)>=1);\r\nERROR 1242 (21000): Subquery returns more than 1 row\r\nmysql> select * from emp where dept_id = (select dept_id from emp group by dept_id having count(emp_id)>=4);\r\nEmpty set (0.00 sec)\r\n\r\nmysql> select dept_id from emp group by dept_id having count(emp_id)>=3;\r\n+---------+\r\n| dept_id |\r\n+---------+\r\n|       3 |\r\n+---------+\r\n1 row in set (0.00 sec)\r\n\r\nmysql> select * from emp where dept_id = 3;\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n| emp_id | emp_name | salary      | email             | doj        | exp_year | dept_id |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n|    104 | likhith  | 99989899.99 | likhith@gmail.com | 2015-06-05 |        2 |       3 |\r\n|    105 | vamsi    | 99988899.99 | vamsi@gmail.com   | 2019-08-13 |        2 |       3 |\r\n|    106 | khasim   | 99998899.98 | khasim@gmail.com  | 2020-08-13 |        1 |       3 |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n3 rows in set (0.00 sec)\r\n\r\nmysql> select from dept_id where group by emp_id;\r\nERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'from dept_id where group by emp_id\' at line 1\r\nmysql> select * from emp where dept_id = 3;\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n| emp_id | emp_name | salary      | email             | doj        | exp_year | dept_id |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n|    104 | likhith  | 99989899.99 | likhith@gmail.com | 2015-06-05 |        2 |       3 |\r\n|    105 | vamsi    | 99988899.99 | vamsi@gmail.com   | 2019-08-13 |        2 |       3 |\r\n|    106 | khasim   | 99998899.98 | khasim@gmail.com  | 2020-08-13 |        1 |       3 |\r\n+--------+----------+-------------+-------------------+------------+----------+---------+\r\n3 rows in set (0.00 sec)\r\n\r\nmysql> select dept_id from emp group by dpt_id having count(emp_id)>=2;\r\nERROR 1054 (42S22): Unknown column \'dpt_id\' in \'group statement\'\r\nmysql> select dept_id from emp group by dept_id having count(emp_id)>=2;\r\n+---------+\r\n| dept_id |\r\n+---------+\r\n|       1 |\r\n|       3 |\r\n|       4 |\r\n+---------+\r\n3 rows in set (0.00 sec)\r\n\r\nmysql> select * from emp where dept_id','TYPES OF SUB QUERIES 22-10-2024.txt','2024-12-21 12:56:22',3);
/*!40000 ALTER TABLE `filedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `nid` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `ndescription` text,
  `create_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `title` (`title`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (2,'python','high level programming language','2024-12-17 11:16:51',3),(3,'hi','bye','2024-12-17 11:20:43',3);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
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
  `useremail` varchar(50) NOT NULL,
  `password` varbinary(10) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `useremail` (`useremail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'anil','tallurianil1704@gmail.com',_binary '1234');
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

-- Dump completed on 2024-12-23 11:50:49
