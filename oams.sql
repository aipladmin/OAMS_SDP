-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 12, 2019 at 03:55 AM
-- Server version: 5.7.26
-- PHP Version: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oams`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment_master`
--

DROP TABLE IF EXISTS `appointment_master`;
CREATE TABLE IF NOT EXISTS `appointment_master` (
  `AID` int(10) NOT NULL AUTO_INCREMENT,
  `UID` int(10) NOT NULL,
  `CID` int(10) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Files_1` blob,
  `Files_2` blob,
  `Status` varchar(30) NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`AID`),
  KEY `uid_frky` (`UID`),
  KEY `cnsltnt` (`CID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment_master`
--

INSERT INTO `appointment_master` (`AID`, `UID`, `CID`, `Date`, `Time`, `Files_1`, `Files_2`, `Status`) VALUES
(7, 75, 25, '2021-09-09', '04:03:00', NULL, NULL, 'pending'),
(8, 71, 24, '2019-12-12', '13:00:00', NULL, NULL, 'Approved'),
(9, 78, 25, '2019-12-08', '13:13:00', NULL, NULL, 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `consultant_master`
--

DROP TABLE IF EXISTS `consultant_master`;
CREATE TABLE IF NOT EXISTS `consultant_master` (
  `UID` int(10) NOT NULL,
  `CID` int(10) NOT NULL AUTO_INCREMENT,
  `Add_Line1` varchar(50) NOT NULL,
  `Add_Line2` varchar(50) NOT NULL,
  `Add_Line3` varchar(50) NOT NULL,
  `Landmark` varchar(50) NOT NULL,
  `Area` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Pincode` int(6) NOT NULL,
  PRIMARY KEY (`CID`),
  UNIQUE KEY `UID` (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `consultant_master`
--

INSERT INTO `consultant_master` (`UID`, `CID`, `Add_Line1`, `Add_Line2`, `Add_Line3`, `Landmark`, `Area`, `City`, `State`, `Pincode`) VALUES
(71, 24, 'G206 Surel Appartment', 'Nr Devashish School ', 'Bodakdev', 'tran rasta', 'Bodakdev', 'Ahmedabad', 'Goa', 380054),
(72, 25, 'G206 Surel Appartment', 'Nr Mocha Cafe', 'Bodakdev', '', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380054);

-- --------------------------------------------------------

--
-- Table structure for table `monthlyscheduledetails`
--

DROP TABLE IF EXISTS `monthlyscheduledetails`;
CREATE TABLE IF NOT EXISTS `monthlyscheduledetails` (
  `ID` int(10) NOT NULL,
  `MonthlyID` int(10) NOT NULL AUTO_INCREMENT,
  `Day_of_week` int(11) DEFAULT NULL,
  `week_of_month` int(10) DEFAULT NULL,
  `day_of_month` int(10) DEFAULT NULL,
  PRIMARY KEY (`MonthlyID`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `profession_master`
--

DROP TABLE IF EXISTS `profession_master`;
CREATE TABLE IF NOT EXISTS `profession_master` (
  `PID` int(10) NOT NULL AUTO_INCREMENT,
  `CID` int(10) NOT NULL,
  `Profession_Type_ID` int(10) NOT NULL,
  `Specialization_1` varchar(50) DEFAULT NULL,
  `Specialization_2` varchar(50) DEFAULT NULL,
  `Specialization_3` varchar(50) DEFAULT NULL,
  `Qualification_1` varchar(50) DEFAULT NULL,
  `Qualification_2` varchar(50) DEFAULT NULL,
  `Qualification_3` varchar(50) DEFAULT NULL,
  `Experience` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`PID`),
  UNIQUE KEY `CID` (`CID`),
  KEY `fkconprofession` (`Profession_Type_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profession_master`
--

INSERT INTO `profession_master` (`PID`, `CID`, `Profession_Type_ID`, `Specialization_1`, `Specialization_2`, `Specialization_3`, `Qualification_1`, `Qualification_2`, `Qualification_3`, `Experience`) VALUES
(5, 24, 2, 'Hepatology', 'Infectious disease', 'Oncology', 'Master of Clinical Medicine (MCM)', 'Master of Medical Science (MMSc, MMedSc)', 'Master of Medicine (MM, MMed)', '30+'),
(6, 25, 2, 'Hepatology', 'Infectious disease', 'Oncology', 'Doctor of Medicine by research (MD(Res), DM)', 'Doctor of Philosophy (PhD, DPhil)', 'Master of Clinical Medicine (MCM)', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `profession_type`
--

DROP TABLE IF EXISTS `profession_type`;
CREATE TABLE IF NOT EXISTS `profession_type` (
  `Profession_Type_ID` int(10) NOT NULL AUTO_INCREMENT,
  `Profession_Type` varchar(30) NOT NULL,
  PRIMARY KEY (`Profession_Type_ID`),
  UNIQUE KEY `Profession_Type` (`Profession_Type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profession_type`
--

INSERT INTO `profession_type` (`Profession_Type_ID`, `Profession_Type`) VALUES
(2, 'Doctors'),
(1, 'Lawyers');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE IF NOT EXISTS `schedule` (
  `STID` int(11) NOT NULL,
  `CID` int(10) NOT NULL,
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Limit` int(2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CID` (`CID`),
  KEY `schedule_type_ID` (`STID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`STID`, `CID`, `ID`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`, `Limit`) VALUES
(1, 24, 5, '2019-11-02', '2019-12-29', '10:00:00', '18:00:00', 6),
(1, 25, 6, '2019-11-02', '2019-12-30', '10:00:00', '19:00:00', 5);

-- --------------------------------------------------------

--
-- Table structure for table `schedule_type_master`
--

DROP TABLE IF EXISTS `schedule_type_master`;
CREATE TABLE IF NOT EXISTS `schedule_type_master` (
  `STID` int(10) NOT NULL AUTO_INCREMENT,
  `Type` varchar(20) NOT NULL,
  PRIMARY KEY (`STID`),
  UNIQUE KEY `Type` (`Type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule_type_master`
--

INSERT INTO `schedule_type_master` (`STID`, `Type`) VALUES
(1, 'Daily'),
(3, 'Monthly'),
(2, 'Weekly');

-- --------------------------------------------------------

--
-- Table structure for table `user_master`
--

DROP TABLE IF EXISTS `user_master`;
CREATE TABLE IF NOT EXISTS `user_master` (
  `UTMID` int(10) NOT NULL,
  `UID` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(75) NOT NULL,
  `Email_ID` varchar(60) NOT NULL,
  `Phone_No` bigint(10) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Activation` varchar(10) NOT NULL,
  `Activation_Log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `Email_ID` (`Email_ID`),
  UNIQUE KEY `Phone_No` (`Phone_No`),
  KEY `UTMID` (`UTMID`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_master`
--

INSERT INTO `user_master` (`UTMID`, `UID`, `Name`, `Email_ID`, `Phone_No`, `Password`, `Activation`, `Activation_Log`) VALUES
(1, 1, 'admin', 'admin@admin.com', 942600621, '21232f297a57a5a743894a0e4a801fc3', 'activated', '2019-09-18 08:24:32'),
(4, 9, 'Madhav', '123@gmail.com', 838283828, '202cb962ac59075b964b07152d234b70', 'activated', '2019-09-18 10:31:36'),
(2, 27, 'Manager', 'manager@manager.com', 999823373, '4213b7417c861ca31c76f8c837706180', 'activated', '2019-09-22 10:45:49'),
(2, 29, 'ManagerMadhav', 'parkh.madhav1999@gmail.com', 9998256749, 'ae3d664409ccc81ab6005b7073157f83', 'activated', '2019-10-12 09:52:06'),
(3, 71, 'Manan Chajjed', 'mananchajjed@gmail.com', 9863877278, '4213b7417c861ca31c76f8c837706180', 'activated', '2019-10-19 11:09:51'),
(3, 72, 'Divith Chajjed', 'divithchajjed@gmail.com', 9832675477, '5c3bcb3064cceba94aa23fd88ee8bf5c', 'activated', '2019-10-28 04:04:19'),
(4, 73, 'Vallabhbhai Patel', 'vallabhbhaipatel@gmail.com', 9284567853, 'f1547379b09d8d6f40a6d88af1200f55', 'activated', '2019-10-31 13:10:58'),
(4, 74, 'Bhagat Singh', 'bhagatsingh@gmail.com', 8790987648, 'dd0f18900f8bcb8c1c42cebb8fb4b97e', 'activated', '2019-10-31 13:11:44'),
(4, 75, 'Chandra Shekhar Azad', 'chandrashekharazad@gmail.com', 7298628743, 'f9c0d529f31c318090b3dc3c374762c1', 'activated', '2019-10-31 13:13:33'),
(4, 76, 'Chittaranjan Das', 'chittaranjandas@gmail.com', 6720984361, '9b183e87158a4f7ebe172d77d4e92eae', 'activated', '2019-10-31 13:14:09'),
(4, 77, 'Ram Prasad Bismil', 'ramprasadbismil@gmail.com', 8976325681, '8d99b355e256b1d784a0b17dcf2c1054', 'activated', '2019-10-31 13:15:24'),
(4, 78, 'Udham Singh', 'udhamsingh@gmail.com', 8983267877, 'aefd1eee43340366f16591d11795dce4', 'activated', '2019-10-31 13:16:13'),
(4, 79, 'Veer Damodar Savarkar', 'veerdamodarsavarkar@gmail.com', 8976324311, '7abb217bac22bc75c7794184850426f9', 'activated', '2019-10-31 13:17:47'),
(4, 80, 'Madan Lal Dhingra', 'madanlaldhingra@gmail.com', 8943112675, 'eb4585e09bfdeaade88eecae92318807', 'activated', '2019-10-31 13:19:16'),
(4, 81, 'Kartar Singh Sarabha', 'kartarsinghsarabha@gmail.com', 7643546798, '1e234551e9c3b0ab3599126f7362a1ff', 'activated', '2019-10-31 13:22:01'),
(4, 82, 'Subhas Chandra Bose', 'subaschandrabose@gmail.com', 9832456792, '4f8c4e14e6e3d123744b1d0549f85c57', 'activated', '2019-10-31 13:23:22'),
(4, 83, 'Bal Gangadhar Tilak', 'balgangadhartilak@gmail.com', 8743567782, 'bb0bff80921a8c2d30fe73d82c13ae9a', 'activated', '2019-10-31 13:26:02'),
(4, 84, 'Rani Laxmi Bai', 'ranilakshmibai@gmail.com', 8976456643, 'f947f70f6382e219077699570a3ae5e8', 'activated', '2019-10-31 13:27:19'),
(4, 85, 'Khudiram Bose', 'khudirambose@gmail.com', 8767561121, '86ce6f18af8444567105d1a9916950cb', 'activated', '2019-10-31 13:28:22'),
(4, 86, 'Batukeshwar Dutt', 'batukeshwardutt@gmail.com', 7898783210, '7ef658e8d885969c1315e218565f7cb1', 'activated', '2019-10-31 13:29:30'),
(4, 87, 'Sukhdev Thapar', 'sukhdevthapar@gmail.com', 9823010234, 'b3ef7b4c07991f8aaf04403e483d92a0', 'activated', '2019-10-31 13:30:17'),
(4, 88, 'Bhagwati Charan Vohra', 'bhagwaticharanvohra@gmail.com', 7893210033, 'fc5f181baf8626650d8c37acc0a34b8d', 'activated', '2019-10-31 13:31:37'),
(4, 89, 'Alluri Sitarama Raju', 'allurisitaramaraju@gmail.com', 9998877665, 'fc8349d70799322ef611ba595baeb730', 'activated', '2019-10-31 13:32:44'),
(4, 90, 'Rash Behari Bose', 'rashbeharibose@gmail.com', 8981216666, 'f4c21fb0691bee3f0bc706e381979e35', 'activated', '2019-10-31 13:33:41'),
(4, 91, 'Badal Gupta', 'badalgupta@gmail.com', 8921346755, '7a321de1da7769e2bce3f8676489feb6', 'activated', '2019-10-31 13:35:04'),
(4, 92, 'Dinesh Gupta', 'dineshgupta@gmail.com', 9911228876, '78a54e4dc2f0721ff4d6aa45d07664ba', 'activated', '2019-10-31 13:35:31'),
(4, 93, 'Ramesh Chandra Jha', 'rameshchnadrajha@gmail.com', 8723451211, 'c20e5c7639815873f27e64e20e3693ed', 'activated', '2019-10-31 13:36:11'),
(4, 94, 'Bhavabhushan Mitra', 'bhavabhushanmitra@gmail.com', 8912551234, '5c5fcbf5f525172e2c316aca43162f08', 'activated', '2019-10-31 13:36:52'),
(4, 95, 'Kalpana Datta', 'kalpanadatta@gmail.com', 8887771212, '3fe2321475feb8b383d7989d0ac3af72', 'activated', '2019-10-31 13:37:41'),
(4, 96, 'Bina Das', 'binadas@gmail.com', 9998912345, 'ad61fb41d5572eb4b7214b2bef82d0cb', 'activated', '2019-10-31 13:38:12'),
(4, 97, 'JRD Tata', 'jrdtata@gmail.com', 980980098, '93205da28e292c9d3a3f678b9337432b', 'activated', '2019-10-31 13:39:07'),
(4, 98, 'Satish Dhawan', 'satishdhawan@gmail.com', 9871235671, 'bf8bfc919ee687e7873d828223eb53fb', 'activated', '2019-10-31 13:40:09'),
(4, 99, 'Vikram Sarabhai', 'vikramsarabhai@gmail.com', 9876543434, 'a492fc5bd62da261daa86db70007b25c', 'activated', '2019-10-31 13:41:30'),
(4, 100, 'S.K Mitra', 'skmitra@gmail.com', 9812674562, '612dcac3dd87acf24e0d71c92a50d818', 'activated', '2019-10-31 13:42:06'),
(4, 101, 'Homi Bhabha', 'homibhabha@gmail.com', 9123456788, 'a40f1b210fc7dfa5d855ab4fa5a4e67f', 'activated', '2019-10-31 13:43:56'),
(4, 102, 'us1', 'us1@gmail.com', 8291892322, '22eba7690cf4631024a5629cd13e092b', 'activated', '2019-11-12 04:01:06'),
(2, 103, 'DELL', 'nitanimesh@qwerty.com', 8433434323, '15e5b123042f06d18c689080ce9a667d', 'activated', '2019-11-30 05:29:40'),
(2, 105, 'DELLIO', 'imeshqwert@qwerty.com', 6578998742, 'dce3fdec38db87dc7ffbf6807c583b20', 'activated', '2019-11-30 05:49:07');

-- --------------------------------------------------------

--
-- Table structure for table `user_type_master`
--

DROP TABLE IF EXISTS `user_type_master`;
CREATE TABLE IF NOT EXISTS `user_type_master` (
  `UTMID` int(10) NOT NULL AUTO_INCREMENT,
  `User_Type` varchar(15) NOT NULL,
  PRIMARY KEY (`UTMID`),
  UNIQUE KEY `User_Type` (`User_Type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_type_master`
--

INSERT INTO `user_type_master` (`UTMID`, `User_Type`) VALUES
(1, 'admin'),
(3, 'consultant'),
(2, 'manager'),
(4, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `weeklyscheduledetails`
--

DROP TABLE IF EXISTS `weeklyscheduledetails`;
CREATE TABLE IF NOT EXISTS `weeklyscheduledetails` (
  `ID` int(11) NOT NULL,
  `WeeklyID` int(10) NOT NULL AUTO_INCREMENT,
  `OnMonday` tinyint(1) DEFAULT NULL,
  `OnTuesday` tinyint(1) DEFAULT NULL,
  `OnWednesday` tinyint(1) DEFAULT NULL,
  `OnThursday` tinyint(1) DEFAULT NULL,
  `OnFriday` tinyint(1) DEFAULT NULL,
  `OnSaturday` tinyint(1) DEFAULT NULL,
  `OnSunday` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`WeeklyID`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment_master`
--
ALTER TABLE `appointment_master`
  ADD CONSTRAINT `cnsltnt` FOREIGN KEY (`CID`) REFERENCES `consultant_master` (`CID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `uid_frky` FOREIGN KEY (`UID`) REFERENCES `user_master` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `consultant_master`
--
ALTER TABLE `consultant_master`
  ADD CONSTRAINT `uid_constraintss` FOREIGN KEY (`UID`) REFERENCES `user_master` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `monthlyscheduledetails`
--
ALTER TABLE `monthlyscheduledetails`
  ADD CONSTRAINT `monthly` FOREIGN KEY (`ID`) REFERENCES `prac`.`schedule` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `profession_master`
--
ALTER TABLE `profession_master`
  ADD CONSTRAINT `cid_constraints` FOREIGN KEY (`CID`) REFERENCES `consultant_master` (`CID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkconprofession` FOREIGN KEY (`Profession_Type_ID`) REFERENCES `profession_type` (`Profession_Type_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `CID` FOREIGN KEY (`CID`) REFERENCES `consultant_master` (`CID`),
  ADD CONSTRAINT `schedule_type_ID` FOREIGN KEY (`STID`) REFERENCES `schedule_type_master` (`STID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_master`
--
ALTER TABLE `user_master`
  ADD CONSTRAINT `user_master_ibfk_1` FOREIGN KEY (`UTMID`) REFERENCES `user_type_master` (`UTMID`);

--
-- Constraints for table `weeklyscheduledetails`
--
ALTER TABLE `weeklyscheduledetails`
  ADD CONSTRAINT `weekly` FOREIGN KEY (`ID`) REFERENCES `schedule` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
