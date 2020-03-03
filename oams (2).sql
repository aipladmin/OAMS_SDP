-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2020 at 06:16 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

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

CREATE TABLE `appointment_master` (
  `AID` int(10) NOT NULL,
  `UID` int(10) NOT NULL,
  `CID` int(10) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Files_1` blob DEFAULT NULL,
  `Files_2` blob DEFAULT NULL,
  `Status` varchar(30) NOT NULL DEFAULT 'pending',
  `Appoint_Booked` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appointment_master`
--

INSERT INTO `appointment_master` (`AID`, `UID`, `CID`, `Date`, `Time`, `Files_1`, `Files_2`, `Status`, `Appoint_Booked`) VALUES
(22, 74, 27, '2020-03-04', '13:00:00', NULL, NULL, 'approved', '2020-03-03 09:53:11'),
(23, 83, 27, '2020-03-04', '14:00:00', NULL, NULL, 'approved', '2020-03-03 10:14:42'),
(24, 83, 27, '2020-03-04', '14:00:00', NULL, NULL, 'approved', '2020-03-03 10:14:46');

-- --------------------------------------------------------

--
-- Table structure for table `consultant_master`
--

CREATE TABLE `consultant_master` (
  `UID` int(10) NOT NULL,
  `CID` int(10) NOT NULL,
  `Add_Line1` varchar(50) NOT NULL,
  `Add_Line2` varchar(50) NOT NULL,
  `Add_Line3` varchar(50) NOT NULL,
  `Landmark` varchar(50) NOT NULL,
  `Area` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Pincode` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `consultant_master`
--

INSERT INTO `consultant_master` (`UID`, `CID`, `Add_Line1`, `Add_Line2`, `Add_Line3`, `Landmark`, `Area`, `City`, `State`, `Pincode`) VALUES
(72, 25, 'G206 Surel Appartment', 'Nr Mocha Cafe', 'Opposite Hyderabadi biryani', 'B/h Starbucks Cafe', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380054),
(112, 27, 'B-702 LWR Building,', 'Nr. mocha cafe', 'Opposite Hyderabadi biryani', 'B/h Starbucks Cafe', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380056),
(116, 30, 'B-702 LWR Building,', '', '', 'Nr starbucks cafe', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380054),
(123, 33, 'D-702 The First', 'Nr Rajpath Club', 'B/h Asia Bariatricss', 'Punjab Honda', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380054),
(132, 39, 'The First', 'Nr Rajpath Club', 'B/h Asia Bariatricss', 'Punjab Honda', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380054),
(133, 40, 'Pegasus', 'ATVPP2430M', '12ATVPP2430M1JL', 'Punjab Honda', 'Bodakdev', 'Ahmedabad', 'Gujarat', 380054),
(139, 43, 'H-25', 'Flower kunj society', 'Swastik char rasta', 'near Chamunda dairy', 'Navrangpura', 'Ahmedabad', 'Gujarat', 380009),
(147, 46, 'TG-12', 'Jay niwas colony', 'Near gokul road', 'ravi petrol pump', 'Manik chowk', 'Mathura', 'Uttar Pradesh', 283009);

-- --------------------------------------------------------

--
-- Stand-in structure for view `demo view`
-- (See below for the actual view)
--
CREATE TABLE `demo view` (
`name` varchar(75)
,`Email_ID` varchar(60)
,`Phone_No` bigint(10)
,`Experience` varchar(3)
);

-- --------------------------------------------------------

--
-- Table structure for table `feedback_master`
--

CREATE TABLE `feedback_master` (
  `FID` int(10) NOT NULL,
  `UID` int(10) NOT NULL,
  `Ratings` int(1) NOT NULL,
  `Comments` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `monthlyscheduledetails`
--

CREATE TABLE `monthlyscheduledetails` (
  `ID` int(10) NOT NULL,
  `MonthlyID` int(10) NOT NULL,
  `Day_of_week` int(11) DEFAULT NULL,
  `week_of_month` int(10) DEFAULT NULL,
  `day_of_month` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `profession_details`
--

CREATE TABLE `profession_details` (
  `PDID` int(10) NOT NULL,
  `Profession_Type_ID` int(10) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Details` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `profession_details`
--

INSERT INTO `profession_details` (`PDID`, `Profession_Type_ID`, `Type`, `Details`) VALUES
(1, 2, 'specialization', 'Cardiologist'),
(2, 2, 'specialization', 'Hepatology'),
(3, 2, 'specialization', 'Oncology'),
(4, 1, 'specialization', 'Criminal'),
(5, 1, 'specialization', 'Patent');

-- --------------------------------------------------------

--
-- Table structure for table `profession_master`
--

CREATE TABLE `profession_master` (
  `PID` int(10) NOT NULL,
  `CID` int(10) NOT NULL,
  `Profession_Type_ID` int(10) NOT NULL,
  `Specialization_1` varchar(50) DEFAULT NULL,
  `Specialization_2` varchar(50) DEFAULT NULL,
  `Specialization_3` varchar(50) DEFAULT NULL,
  `Qualification_1` varchar(50) DEFAULT NULL,
  `Qualification_2` varchar(50) DEFAULT NULL,
  `Qualification_3` varchar(50) DEFAULT NULL,
  `PAN_Card` varchar(10) NOT NULL,
  `GSTIN_No` varchar(15) NOT NULL,
  `Experience` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `profession_master`
--

INSERT INTO `profession_master` (`PID`, `CID`, `Profession_Type_ID`, `Specialization_1`, `Specialization_2`, `Specialization_3`, `Qualification_1`, `Qualification_2`, `Qualification_3`, `PAN_Card`, `GSTIN_No`, `Experience`) VALUES
(6, 25, 2, 'Hepatology', 'Infectious disease', 'Oncology', 'Doctor of Medicine by research (MD(Res), DM)', 'Doctor of Philosophy (PhD, DPhil)', 'Master of Clinical Medicine (MCM)', 'ATVPP2460K', '24ATVPP2460KZL', '20+'),
(7, 27, 2, 'Hepatology', 'Infectious disease', 'Oncology', 'Master of Clinical Medicine (MCM)', 'Master of Medical Science (MMSc, MMedSc)', 'Master of Medicine (MM, MMed)', '', '', '10'),
(10, 30, 2, 'Hepatology', 'Infectious disease', 'Oncology', 'Bachelor of Medicine,Surgery(MBBS,BMBS,MBChB,MBBCh', 'Doctor of Medicine (MD, Dr.MuD, Dr.Med)', 'Doctor of Osteopathic Medicine (DO)', '', '', '12'),
(12, 33, 1, 'Patent', 'Information technology', 'Family', 'LLB', 'Master of Legal Studies (MLS)', 'Master of Dispute Resolution (MDR)', '', '', '8'),
(18, 39, 1, 'Patent', 'Information technology', 'Family', 'Master of Legal Studies (MLS)', 'Master of Dispute Resolution (MDR)', 'Juris Doctor (JD)', 'ATVPP2430I', '14ATVPC1240L1Z7', '5'),
(19, 40, 1, 'Patent', 'Information technology', 'Family', 'Master of Legal Studies (MLS)', 'Master of Dispute Resolution (MDR)', 'Juris Doctor (JD)', 'ATVPP2430M', '12ATVPP2430M1JL', '11'),
(21, 46, 1, 'Criminal', 'Information technology', 'Family', 'Master of Legal Studies (MLS)', 'Master of Dispute Resolution (MDR)', 'Juris Doctor (JD)', 'EVPO4670P', '14HJVPC3421L1Z7', '2');

-- --------------------------------------------------------

--
-- Table structure for table `profession_type`
--

CREATE TABLE `profession_type` (
  `Profession_Type_ID` int(10) NOT NULL,
  `Profession_Type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `schedule` (
  `STID` int(11) NOT NULL,
  `CID` int(10) NOT NULL,
  `ID` int(10) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `Start_Time` time NOT NULL,
  `End_Time` time NOT NULL,
  `Limit` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`STID`, `CID`, `ID`, `Start_Date`, `End_Date`, `Start_Time`, `End_Time`, `Limit`) VALUES
(1, 25, 6, '2019-11-02', '2020-12-30', '10:00:00', '19:00:00', 5),
(1, 30, 7, '2020-02-25', '2020-05-25', '10:00:00', '17:00:00', 7);

-- --------------------------------------------------------

--
-- Table structure for table `schedule_type_master`
--

CREATE TABLE `schedule_type_master` (
  `STID` int(10) NOT NULL,
  `Type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `user_master` (
  `UTMID` int(10) NOT NULL,
  `UID` int(10) NOT NULL,
  `Name` varchar(75) NOT NULL,
  `Email_ID` varchar(60) NOT NULL,
  `Phone_No` bigint(10) NOT NULL,
  `Gender` varchar(6) NOT NULL,
  `DOB` date NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Activation` varchar(10) NOT NULL,
  `Activation_Log` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_master`
--

INSERT INTO `user_master` (`UTMID`, `UID`, `Name`, `Email_ID`, `Phone_No`, `Gender`, `DOB`, `Password`, `Activation`, `Activation_Log`) VALUES
(1, 1, 'admin', 'admin@admin.com', 942600621, '', '0000-00-00', '21232f297a57a5a743894a0e4a801fc3', 'activated', '2019-09-18 08:24:32'),
(2, 29, 'ManagerMadhav', 'parkh.madhav1999@gmail.com', 9998256749, '', '0000-00-00', 'ae3d664409ccc81ab6005b7073157f83', 'activated', '2019-10-12 09:52:06'),
(3, 72, 'Divith Chajjed', 'divithchajjed@gmail.com', 9832675477, 'Male', '1991-02-07', '5c3bcb3064cceba94aa23fd88ee8bf5c', 'activated', '2019-10-28 04:04:19'),
(4, 73, 'Vallabhbhai Patel', 'vallabhbhaipatel@gmail.com', 9284567853, '', '0000-00-00', 'f1547379b09d8d6f40a6d88af1200f55', 'activated', '2019-10-31 13:10:58'),
(4, 74, 'Bhagat Singh', 'bhagatsingh@gmail.com', 8790987648, '', '0000-00-00', 'dd0f18900f8bcb8c1c42cebb8fb4b97e', 'activated', '2019-10-31 13:11:44'),
(4, 75, 'Chandra Shekhar Azad', 'chandrashekharazad@gmail.com', 7298628743, '', '0000-00-00', 'f9c0d529f31c318090b3dc3c374762c1', 'activated', '2019-10-31 13:13:33'),
(4, 76, 'Chittaranjan Das', 'chittaranjandas@gmail.com', 6720984361, '', '0000-00-00', '9b183e87158a4f7ebe172d77d4e92eae', 'activated', '2019-10-31 13:14:09'),
(4, 77, 'Ram Prasad Bismil', 'ramprasadbismil@gmail.com', 8976325681, '', '0000-00-00', '8d99b355e256b1d784a0b17dcf2c1054', 'activated', '2019-10-31 13:15:24'),
(4, 78, 'Udham Singh', 'udhamsingh@gmail.com', 8983267877, 'Male', '1990-12-12', 'aefd1eee43340366f16591d11795dce4', 'activated', '2019-10-31 13:16:13'),
(4, 79, 'Veer Damodar Savarkar', 'veerdamodarsavarkar@gmail.com', 8976324311, '', '0000-00-00', '7abb217bac22bc75c7794184850426f9', 'activated', '2019-10-31 13:17:47'),
(4, 80, 'Madan Lal Dhingra', 'madanlaldhingra@gmail.com', 8943112675, '', '0000-00-00', 'eb4585e09bfdeaade88eecae92318807', 'activated', '2019-10-31 13:19:16'),
(4, 81, 'Kartar Singh Sarabha', 'kartarsinghsarabha@gmail.com', 7643546798, '', '0000-00-00', '1e234551e9c3b0ab3599126f7362a1ff', 'activated', '2019-10-31 13:22:01'),
(4, 82, 'Subhas Chandra Bose', 'subaschandrabose@gmail.com', 9832456792, '', '0000-00-00', '4f8c4e14e6e3d123744b1d0549f85c57', 'activated', '2019-10-31 13:23:22'),
(4, 83, 'Bal Gangadhar Tilak', 'balgangadhartilak@gmail.com', 8743567782, '', '0000-00-00', 'bb0bff80921a8c2d30fe73d82c13ae9a', 'activated', '2019-10-31 13:26:02'),
(4, 84, 'Rani Laxmi Bai', 'ranilakshmibai@gmail.com', 8976456643, '', '0000-00-00', 'f947f70f6382e219077699570a3ae5e8', 'activated', '2019-10-31 13:27:19'),
(4, 85, 'Khudiram Bose', 'khudirambose@gmail.com', 8767561121, '', '0000-00-00', '86ce6f18af8444567105d1a9916950cb', 'activated', '2019-10-31 13:28:22'),
(4, 86, 'Batukeshwar Dutt', 'batukeshwardutt@gmail.com', 7898783210, '', '0000-00-00', '7ef658e8d885969c1315e218565f7cb1', 'activated', '2019-10-31 13:29:30'),
(4, 87, 'Sukhdev Thapar', 'sukhdevthapar@gmail.com', 9823010234, '', '0000-00-00', 'b3ef7b4c07991f8aaf04403e483d92a0', 'activated', '2019-10-31 13:30:17'),
(4, 88, 'Bhagwati Charan Vohra', 'bhagwaticharanvohra@gmail.com', 7893210033, '', '0000-00-00', 'fc5f181baf8626650d8c37acc0a34b8d', 'activated', '2019-10-31 13:31:37'),
(4, 89, 'Alluri Sitarama Raju', 'allurisitaramaraju@gmail.com', 9998877665, '', '0000-00-00', 'fc8349d70799322ef611ba595baeb730', 'activated', '2019-10-31 13:32:44'),
(4, 90, 'Rash Behari Bose', 'rashbeharibose@gmail.com', 8981216666, '', '0000-00-00', 'f4c21fb0691bee3f0bc706e381979e35', 'activated', '2019-10-31 13:33:41'),
(4, 91, 'Badal Gupta', 'badalgupta@gmail.com', 8921346755, '', '0000-00-00', '7a321de1da7769e2bce3f8676489feb6', 'activated', '2019-10-31 13:35:04'),
(4, 92, 'Dinesh Gupta', 'dineshgupta@gmail.com', 9911228876, '', '0000-00-00', '78a54e4dc2f0721ff4d6aa45d07664ba', 'activated', '2019-10-31 13:35:31'),
(4, 93, 'Ramesh Chandra Jha', 'rameshchnadrajha@gmail.com', 8723451211, '', '0000-00-00', 'c20e5c7639815873f27e64e20e3693ed', 'activated', '2019-10-31 13:36:11'),
(4, 94, 'Bhavabhushan Mitra', 'bhavabhushanmitra@gmail.com', 8912551234, '', '0000-00-00', '5c5fcbf5f525172e2c316aca43162f08', 'activated', '2019-10-31 13:36:52'),
(4, 95, 'Kalpana Datta', 'kalpanadatta@gmail.com', 8887771212, '', '0000-00-00', '3fe2321475feb8b383d7989d0ac3af72', 'activated', '2019-10-31 13:37:41'),
(4, 96, 'Bina Das', 'binadas@gmail.com', 9998912345, '', '0000-00-00', 'ad61fb41d5572eb4b7214b2bef82d0cb', 'activated', '2019-10-31 13:38:12'),
(4, 98, 'Satish Dhawan', 'satishdhawan@gmail.com', 9871235671, '', '0000-00-00', 'bf8bfc919ee687e7873d828223eb53fb', 'activated', '2019-10-31 13:40:09'),
(4, 99, 'Vikram Sarabhai', 'vikramsarabhai@gmail.com', 9876543434, '', '0000-00-00', 'a492fc5bd62da261daa86db70007b25c', 'activated', '2019-10-31 13:41:30'),
(4, 100, 'S.K Mitra', 'skmitra@gmail.com', 9812674562, '', '0000-00-00', '612dcac3dd87acf24e0d71c92a50d818', 'activated', '2019-10-31 13:42:06'),
(4, 101, 'Homi Bhabha', 'homibhabha@gmail.com', 9123456788, '', '0000-00-00', 'a40f1b210fc7dfa5d855ab4fa5a4e67f', 'activated', '2019-10-31 13:43:56'),
(2, 103, 'DELL', 'nitanimesh@qwerty.com', 8433434323, '', '0000-00-00', '15e5b123042f06d18c689080ce9a667d', 'activated', '2019-11-30 05:29:40'),
(2, 105, 'DELLIO', 'imeshqwert@qwerty.com', 6578998742, '', '0000-00-00', 'dce3fdec38db87dc7ffbf6807c583b20', 'activated', '2019-11-30 05:49:07'),
(4, 108, 'Raunak Shah', 'raunak.shah@gmail.com', 7645343312, '', '0000-00-00', '84ff6cdac52785fa23e5f51a1fc1022e', 'activated', '2020-01-06 08:13:18'),
(3, 112, 'Sanieka Pate', 'sanieka.pate@gmail.com', 7645343399, 'Female', '1990-12-12', '16d6558ce817ead0096d678375ddfa3d', 'activated', '2020-01-17 05:00:07'),
(3, 116, 'juhi chawla', 'juhi.chawla@gmail.com', 7645343393, 'Female', '1990-12-31', '4bffd0946157e2e1be5acffe6ffb9fbb', 'activated', '2020-01-19 09:09:15'),
(3, 123, 'Parth Shastri', 'parth.shastri@gmail.com', 9826562271, 'Male', '0000-00-00', '480726a300bf6732d9567447a0d32ebe', 'activated', '2020-02-16 14:10:18'),
(3, 132, 'Ankit Patel', 'ankit.patel@gmail.com', 3843122210, '', '0000-00-00', 'e835d236581ec4d07f9b6d0ce4ca3046', 'activated', '2020-02-28 08:10:02'),
(3, 133, 'Aniket Maheshwari', 'aniket.maheshwari@gmail.com', 3823122210, '', '0000-00-00', '9272a9c85565ae11227aec4688fa8a7b', 'activated', '2020-02-28 08:12:18'),
(3, 139, 'Laxmi Pillai', 'laxmipillai@gmail.com', 9889321123, '', '0000-00-00', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'pending', '2020-02-28 09:48:26'),
(3, 147, 'Rashmi Tiwari', 'ramakant4102@gmail.com', 9876456784, '', '0000-00-00', '3e34805fecfca76a9915c348fc3e4eb0', 'activated', '2020-02-28 10:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `user_type_master`
--

CREATE TABLE `user_type_master` (
  `UTMID` int(10) NOT NULL,
  `User_Type` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_type_master`
--

INSERT INTO `user_type_master` (`UTMID`, `User_Type`) VALUES
(1, 'admin'),
(2, 'manager'),
(3, 'consultant'),
(4, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `weeklyscheduledetails`
--

CREATE TABLE `weeklyscheduledetails` (
  `ID` int(11) NOT NULL,
  `WeeklyID` int(10) NOT NULL,
  `OnMonday` tinyint(1) DEFAULT NULL,
  `OnTuesday` tinyint(1) DEFAULT NULL,
  `OnWednesday` tinyint(1) DEFAULT NULL,
  `OnThursday` tinyint(1) DEFAULT NULL,
  `OnFriday` tinyint(1) DEFAULT NULL,
  `OnSaturday` tinyint(1) DEFAULT NULL,
  `OnSunday` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure for view `demo view`
--
DROP TABLE IF EXISTS `demo view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `demo view`  AS  select `user_master`.`Name` AS `name`,`user_master`.`Email_ID` AS `Email_ID`,`user_master`.`Phone_No` AS `Phone_No`,`profession_master`.`Experience` AS `Experience` from ((`user_master` join `consultant_master` on(`user_master`.`UID` = `consultant_master`.`UID`)) join `profession_master` on(`consultant_master`.`CID` = `profession_master`.`CID`)) where `consultant_master`.`State` like 'Gujarat' order by `profession_master`.`Experience` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment_master`
--
ALTER TABLE `appointment_master`
  ADD PRIMARY KEY (`AID`),
  ADD KEY `uid_frky` (`UID`),
  ADD KEY `cnsltnt` (`CID`);

--
-- Indexes for table `consultant_master`
--
ALTER TABLE `consultant_master`
  ADD PRIMARY KEY (`CID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `feedback_master`
--
ALTER TABLE `feedback_master`
  ADD PRIMARY KEY (`FID`),
  ADD KEY `feedback` (`UID`);

--
-- Indexes for table `monthlyscheduledetails`
--
ALTER TABLE `monthlyscheduledetails`
  ADD PRIMARY KEY (`MonthlyID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `profession_details`
--
ALTER TABLE `profession_details`
  ADD PRIMARY KEY (`PDID`),
  ADD UNIQUE KEY `Details` (`Details`),
  ADD KEY `ptid_cnstrnt` (`Profession_Type_ID`);

--
-- Indexes for table `profession_master`
--
ALTER TABLE `profession_master`
  ADD PRIMARY KEY (`PID`),
  ADD UNIQUE KEY `CID` (`CID`),
  ADD KEY `fkconprofession` (`Profession_Type_ID`);

--
-- Indexes for table `profession_type`
--
ALTER TABLE `profession_type`
  ADD PRIMARY KEY (`Profession_Type_ID`),
  ADD UNIQUE KEY `Profession_Type` (`Profession_Type`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `CID` (`CID`),
  ADD KEY `schedule_type_ID` (`STID`);

--
-- Indexes for table `schedule_type_master`
--
ALTER TABLE `schedule_type_master`
  ADD PRIMARY KEY (`STID`),
  ADD UNIQUE KEY `Type` (`Type`);

--
-- Indexes for table `user_master`
--
ALTER TABLE `user_master`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `Email_ID` (`Email_ID`),
  ADD UNIQUE KEY `Phone_No` (`Phone_No`),
  ADD KEY `UTMID` (`UTMID`);

--
-- Indexes for table `user_type_master`
--
ALTER TABLE `user_type_master`
  ADD PRIMARY KEY (`UTMID`);

--
-- Indexes for table `weeklyscheduledetails`
--
ALTER TABLE `weeklyscheduledetails`
  ADD PRIMARY KEY (`WeeklyID`),
  ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment_master`
--
ALTER TABLE `appointment_master`
  MODIFY `AID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `consultant_master`
--
ALTER TABLE `consultant_master`
  MODIFY `CID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `feedback_master`
--
ALTER TABLE `feedback_master`
  MODIFY `FID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `monthlyscheduledetails`
--
ALTER TABLE `monthlyscheduledetails`
  MODIFY `MonthlyID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profession_details`
--
ALTER TABLE `profession_details`
  MODIFY `PDID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `profession_master`
--
ALTER TABLE `profession_master`
  MODIFY `PID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `profession_type`
--
ALTER TABLE `profession_type`
  MODIFY `Profession_Type_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `schedule_type_master`
--
ALTER TABLE `schedule_type_master`
  MODIFY `STID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_master`
--
ALTER TABLE `user_master`
  MODIFY `UID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `user_type_master`
--
ALTER TABLE `user_type_master`
  MODIFY `UTMID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `weeklyscheduledetails`
--
ALTER TABLE `weeklyscheduledetails`
  MODIFY `WeeklyID` int(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment_master`
--
ALTER TABLE `appointment_master`
  ADD CONSTRAINT `aid_uid` FOREIGN KEY (`CID`) REFERENCES `consultant_master` (`CID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `uid` FOREIGN KEY (`UID`) REFERENCES `user_master` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `consultant_master`
--
ALTER TABLE `consultant_master`
  ADD CONSTRAINT `uid_constraintss` FOREIGN KEY (`UID`) REFERENCES `user_master` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feedback_master`
--
ALTER TABLE `feedback_master`
  ADD CONSTRAINT `feedback` FOREIGN KEY (`UID`) REFERENCES `user_master` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `monthlyscheduledetails`
--
ALTER TABLE `monthlyscheduledetails`
  ADD CONSTRAINT `mnthly` FOREIGN KEY (`ID`) REFERENCES `schedule` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `profession_details`
--
ALTER TABLE `profession_details`
  ADD CONSTRAINT `ptid_cnstrnt` FOREIGN KEY (`Profession_Type_ID`) REFERENCES `profession_type` (`Profession_Type_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `schdl` FOREIGN KEY (`STID`) REFERENCES `schedule_type_master` (`STID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `schdl_consul` FOREIGN KEY (`CID`) REFERENCES `consultant_master` (`CID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_master`
--
ALTER TABLE `user_master`
  ADD CONSTRAINT `usr_mstr` FOREIGN KEY (`UTMID`) REFERENCES `user_type_master` (`UTMID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `weeklyscheduledetails`
--
ALTER TABLE `weeklyscheduledetails`
  ADD CONSTRAINT `weekly` FOREIGN KEY (`ID`) REFERENCES `schedule` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
