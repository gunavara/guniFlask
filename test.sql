-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 30, 2016 at 06:52 PM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `message_box`
--

CREATE TABLE `message_box` (
  `id` int(11) NOT NULL,
  `message_subject` varchar(100) NOT NULL,
  `message_content` varchar(300) NOT NULL,
  `posted_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `current_mood` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `message_box`
--

INSERT INTO `message_box` (`id`, `message_subject`, `message_content`, `posted_on`, `current_mood`) VALUES
(15, 'This is a test post', 'I am proud to inform you that everything so far is working!', '2016-08-26 14:20:23', 'Happy'),
(29, 'This is a good post', 'This post was made with Flask, WTForms, CSS, MySQLDB!', '2016-08-26 21:14:25', 'Happy');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `news_heading` varchar(120) NOT NULL,
  `news_content` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `news_heading`, `news_content`, `created_at`, `updated_at`, `remember_token`) VALUES
(63, 'This is a post Subject', 'The post should be working. This app is using Laravel 5.2, Apache/MySQL.\r\nIt should be good. A lot to do!', '2016-08-19 17:23:32', '2016-08-19 17:23:32', ''),
(64, 'asd', 'weqw', '2016-08-19 18:36:03', '2016-08-19 18:36:03', '');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `hero_class` varchar(20) DEFAULT NULL,
  `health_points` varchar(20) DEFAULT NULL,
  `hero_min_dmg` varchar(20) DEFAULT NULL,
  `hero_max_dmg` varchar(20) DEFAULT NULL,
  `hero_min_block` varchar(20) DEFAULT NULL,
  `hero_max_block` varchar(20) DEFAULT NULL,
  `player_xp` varchar(3) DEFAULT NULL,
  `queststage` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `username`, `hero_class`, `health_points`, `hero_min_dmg`, `hero_max_dmg`, `hero_min_block`, `hero_max_block`, `player_xp`, `queststage`) VALUES
(21, 'phyx', 'Warrior', '94', '3', '7', '2', '4', '10', '2');

-- --------------------------------------------------------

--
-- Table structure for table `potrebitelski_razhodi`
--

CREATE TABLE `potrebitelski_razhodi` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `razhod_id` int(11) NOT NULL,
  `suma_razhod` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `razhodi`
--

CREATE TABLE `razhodi` (
  `id` int(11) NOT NULL,
  `razhod` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `razhodi`
--

INSERT INTO `razhodi` (`id`, `razhod`) VALUES
(29, 'Ток'),
(30, 'Вода'),
(31, 'Парно');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`) VALUES
(13, 'guni', '$5$rounds=535000$KNcFPxHFjBB6rOYb$/86Eb4mizFoGmlLlEdYesxUOUIKpUdoTcZa71k5UQh4', 'gunavara@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `message_box`
--
ALTER TABLE `message_box`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `potrebitelski_razhodi`
--
ALTER TABLE `potrebitelski_razhodi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `razhodi`
--
ALTER TABLE `razhodi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `message_box`
--
ALTER TABLE `message_box`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `potrebitelski_razhodi`
--
ALTER TABLE `potrebitelski_razhodi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `razhodi`
--
ALTER TABLE `razhodi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
