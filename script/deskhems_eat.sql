-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 08, 2020 at 05:54 PM
-- Server version: 10.3.25-MariaDB-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `deskhems_eat`
--

-- --------------------------------------------------------

--
-- Table structure for table `addons`
--

CREATE TABLE `addons` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `addon_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'superadmin', 'web', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(2, 'Products', 'web', '2020-12-06 14:40:17', '2020-12-06 14:40:17');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `p_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `avatar`, `type`, `content`, `p_id`, `status`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Uncategorizied', 'uncategorizied', NULL, '0', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(2, 'Indian', 'indian', 'https://eatonline.se/uploads/dummy/cuisine/indian.jpg', '2', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(3, 'Chinese food', 'chinese-food', 'https://eatonline.se/uploads/dummy/cuisine/chinese.jpg', '2', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(4, 'Japanese', 'japanese-food', 'https://eatonline.se/uploads/dummy/cuisine/japanese.jpg', '2', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(5, 'Italian', 'italian', 'https://eatonline.se/uploads/dummy/cuisine/italian.jpg', '2', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(6, 'mexican', 'mexican', 'https://eatonline.se/uploads/dummy/cuisine/mexican.jpg', '2', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(7, 'Appetizer', 'appetizer', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(8, 'Salad', 'salad', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(9, 'Soup', 'soup', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(10, 'Rice Dish', 'rice', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(11, 'Chicken Dish', 'rice', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(12, 'Fish Dish', 'rice', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(13, 'Mutton Dish', 'rice', NULL, '1', NULL, NULL, 0, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(14, 'Meny', NULL, NULL, '1', NULL, NULL, 0, 3, '2020-12-03 09:15:16', '2020-12-03 09:15:16');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment_meta`
--

CREATE TABLE `comment_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `star_rate` int(11) NOT NULL DEFAULT 0,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customizers`
--

CREATE TABLE `customizers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customizers`
--

INSERT INTO `customizers` (`id`, `key`, `theme_name`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'hero', 'khana', '{\"settings\":{\"hero_right_image\":{\"old_value\":null,\"new_value\":\"uploads\\/2020-08-03-5f27e155e25e4.jpg\"},\"hero_right_title\":{\"old_value\":\"Hello Usa The Best 20% off\",\"new_value\":\"Get 20% Off From Special Day\"},\"hero_title\":{\"old_value\":null,\"new_value\":\"Find Awesome Deals in Bangladesh\"},\"hero_des\":{\"old_value\":null,\"new_value\":\"Lists of top restaurants, cafes, pubs and bars in Melbourne, based on trends\"},\"button_title\":{\"old_value\":null,\"new_value\":\"Search\"},\"offer_title\":{\"old_value\":null,\"new_value\":\"Available Offer Right Now\"},\"hero_right_content\":{\"old_value\":null,\"new_value\":\"VALID ON SELECT ITEM\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(2, 'header', 'khana', '{\"settings\":{\"logo\":{\"old_value\":\"uploads\\/2020-08-03-5f27e25e2a680.png\",\"new_value\":\"uploads\\/2020-12-03-5fc8e933af378.png\"},\"header_pn\":{\"old_value\":\"+825-285-9687\",\"new_value\":\"+846 00 00 00\"},\"rider_team_title\":{\"old_value\":\"Join Our Khana Rider Team!\",\"new_value\":\"Join Our Rider Team!\"},\"rider_button_title\":{\"old_value\":null,\"new_value\":\"Apply Now\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 12:34:37'),
(3, 'category', 'khana', '{\"settings\":{\"category_title\":{\"old_value\":null,\"new_value\":\"Browse By Category\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(4, 'best_restaurant', 'khana', '{\"settings\":{\"best_restaurant_title\":{\"old_value\":null,\"new_value\":\"Best Rated Restaurant\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(5, 'city_area', 'khana', '{\"settings\":{\"find_city_title\":{\"old_value\":null,\"new_value\":\"Find us in these cities and many more!\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(6, 'featured_resturent', 'khana', '{\"settings\":{\"featured_resturent_title\":{\"old_value\":null,\"new_value\":\"Featured Restaturents\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(7, 'footer', 'khana', '{\"settings\":{\"copyright_area\":{\"old_value\":\"\\u00a9 Copyright 2020 Amcoders. All rights reserved\",\"new_value\":\"\\u00a9 Copyright 2020 eatonline. All rights reserved\"}}}', '1', '2020-12-03 09:02:00', '2020-12-03 12:34:57');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `featured_user`
--

CREATE TABLE `featured_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `featured_user`
--

INSERT INTO `featured_user` (`id`, `user_id`, `type`, `created_at`, `updated_at`) VALUES
(9, 3, 'featured_seller', '2020-12-03 09:02:00', '2020-12-03 09:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `live`
--

CREATE TABLE `live` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `latitute` double DEFAULT NULL,
  `longlatitute` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL DEFAULT 3,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `user_id`, `term_id`, `latitude`, `longitude`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 3, 22, 22.3244537, 91.8117232, 3, '2020-12-03 09:01:59', '2020-12-07 11:23:13'),
(10, 12, 2, 22.3244537, 91.8117232, 4, '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(11, 16, 23, 56.0440151, 12.696482, 3, '2020-12-07 14:59:25', '2020-12-07 17:16:44'),
(12, 17, 25, 55.9346852, 13.5412479, 3, '2020-12-07 17:32:31', '2020-12-07 17:32:31'),
(13, 18, 24, 55.6061991, 13.0214584, 3, '2020-12-07 19:10:47', '2020-12-07 19:10:47'),
(14, 18, 24, 55.6061991, 13.0214584, 3, '2020-12-07 19:11:15', '2020-12-07 19:11:15'),
(15, 18, 24, 55.60738582676928, 13.024237630688477, 3, '2020-12-07 19:11:53', '2020-12-07 19:11:53'),
(16, 18, 24, 55.606344551263, 13.021372569311533, 3, '2020-12-07 19:12:31', '2020-12-07 19:12:31'),
(17, 19, 22, 55.6935754, 13.1789727, 3, '2020-12-07 19:23:23', '2020-12-07 19:23:23'),
(18, 20, 22, 55.70469689999999, 13.1880741, 3, '2020-12-07 19:28:54', '2020-12-07 19:34:04'),
(19, 20, 22, 55.70469689999999, 13.1880741, 3, '2020-12-07 19:29:26', '2020-12-07 19:29:26'),
(20, 21, 23, 56.0508174, 12.6890143, 3, '2020-12-07 19:35:59', '2020-12-07 19:35:59'),
(21, 21, 23, 56.0508174, 12.6890143, 3, '2020-12-07 19:36:17', '2020-12-07 19:36:17'),
(22, 22, 22, 55.70209829999999, 13.1962133, 3, '2020-12-07 19:43:44', '2020-12-07 19:47:41'),
(23, 24, 22, 0, 0, 3, '2020-12-08 04:15:59', '2020-12-08 04:15:59');

-- --------------------------------------------------------

--
-- Table structure for table `medias`
--

CREATE TABLE `medias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medias`
--

INSERT INTO `medias` (`id`, `name`, `type`, `url`, `size`, `path`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'uploads/20/12/03122016069958505fc8cf8a27a7a.jpg', 'jpg', '//eatonline.se/uploads/20/12/03122016069958505fc8cf8a27a7a.jpg', '132069kib', 'uploads/20/12/', 3, '2020-12-03 10:44:10', '2020-12-03 10:44:10'),
(2, 'uploads/2020-12-03-5fc8e933af378.png', 'png', '//eatonline.se/uploads/2020-12-03-5fc8e933af378.png', '10270kib', 'uploads/', 1, '2020-12-03 12:33:39', '2020-12-03 12:33:39'),
(3, 'uploads/20/12/5fcdf74f8a32d0712201607333711.png', 'png', '//eatonline.se/uploads/20/12/5fcdf74f8a32d0712201607333711.png', '1256571kib', 'uploads/20/12/', 1, '2020-12-07 08:35:12', '2020-12-07 08:35:12'),
(4, 'uploads/20/12/5fce7674121e20712201607366260.png', 'png', '//eatonline.se/uploads/20/12/5fce7674121e20712201607366260.png', '1254666kib', 'uploads/20/12/', 17, '2020-12-07 17:37:42', '2020-12-07 17:37:42'),
(5, 'uploads/20/12/5fce76fbd1e390712201607366395.png', 'png', '//eatonline.se/uploads/20/12/5fce76fbd1e390712201607366395.png', '1845926kib', 'uploads/20/12/', 16, '2020-12-07 17:39:57', '2020-12-07 17:39:57'),
(6, 'uploads/20/12/5fce8dfb1dc4b0712201607372283.png', 'png', '//eatonline.se/uploads/20/12/5fce8dfb1dc4b0712201607372283.png', '1779083kib', 'uploads/20/12/', 18, '2020-12-07 19:18:05', '2020-12-07 19:18:05'),
(7, 'uploads/20/12/5fce8ffc710ea0712201607372796.png', 'png', '//eatonline.se/uploads/20/12/5fce8ffc710ea0712201607372796.png', '1735235kib', 'uploads/20/12/', 19, '2020-12-07 19:26:40', '2020-12-07 19:26:40'),
(8, 'uploads/20/12/5fce9166a51320712201607373158.png', 'png', '//eatonline.se/uploads/20/12/5fce9166a51320712201607373158.png', '646195kib', 'uploads/20/12/', 20, '2020-12-07 19:32:39', '2020-12-07 19:32:39'),
(9, 'uploads/20/12/5fce9300e1ea80712201607373568.png', 'png', '//eatonline.se/uploads/20/12/5fce9300e1ea80712201607373568.png', '646195kib', 'uploads/20/12/', 21, '2020-12-07 19:39:30', '2020-12-07 19:39:30'),
(10, 'uploads/20/12/5fce932a092ca0712201607373610.png', 'png', '//eatonline.se/uploads/20/12/5fce932a092ca0712201607373610.png', '1131425kib', 'uploads/20/12/', 21, '2020-12-07 19:40:11', '2020-12-07 19:40:11'),
(11, 'uploads/20/12/5fce9492b61f20712201607373970.png', 'png', '//eatonline.se/uploads/20/12/5fce9492b61f20712201607373970.png', '2320460kib', 'uploads/20/12/', 22, '2020-12-07 19:46:12', '2020-12-07 19:46:12');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `position`, `data`, `lang`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Header', 'Header', '[{\"text\":\"Home\",\"href\":\"/\",\"icon\":\"\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"City\",\"href\":\"#\",\"icon\":\"fas fa-angle-down\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"Dhaka\",\"href\":\"/area/dhaka\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Chittagong\",\"href\":\"/area/chittagong\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Feni\",\"href\":\"/area/feni\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Bogra\",\"href\":\"/area/bogra\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Barisal\",\"href\":\"/area/barisal\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Rajshahi\",\"href\":\"/area/rajshahi\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Khulna\",\"href\":\"/area/khulna\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Rangpur\",\"href\":\"/area/rangpur\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"}]},{\"text\":\"Customer Area\",\"href\":\"#\",\"icon\":\"fas fa-angle-down\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"Login\",\"href\":\"/user/login\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Register\",\"href\":\"/user/register\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Customer Panel\",\"href\":\"/author/dashboard\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"}]},{\"text\":\"Rider Area\",\"href\":\"#\",\"icon\":\"fas fa-angle-down\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"Login\",\"href\":\"/rider/login\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Register\",\"href\":\"/rider/register\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Rider Panel\",\"href\":\"/rider/dashboard\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"}]},{\"text\":\"Restaurant Area\",\"href\":\"#\",\"icon\":\"fas fa-angle-down\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"Login\",\"href\":\"/login\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Register\",\"href\":\"/restaurant/register\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"Restaurant Panel\",\"href\":\"/store/dashboard\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"}]}]', 'en', 1, '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(2, 'Header', 'Header', '[{\"text\":\"হোম\",\"href\":\"/\",\"icon\":\"\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"আপানার শহর\",\"href\":\"#\",\"icon\":\"fas fa-angle-down\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"ঢাকা\",\"href\":\"/area/dhaka\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"চট্রগ্রাম\",\"href\":\"/area/chittagong\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\" ফেণী\",\"href\":\"/area/feni\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"বগুড়া\",\"href\":\"/area/bogra\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"বরিশাল\",\"href\":\"/area/barisal\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"রাজশাহী\",\"href\":\"/area/rajshahi\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"খুলনা\",\"href\":\"/area/khulna\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"রংপুর\",\"href\":\"/area/rangpur\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\"}]},{\"text\":\"ক্রেতা\",\"icon\":\"fas fa-angle-down\",\"href\":\"#\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"লগইন\",\"icon\":\"empty\",\"href\":\"/user/login\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"রেজিস্টার\",\"icon\":\"empty\",\"href\":\"/user/register\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"ড্যাশবোর্ড\",\"icon\":\"empty\",\"href\":\"/author/dashboard\",\"target\":\"_self\",\"title\":\"\"}]},{\"text\":\"রাইডার\",\"icon\":\"fas fa-angle-down\",\"href\":\"#\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"লগইন\",\"icon\":\"empty\",\"href\":\"/rider/login\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"রেজিস্টার\",\"icon\":\"empty\",\"href\":\"/rider/register\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"ড্যাশবোর্ড\",\"icon\":\"empty\",\"href\":\"/rider/dashboard\",\"target\":\"_self\",\"title\":\"\"}]},{\"text\":\"রেস্তোরাঁ\",\"icon\":\"fas fa-angle-down\",\"href\":\"#\",\"target\":\"_self\",\"title\":\"\",\"children\":[{\"text\":\"লগইন\",\"icon\":\"empty\",\"href\":\"/login\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"রেজিস্টার\",\"icon\":\"empty\",\"href\":\"/restaurant/register\",\"target\":\"_self\",\"title\":\"\"},{\"text\":\"ড্যাশবোর্ড\",\"icon\":\"empty\",\"href\":\"/store/dashboard\",\"target\":\"_self\",\"title\":\"\"}]}]', 'bn', 1, '2020-12-03 09:02:00', '2020-12-03 09:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `meta`
--

CREATE TABLE `meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'excerpt',
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meta`
--

INSERT INTO `meta` (`id`, `term_id`, `type`, `content`, `created_at`, `updated_at`) VALUES
(3, 2, 'excerpt', '{\"latitude\":\"22.3569\",\"longitude\":\"91.7832\",\"zoom\":\"12\"}', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(4, 2, 'preview', 'https://eatonline.se/uploads/dummy/city/chittagong.jpg', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(17, 9, 'preview', 'https://eatonline.se/uploads/dummy/label/label.png', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(18, 10, 'excerpt', '', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(19, 10, 'content', '', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(20, 11, 'excerpt', '', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(21, 11, 'content', '', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(22, 12, 'excerpt', '', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(23, 12, 'content', '', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(26, 19, 'excerpt', 'Test', '2020-12-03 09:15:38', '2020-12-03 09:15:38'),
(27, 19, 'preview', '//eatonline.se/uploads/20/12/03122016069958505fc8cf8a27a7a.jpg', '2020-12-03 09:15:38', '2020-12-03 10:44:16'),
(28, 22, 'excerpt', '{\"latitude\":\"55.704659\",\"longitude\":\"13.191007\",\"zoom\":\"12\"}', '2020-12-07 08:19:08', '2020-12-07 08:19:08'),
(29, 22, 'preview', '//eatonline.se/uploads/20/12/5fcdf74f8a32d0712201607333711.png', '2020-12-07 08:19:08', '2020-12-07 08:35:21'),
(30, 23, 'excerpt', '{\"latitude\":\"56.046467\",\"longitude\":\"12.694512\",\"zoom\":\"12\"}', '2020-12-07 17:12:59', '2020-12-07 17:12:59'),
(31, 23, 'preview', '//eatonline.se/uploads/20/12/5fcdf74f8a32d0712201607333711.png', '2020-12-07 17:12:59', '2020-12-07 17:12:59'),
(32, 24, 'excerpt', '{\"latitude\":\"55.604980\",\"longitude\":\"13.003822\",\"zoom\":\"12\"}', '2020-12-07 17:14:06', '2020-12-07 17:14:06'),
(33, 24, 'preview', '//eatonline.se/uploads/20/12/5fcdf74f8a32d0712201607333711.png', '2020-12-07 17:14:06', '2020-12-07 17:14:06'),
(34, 25, 'excerpt', '{\"latitude\":\"55.934711\",\"longitude\":\"13.539400\",\"zoom\":\"12\"}', '2020-12-07 17:14:47', '2020-12-07 17:14:47'),
(35, 25, 'preview', '//eatonline.se/uploads/20/12/5fcdf74f8a32d0712201607333711.png', '2020-12-07 17:14:47', '2020-12-07 17:14:47');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_09_12_000000_create_plan_meta_table', 1),
(2, '2014_09_12_000000_create_roles_table', 1),
(3, '2014_10_12_000000_create_users_table', 1),
(4, '2014_10_12_100000_create_password_resets_table', 1),
(5, '2019_08_19_000000_create_failed_jobs_table', 1),
(6, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(7, '2020_02_24_073339_create_medias_table', 1),
(8, '2020_02_24_073655_create_categories_table', 1),
(9, '2020_02_24_094503_create_menu_table', 1),
(10, '2020_04_13_142641_create_options_table', 1),
(11, '2020_04_13_144019_create_terms_table', 1),
(12, '2020_04_13_144038_create_meta_table', 1),
(13, '2020_04_13_144625_create_post_category_table', 1),
(14, '2020_04_16_110534_create_customizers_table', 1),
(15, '2020_06_13_060141_create_user_meta_table', 1),
(16, '2020_06_13_060214_create_shop_day_table', 1),
(17, '2020_06_13_060320_create_locations_table', 1),
(18, '2020_06_13_060350_create_orders_table', 1),
(19, '2020_06_13_060426_create_order_meta_table', 1),
(20, '2020_06_13_060450_create_live_table', 1),
(21, '2020_06_13_060610_create_product_meta_table', 1),
(22, '2020_06_26_095324_create_addons_table', 1),
(23, '2020_06_27_130415_create_featured_user_table', 1),
(24, '2020_06_30_064207_create_user_category_table', 1),
(25, '2020_07_08_113713_create_signal_users_table', 1),
(26, '2020_07_10_152719_create_orderlogs_table', 1),
(27, '2020_07_11_071023_create_riderlogs_table', 1),
(28, '2020_07_13_144449_create_comments_table', 1),
(29, '2020_07_14_105925_create_userplans_table', 1),
(30, '2020_07_15_115854_create_transactions_table', 1),
(31, '2020_08_13_074339_create_comment_meta_table', 1),
(32, '2020_11_19_142600_create_permission_tables', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 1),
(1, 'App\\User', 14),
(2, 'App\\User', 15);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `key`, `value`, `lang`, `created_at`, `updated_at`) VALUES
(1, 'system_basic_info', '{\"number\":\"018000\",\"logo\":null}', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(2, 'seo', '{\"title\":\"eatonline\",\"description\":null,\"canonical\":null,\"tags\":null,\"twitterTitle\":null}', 'en', '2020-12-03 09:01:59', '2020-12-03 09:04:11'),
(3, 'langlist', '{\"English\":\"en\",\"Bengali\":\"bn\"}', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(4, 'lp_imagesize', '[{\"key\":\"small\",\"height\":\"80\",\"width\":\"80\"},{\"key\":\"medium\",\"height\":\"186\",\"width\":\"255\"}]', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(5, 'lp_filesystem', '{\"compress\":5,\"system_type\":\"local\",\"system_url\":null}', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(6, 'lp_perfomances', '{\"lazyload\":0,\"image\":\"uploads\\/lazy.png\"}', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(7, 'rider_commission', '10', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(8, 'currency_name', 'SEK', 'en', '2020-12-03 09:01:59', '2020-12-03 10:56:46'),
(9, 'currency_icon', 'kr', 'en', '2020-12-03 09:01:59', '2020-12-03 10:56:46'),
(10, 'km_rate', '100', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(11, 'default_map', '{\"default_lat\":\"23.685\",\"default_long\":\"90.3563\",\"default_zoom\":\"10\"}', 'en', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(12, 'color', '#263e0f', 'en', '2020-12-03 10:56:46', '2020-12-07 16:52:12'),
(13, 'tax', '12', 'en', '2020-12-03 13:08:46', '2020-12-03 13:08:46');

-- --------------------------------------------------------

--
-- Table structure for table `orderlogs`
--

CREATE TABLE `orderlogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `seen` int(11) NOT NULL DEFAULT 0,
  `order_type` int(11) NOT NULL DEFAULT 0,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` int(11) NOT NULL DEFAULT 0,
  `coupon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `shipping` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `commission` double NOT NULL DEFAULT 0,
  `discount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT 2,
  `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `vendor_id`, `rider_id`, `seen`, `order_type`, `payment_method`, `payment_status`, `coupon_id`, `total`, `shipping`, `commission`, `discount`, `status`, `data`, `created_at`, `updated_at`) VALUES
(2, 2, 3, NULL, 0, 1, 'cod', 0, NULL, '250.00', '0', 0, '0.00', 2, '{\"name\":\"Author\",\"phone\":\"1234567890\",\"address\":\"Agrabad Commercial Area, Chattogram, Bangladesh\",\"latitude\":\"22.3244537\",\"longitude\":\"91.8117232\",\"note\":null,\"payment_id\":null}', '2020-12-06 12:25:01', '2020-12-06 12:25:01');

-- --------------------------------------------------------

--
-- Table structure for table `order_meta`
--

CREATE TABLE `order_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 1,
  `total` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_meta`
--

INSERT INTO `order_meta` (`id`, `order_id`, `term_id`, `qty`, `total`, `created_at`, `updated_at`) VALUES
(2, 2, 19, 2, 125, '2020-12-06 12:25:01', '2020-12-06 12:25:01');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `group_name`, `created_at`, `updated_at`) VALUES
(1, 'dashboard', 'web', 'dashboard', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(2, 'update', 'web', 'update', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(3, 'admin.create', 'web', 'admin', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(4, 'admin.edit', 'web', 'admin', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(5, 'admin.update', 'web', 'admin', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(6, 'admin.delete', 'web', 'admin', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(7, 'admin.list', 'web', 'admin', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(8, 'role.create', 'web', 'role', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(9, 'role.edit', 'web', 'role', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(10, 'role.update', 'web', 'role', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(11, 'role.delete', 'web', 'role', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(12, 'role.list', 'web', 'role', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(13, 'media.list', 'web', 'Media', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(14, 'media.upload', 'web', 'Media', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(15, 'media.delete', 'web', 'Media', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(16, 'page.list', 'web', 'Page', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(17, 'page.create', 'web', 'Page', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(18, 'page.edit', 'web', 'Page', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(19, 'page.delete', 'web', 'Page', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(20, 'product.list', 'web', 'Products', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(21, 'product.delete', 'web', 'Products', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(22, 'product.category', 'web', 'Products', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(23, 'resturents.requests', 'web', 'Restaurant', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(24, 'resturents.view', 'web', 'Restaurant', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(25, 'all.resturents', 'web', 'Restaurant', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(26, 'manage.review', 'web', 'Restaurant', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(27, 'rider.request', 'web', 'Rider', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(28, 'all.rider', 'web', 'Rider', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(29, 'customer.list', 'web', 'Customer', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(30, 'customer.edit', 'web', 'Customer', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(31, 'payout.request', 'web', 'Payout', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(32, 'payout.history', 'web', 'Payout', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(33, 'payout.account', 'web', 'Payout', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(34, 'payout.view', 'web', 'Payout', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(35, 'order.list', 'web', 'Orders', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(36, 'order.control', 'web', 'Orders', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(37, 'plan.create', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(38, 'plan.list', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(39, 'plan.view', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(40, 'plan.edit', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(41, 'plan.delete', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(42, 'payment.request', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(43, 'payment.make', 'web', 'Plan', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(44, 'location.create', 'web', 'Location', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(45, 'location.list', 'web', 'Location', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(46, 'location.edit', 'web', 'Location', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(47, 'location.delete', 'web', 'Location', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(48, 'badge.control', 'web', 'Badge', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(49, 'featured.control', 'web', 'Featured', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(50, 'earning.order.report', 'web', 'Reports', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(51, 'earning.delivery.report', 'web', 'Reports', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(52, 'earning.subscription.report', 'web', 'Reports', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(53, 'theme', 'web', 'Appearance', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(54, 'menu', 'web', 'Appearance', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(55, 'plugin.control', 'web', 'Plugin', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(56, 'site.settings', 'web', 'Settings', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(57, 'seo', 'web', 'Settings', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(58, 'file.system', 'web', 'Settings', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(59, 'system.settings', 'web', 'Settings', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(60, 'payment.settings', 'web', 'Settings', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(61, 'language.control', 'web', 'language', '2020-12-03 09:01:59', '2020-12-03 09:01:59');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plan_meta`
--

CREATE TABLE `plan_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_price` int(11) NOT NULL,
  `duration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `f_resturent` int(11) NOT NULL DEFAULT 0,
  `table_book` int(11) NOT NULL DEFAULT 0,
  `img_limit` int(11) NOT NULL DEFAULT 0,
  `commission` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan_meta`
--

INSERT INTO `plan_meta` (`id`, `name`, `s_price`, `duration`, `f_resturent`, `table_book`, `img_limit`, `commission`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Free Membership', 0, 'month', 0, 0, 100, 38, 1, '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(2, 'Silver Membership', 0, 'month', 0, 1, 250, 25, 1, '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(3, 'Gold Membership', 0, 'month', 1, 0, 350, 20, 1, '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(4, 'Platinum Membership', 0, 'month', 1, 1, 500, 13, 1, '2020-12-03 09:01:58', '2020-12-03 09:01:58');

-- --------------------------------------------------------

--
-- Table structure for table `post_category`
--

CREATE TABLE `post_category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_category`
--

INSERT INTO `post_category` (`id`, `term_id`, `category_id`, `created_at`, `updated_at`) VALUES
(2, 19, 14, '2020-12-03 10:44:16', '2020-12-03 10:44:16');

-- --------------------------------------------------------

--
-- Table structure for table `product_meta`
--

CREATE TABLE `product_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `price` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_meta`
--

INSERT INTO `product_meta` (`id`, `term_id`, `price`, `created_at`, `updated_at`) VALUES
(2, 19, 125, '2020-12-03 09:15:38', '2020-12-03 09:15:38'),
(3, 20, 25, '2020-12-03 10:44:48', '2020-12-03 10:44:48');

-- --------------------------------------------------------

--
-- Table structure for table `riderlogs`
--

CREATE TABLE `riderlogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `commision` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `seen` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(2, 'Author', 'author', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(3, 'Store', 'store', '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(4, 'Rider', 'rider', '2020-12-03 09:01:58', '2020-12-03 09:01:58');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(20, 2),
(21, 1),
(21, 2),
(22, 1),
(22, 2),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shop_day`
--

CREATE TABLE `shop_day` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `day` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `close` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shop_day`
--

INSERT INTO `shop_day` (`id`, `user_id`, `status`, `day`, `opening`, `close`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 'saturday', '12:45', '23:45', '2020-12-03 10:46:54', '2020-12-03 10:46:54'),
(2, 3, 1, 'sunday', '12:46', '23:46', '2020-12-03 10:46:54', '2020-12-03 10:46:54'),
(3, 3, 1, 'monday', '12:46', '23:46', '2020-12-03 10:46:54', '2020-12-03 10:46:54'),
(4, 3, 1, 'tuesday', '12:46', '23:46', '2020-12-03 10:46:54', '2020-12-03 10:46:54'),
(5, 3, 1, 'wednesday', '12:46', '23:46', '2020-12-03 10:46:54', '2020-12-03 10:46:54'),
(6, 3, 1, 'thursday', '12:46', '23:46', '2020-12-03 10:46:54', '2020-12-03 10:46:54'),
(7, 3, 1, 'friday', '12:46', '23:46', '2020-12-03 10:46:54', '2020-12-03 10:46:54');

-- --------------------------------------------------------

--
-- Table structure for table `signal_users`
--

CREATE TABLE `signal_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `player_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `terms`
--

CREATE TABLE `terms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `auth_id` bigint(20) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `terms`
--

INSERT INTO `terms` (`id`, `title`, `slug`, `lang`, `auth_id`, `status`, `type`, `count`, `created_at`, `updated_at`) VALUES
(2, 'Chittagong', 'chattogram', 'en', 1, 1, 2, 0, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(9, 'Seller Lavel 1', '2300', 'en', 1, 1, 3, 1, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(10, 'terms and conditions', 'terms-and-conditions', 'en', 1, 1, 1, 0, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(11, 'Privacy Policy', 'privacy-policy', 'en', 1, 1, 1, 0, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(12, 'Refund & Return Policy', 'refund-return-policy', 'en', 1, 1, 1, 0, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(14, 'hello21', '2020-12-12', 'en', 3, 1, 10, 10, '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(19, 'Test produkt', 'test-produkt', 'en', 3, 1, 6, 0, '2020-12-03 09:15:38', '2020-12-03 09:15:38'),
(20, 'Extra ost', 'extra-ost', 'en', 3, 1, 8, 0, '2020-12-03 10:44:48', '2020-12-03 10:44:48'),
(22, 'Lund', 'lund', '13.191007', 1, 1, 2, 0, '2020-12-07 08:19:08', '2020-12-07 08:35:21'),
(23, 'Helsingborg', 'helsingborg', 'en', 1, 1, 2, 0, '2020-12-07 17:12:59', '2020-12-07 17:12:59'),
(24, 'Malmö', 'malmo', 'en', 1, 1, 2, 0, '2020-12-07 17:14:06', '2020-12-07 17:14:06'),
(25, 'Höör', 'hoor', 'en', 1, 1, 2, 0, '2020-12-07 17:14:47', '2020-12-07 17:14:47');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_mode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userplans`
--

CREATE TABLE `userplans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default.png',
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` int(11) NOT NULL,
  `badge_id` bigint(20) UNSIGNED DEFAULT NULL,
  `plan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'https://eatonline.se/uploads/store.jpg',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `badge_id`, `plan_id`, `slug`, `avatar`, `name`, `email`, `status`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, 'admin', 'https://eatonline.se/uploads/store.jpg', 'Admin', 'admin@admin.com', 'pending', NULL, '$2y$10$mSdiMB22tbZPTESW8/bPX.6EhLhfths9m7o9I152qpkxI5hdeGt1S', NULL, '2020-12-03 09:01:58', '2020-12-03 09:01:58'),
(2, 2, NULL, NULL, 'author', 'https://eatonline.se/uploads/store.jpg', 'Author', 'author@author.com', 'approved', NULL, '$2y$10$0UZLWbJTipyD8uhh4OdG8uurTw9MtCY7/AtsnqyzPDSncSlzBB7Cy', NULL, '2020-12-03 09:01:59', '2020-12-06 13:35:07'),
(3, 3, 9, 1, 'seasonal-tastes', 'https://eatonline.se/uploads/store.jpg', 'Seasonal Tastes', 'seller1@email.com', 'approved', '2020-08-02 20:11:23', '$2y$10$uUFJFhlbK4opx0CRWyVFP.lSXAkcAMIRCEZddl6OKCQ3ILBrVvHI6', NULL, '2020-12-03 09:01:59', '2020-12-07 11:20:27'),
(12, 4, NULL, NULL, 'rider', 'https://eatonline.se/uploads/store.jpg', 'Rider', 'rider@email.com', 'approved', '2020-08-02 20:11:23', '$2y$10$gXCHOSDm0uWnhmp7fGXxROZLPyhJ0SYeAeKS5b43Ku4.sMZzOAOT2', NULL, '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(13, 2, NULL, NULL, 'anjus-parsay', 'https://eatonline.se/uploads/store.jpg', 'Anjus parsay', 'ap@anjus.se', 'pending', NULL, '$2y$10$WL6LeajeAtmW8Yroe77z6Ovb94R5mDmzNvwazOKusVz1DeqWGp.k6', 'Gq03p3aXcUGronDadxB3FUregzfUGaGWRoYquLcMFxnxkhkwGC955jqmzijd', '2020-12-03 09:04:48', '2020-12-03 09:04:48'),
(14, 1, NULL, NULL, NULL, 'https://eatonline.se/uploads/store.jpg', 'Anjus Parsay', 'anjus@viralconvert.com', 'approved', NULL, '$2y$10$wgzN/sRcJgiboG8/LEoWBOBUsMj953VG0uK4kz1TTikVG3AlVB4OC', NULL, '2020-12-03 13:14:31', '2020-12-03 13:14:31'),
(15, 1, NULL, NULL, NULL, 'https://eatonline.se/uploads/store.jpg', 'Products', 'pl@afk.se', 'approved', NULL, '$2y$10$rmhSpzAqs/dYf9ilh5q30uLdmXw2oUcu7NhFOplRDF.1QEYWlzs3a', NULL, '2020-12-06 14:41:09', '2020-12-06 14:41:09'),
(16, 3, 9, 1, 'kyotosushi', 'https://eatonline.se/uploads/store.jpg', 'Kyotosushi', 'kyoto@viralconvert.com', 'approved', '2020-12-07 15:04:28', '$2y$10$6Q0wfVwEPSWtmLlOwk4Fv.UDQwwClwmjgVXDLUDFkos4rzBSdb2Qe', NULL, '2020-12-07 14:58:33', '2020-12-07 15:05:54'),
(17, 3, 9, 1, 'martenspizzeria-i-hoor', 'https://eatonline.se/uploads/store.jpg', 'Mårtenspizzeria i Höör', 'martenshoor@viralconvert.com', 'approved', '2020-12-07 17:33:54', '$2y$10$3jVqRQ/BgKnf6A.3NsKBmepgRqRNSY8jgsDDZq6F8qWCvf7i94Xiq', NULL, '2020-12-07 17:31:27', '2020-12-07 17:34:38'),
(18, 3, 9, 1, 'broderstugan', 'https://eatonline.se/uploads/store.jpg', 'broderstugan', 'broder@viralconvert.com', 'approved', '2020-12-07 19:17:45', '$2y$10$k6vNB9Iy38DrGThT2Xv8M.Ax8OSJ7yTaYdezyZSUN58LIrnuoX0jy', NULL, '2020-12-07 19:10:27', '2020-12-07 19:17:45'),
(19, 3, 9, 1, 'casa-antonio', 'https://eatonline.se/uploads/store.jpg', 'Casa Antonio', 'casa@viralconvert.com', 'approved', '2020-12-07 19:24:15', '$2y$10$kILQJaPGjIhk1wqgZPwjhekeNCUyA2Uc/JtuJUvCF685Q2bFvtiNi', NULL, '2020-12-07 19:23:02', '2020-12-07 19:26:04'),
(20, 3, 9, 1, 'gastronome', 'https://eatonline.se/uploads/store.jpg', 'Gastronome', 'gastronome@viralconvert.com', 'approved', '2020-12-07 19:32:26', '$2y$10$FvB4vBfURbXmIyCBQuYWV.8zKwmcJVke0NK0X9LYY/AjVyxduqbDG', NULL, '2020-12-07 19:28:35', '2020-12-07 19:32:26'),
(21, 3, 9, 1, 'wakarini', 'https://eatonline.se/uploads/store.jpg', 'Wakarini', 'wakarini@viralconvert.com', 'approved', '2020-12-07 19:39:13', '$2y$10$39MJdl2iPFTph3L6uI.l/OFlJN4VrcFzJHRk5BduGd0YFKNJ3pq/q', NULL, '2020-12-07 19:35:33', '2020-12-07 19:39:13'),
(22, 3, 9, 1, 'kinjo-sushi', 'https://eatonline.se/uploads/store.jpg', 'Kinjo Sushi', 'kinjo@viralconvert.com', 'approved', '2020-12-07 19:44:35', '$2y$10$yY3Nrgg.S0uqGpQs48iV.e43qysUJ4r7ytjISivaB8Zg0O6w0ddOe', NULL, '2020-12-07 19:43:18', '2020-12-07 19:45:27'),
(23, 3, 9, 1, 'vijay-gupt', 'https://eatonline.se/uploads/store.jpg', 'Vijay GUPT', 'vijaygupta1593@gmail.com', 'pending', NULL, '$2y$10$o3abllXr2gKVOOOcjylrfeYGpt5kwczWGAsQB701HIEf01P4ceh4C', NULL, '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(24, 3, 9, 1, 'vasant', 'https://eatonline.se/uploads/store.jpg', 'Vasant', 'business.leadindia@gmail.com', 'pending', NULL, '$2y$10$5ccwuBJZCv9YsmJeQtaveOSYgkB.YWTslIKxfg1F4y..3APv5Ddby', NULL, '2020-12-08 04:15:45', '2020-12-08 04:15:45');

-- --------------------------------------------------------

--
-- Table structure for table `user_category`
--

CREATE TABLE `user_category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_category`
--

INSERT INTO `user_category` (`id`, `user_id`, `category_id`, `created_at`, `updated_at`) VALUES
(6, 3, 7, '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(11, 16, 4, '2020-12-07 19:07:32', '2020-12-07 19:07:32'),
(12, 21, 4, '2020-12-07 19:41:17', '2020-12-07 19:41:17');

-- --------------------------------------------------------

--
-- Table structure for table `user_meta`
--

CREATE TABLE `user_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'preview',
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_meta`
--

INSERT INTO `user_meta` (`id`, `user_id`, `type`, `content`, `created_at`, `updated_at`) VALUES
(1, 3, 'delivery', '21', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(2, 3, 'pickup', '21', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(3, 3, 'rattings', '0', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(4, 3, 'avg_rattings', '0', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(5, 3, 'info', '{\"description\":\"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.\",\"phone1\":\"12345678901\",\"phone2\":\"12345678901\",\"email1\":\"seller1@email.com\",\"email2\":\"seller1@email.com\",\"address_line\":\"Lilla fiskaregatan 10\",\"full_address\":\"lilla fiskaregatan 10, 22223 Lund, sweden\"}', '2020-12-03 09:01:59', '2020-12-07 11:23:13'),
(6, 3, 'gallery', NULL, '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(7, 3, 'preview', 'https://eatonline.se/uploads/dummy/seller/seller1.jpg', '2020-12-03 09:01:59', '2020-12-03 09:01:59'),
(64, 12, 'info', '{\"phone1\":\"+1 (157) 364-3678\",\"phone2\":\"+1 (696) 983-9689\",\"full_address\":\"Agrabad, Chattogram, Bangladesh\"}', '2020-12-03 09:02:00', '2020-12-03 09:02:00'),
(65, 3, 'paypal_info', 'info@viralconvert.com', '2020-12-03 10:47:53', '2020-12-03 10:47:53'),
(66, 3, 'livechat', NULL, '2020-12-07 11:23:13', '2020-12-07 11:23:13'),
(67, 16, 'delivery', '60', '2020-12-07 14:58:33', '2020-12-07 14:58:33'),
(68, 16, 'pickup', '90', '2020-12-07 14:58:33', '2020-12-07 14:58:33'),
(69, 16, 'rattings', '0', '2020-12-07 14:58:33', '2020-12-07 14:58:33'),
(70, 16, 'avg_rattings', '0', '2020-12-07 14:58:33', '2020-12-07 14:58:33'),
(71, 16, 'info', '{\"description\":\"H\\u00e4r kan du prova p\\u00e5 den japanska nationalr\\u00e4tten, sushi. Sushi \\u00e4r inte bara en av v\\u00e4rldens mest lyxiga matr\\u00e4tter, den \\u00e4r ocks\\u00e5 v\\u00e4ldigt nyttig.\",\"phone1\":\"07000000000\",\"phone2\":\"07000000000\",\"email1\":\"kyoto@viralconvert.com\",\"email2\":\"kyoto@viralconvert.com\",\"address_line\":\"Pr\\u00e4stgatan 6\",\"full_address\":\"Pr\\u00e4stgatan 6, Helsingborg, Sverige\"}', '2020-12-07 14:58:33', '2020-12-07 14:59:25'),
(72, 16, 'gallery', '//eatonline.se/uploads/20/12/5fce76fbd1e390712201607366395.png', '2020-12-07 14:58:33', '2020-12-07 19:07:32'),
(73, 16, 'preview', '//eatonline.se/uploads/20/12/5fce76fbd1e390712201607366395.png', '2020-12-07 14:58:33', '2020-12-07 17:40:14'),
(74, 16, 'livechat', NULL, '2020-12-07 17:16:44', '2020-12-07 17:16:44'),
(75, 17, 'delivery', '60', '2020-12-07 17:31:27', '2020-12-07 17:31:27'),
(76, 17, 'pickup', '90', '2020-12-07 17:31:27', '2020-12-07 17:31:27'),
(77, 17, 'rattings', '0', '2020-12-07 17:31:27', '2020-12-07 17:31:27'),
(78, 17, 'avg_rattings', '0', '2020-12-07 17:31:27', '2020-12-07 17:31:27'),
(79, 17, 'info', '{\"description\":\"Din pizzeria i H\\u00f6\\u00f6r\",\"phone1\":\"0700000000\",\"phone2\":\"0700000000\",\"email1\":\"martenshoor@viralconvert.com\",\"email2\":\"martenshoor@viralconvert.com\",\"address_line\":\"Storgatan 35A\",\"full_address\":\"Storgatan 35A, 243 30 H\\u00f6\\u00f6r, Sverige\"}', '2020-12-07 17:31:27', '2020-12-07 17:32:31'),
(80, 17, 'gallery', '//eatonline.se/uploads/20/12/5fce7674121e20712201607366260.png', '2020-12-07 17:31:27', '2020-12-07 17:38:25'),
(81, 17, 'preview', '//eatonline.se/uploads/20/12/5fce7674121e20712201607366260.png', '2020-12-07 17:31:27', '2020-12-07 17:38:25'),
(82, 17, 'livechat', NULL, '2020-12-07 17:38:25', '2020-12-07 17:38:25'),
(83, 18, 'delivery', '60', '2020-12-07 19:10:27', '2020-12-07 19:10:27'),
(84, 18, 'pickup', '90', '2020-12-07 19:10:27', '2020-12-07 19:10:27'),
(85, 18, 'rattings', '0', '2020-12-07 19:10:27', '2020-12-07 19:10:27'),
(86, 18, 'avg_rattings', '0', '2020-12-07 19:10:27', '2020-12-07 19:10:27'),
(87, 18, 'info', '{\"description\":\"Broderstugan \\u00e4r ett familje\\u00e4gt f\\u00f6retag.\\r\\nVi har med gl\\u00e4dje serverat v\\u00e5ra g\\u00e4ster\\r\\ngod mat och dryck sedan 1997.\",\"phone1\":\"040930074\",\"phone2\":\"0700093030\",\"email1\":\"broder@viralconvert.com\",\"email2\":\"broder@viralconvert.com\",\"address_line\":\"\\u00d6stra F\\u00f6rstadsgatan 33\",\"full_address\":\"\\u00d6stra F\\u00f6rstadsgatan 33, 212 12 Malm\\u00f6, Sverige\"}', '2020-12-07 19:10:27', '2020-12-07 19:20:37'),
(88, 18, 'gallery', '//eatonline.se/uploads/20/12/5fce8dfb1dc4b0712201607372283.png', '2020-12-07 19:10:27', '2020-12-07 19:20:37'),
(89, 18, 'preview', '//eatonline.se/uploads/20/12/5fce8dfb1dc4b0712201607372283.png', '2020-12-07 19:10:27', '2020-12-07 19:20:37'),
(90, 18, 'livechat', NULL, '2020-12-07 19:20:37', '2020-12-07 19:20:37'),
(91, 19, 'delivery', '60', '2020-12-07 19:23:02', '2020-12-07 19:23:02'),
(92, 19, 'pickup', '90', '2020-12-07 19:23:02', '2020-12-07 19:23:02'),
(93, 19, 'rattings', '0', '2020-12-07 19:23:02', '2020-12-07 19:23:02'),
(94, 19, 'avg_rattings', '0', '2020-12-07 19:23:02', '2020-12-07 19:23:02'),
(95, 19, 'info', '{\"description\":\"Ingen kvarterskrog utan den klassiska svenska pizzan. Unna dig sj\\u00e4lv en pizza med kr\\u00e4mig gr\\u00e4ddost och v\\u00e4lk\\u00e4nda kombinationer av ingredienser. Hos oss f\\u00e5r du den lagad med extra k\\u00e4rlek och v\\u00e5r b\\u00e4sta deg n\\u00e5gonsin.\",\"phone1\":\"0700000000\",\"phone2\":\"0700000000\",\"email1\":\"casa@viralconvert.com\",\"email2\":\"casa@viralconvert.com\",\"address_line\":\"Nordanv\\u00e4g 7-9, Lund\",\"full_address\":\"Nordanv\\u00e4g 7-9, Lund, Sverige\"}', '2020-12-07 19:23:02', '2020-12-07 19:23:23'),
(96, 19, 'gallery', '//eatonline.se/uploads/20/12/5fce8ffc710ea0712201607372796.png', '2020-12-07 19:23:02', '2020-12-07 19:26:52'),
(97, 19, 'preview', '//eatonline.se/uploads/20/12/5fce8ffc710ea0712201607372796.png', '2020-12-07 19:23:02', '2020-12-07 19:26:52'),
(98, 19, 'livechat', NULL, '2020-12-07 19:26:52', '2020-12-07 19:26:52'),
(99, 20, 'delivery', '60', '2020-12-07 19:28:35', '2020-12-07 19:28:35'),
(100, 20, 'pickup', '90', '2020-12-07 19:28:35', '2020-12-07 19:28:35'),
(101, 20, 'rattings', '0', '2020-12-07 19:28:35', '2020-12-07 19:28:35'),
(102, 20, 'avg_rattings', '0', '2020-12-07 19:28:35', '2020-12-07 19:28:35'),
(103, 20, 'info', '{\"description\":\"\\u201dGASTRO|nome \\u00e4r en Svensk gastropub med influenser fr\\u00e5n Italien, med stort fokus p\\u00e5 g\\u00e4sten. Man ska k\\u00e4nna sig v\\u00e4l m\\u00f6tt n\\u00e4r man kommer till oss. Vare sig man kommer f\\u00f6r en god bit mat eller sticker in f\\u00f6r ett par glas gott s\\u00e5 har man kommit helt r\\u00e4tt!\",\"phone1\":\"0700000000\",\"phone2\":\"0700000000\",\"email1\":\"gastronome@viralconvert.com\",\"email2\":\"gastronome@viralconvert.com\",\"address_line\":\"Bangatan 6,\\u2028 22221 Lund\",\"full_address\":\"Bangatan 6, 222 21 Lund, Sverige\"}', '2020-12-07 19:28:35', '2020-12-07 19:34:04'),
(104, 20, 'gallery', '//eatonline.se/uploads/20/12/5fce9166a51320712201607373158.png', '2020-12-07 19:28:35', '2020-12-07 19:34:04'),
(105, 20, 'preview', '//eatonline.se/uploads/20/12/5fce9166a51320712201607373158.png', '2020-12-07 19:28:35', '2020-12-07 19:34:04'),
(106, 20, 'livechat', NULL, '2020-12-07 19:34:04', '2020-12-07 19:34:04'),
(107, 21, 'delivery', '60', '2020-12-07 19:35:33', '2020-12-07 19:35:33'),
(108, 21, 'pickup', '90', '2020-12-07 19:35:33', '2020-12-07 19:35:33'),
(109, 21, 'rattings', '0', '2020-12-07 19:35:33', '2020-12-07 19:35:33'),
(110, 21, 'avg_rattings', '0', '2020-12-07 19:35:33', '2020-12-07 19:35:33'),
(111, 21, 'info', '{\"description\":\"Wakarini sushi \\u00e4r en japansk restaurang med fokus p\\u00e5 sushi.\\r\\nVi h\\u00e5ller det simpelt, med en k\\u00e4nsla av fr\\u00e4schhet och exklusivitet.\\r\\nVi vill att ni ska testa allt hos oss, d\\u00e4rf\\u00f6r har vi anpassat v\\u00e5r meny s\\u00e5 det ska vara enkelt att kombinera sj\\u00e4lv.\\r\\nI v\\u00e5r m\",\"phone1\":\"0700000000\",\"phone2\":\"0700000000\",\"email1\":\"wakarini@viralconvert.com\",\"email2\":\"wakarini@viralconvert.com\",\"address_line\":\"Drottninggatan 74 252 21, Helsingborg\",\"full_address\":\"Drottninggatan 74, 252 21 Helsingborg, Sverige\"}', '2020-12-07 19:35:33', '2020-12-07 19:41:17'),
(112, 21, 'gallery', '//eatonline.se/uploads/20/12/5fce932a092ca0712201607373610.png', '2020-12-07 19:35:33', '2020-12-07 19:41:17'),
(113, 21, 'preview', '//eatonline.se/uploads/20/12/5fce932a092ca0712201607373610.png', '2020-12-07 19:35:33', '2020-12-07 19:41:17'),
(114, 21, 'livechat', NULL, '2020-12-07 19:41:17', '2020-12-07 19:41:17'),
(115, 22, 'delivery', '60', '2020-12-07 19:43:18', '2020-12-07 19:43:18'),
(116, 22, 'pickup', '90', '2020-12-07 19:43:18', '2020-12-07 19:43:18'),
(117, 22, 'rattings', '0', '2020-12-07 19:43:18', '2020-12-07 19:43:18'),
(118, 22, 'avg_rattings', '0', '2020-12-07 19:43:18', '2020-12-07 19:43:18'),
(119, 22, 'info', '{\"description\":\"Det som g\\u00f6r v\\u00e5r sushi unik \\u00e4r mer \\u00e4n bara fantastiska och dagsf\\u00e4rska r\\u00e5varor. Hos oss \\u00e4r utf\\u00f6randet det avg\\u00f6rande och vi l\\u00e4gger stor omsorg i tillagningen som bygger p\\u00e5 traditionella processer som \\u00e4r utformade f\\u00f6r att ta fram det b\\u00e4sta ur alla v\\u00e5ra\",\"phone1\":\"0700000000\",\"phone2\":\"0700000000\",\"email1\":\"kinjo@viralconvert.com\",\"email2\":\"kinjo@viralconvert.com\",\"address_line\":\"M\\u00e5rtenstorget 7, Lund\",\"full_address\":\"M\\u00e5rtenstorget 7, Lund, Sverige\"}', '2020-12-07 19:43:18', '2020-12-07 19:47:41'),
(120, 22, 'gallery', '//eatonline.se/uploads/20/12/5fce9492b61f20712201607373970.png', '2020-12-07 19:43:18', '2020-12-07 19:47:41'),
(121, 22, 'preview', '//eatonline.se/uploads/20/12/5fce9492b61f20712201607373970.png', '2020-12-07 19:43:18', '2020-12-07 19:47:41'),
(122, 22, 'livechat', NULL, '2020-12-07 19:47:41', '2020-12-07 19:47:41'),
(123, 23, 'delivery', '20', '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(124, 23, 'pickup', '30', '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(125, 23, 'rattings', '0', '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(126, 23, 'avg_rattings', '0', '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(127, 23, 'info', '{\"description\":\"Hii\",\"phone1\":\"09582421279\",\"phone2\":\"09582421279\",\"email1\":\"vijaygupta1593@gmail.com\",\"email2\":\"vijaygupta1593@gmail.com\",\"address_line\":null,\"full_address\":null}', '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(128, 23, 'gallery', NULL, '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(129, 23, 'preview', NULL, '2020-12-08 04:11:14', '2020-12-08 04:11:14'),
(130, 24, 'delivery', '11', '2020-12-08 04:15:45', '2020-12-08 04:15:45'),
(131, 24, 'pickup', '23', '2020-12-08 04:15:45', '2020-12-08 04:15:45'),
(132, 24, 'rattings', '0', '2020-12-08 04:15:45', '2020-12-08 04:15:45'),
(133, 24, 'avg_rattings', '0', '2020-12-08 04:15:45', '2020-12-08 04:15:45'),
(134, 24, 'info', '{\"description\":\"test\",\"phone1\":\"08860782822\",\"phone2\":\"08860782822\",\"email1\":\"business.leadindia@gmail.com\",\"email2\":\"business.leadindia@gmail.com\",\"address_line\":\"test\",\"full_address\":\"test wrw\"}', '2020-12-08 04:15:45', '2020-12-08 04:15:59'),
(135, 24, 'gallery', NULL, '2020-12-08 04:15:45', '2020-12-08 04:15:45'),
(136, 24, 'preview', NULL, '2020-12-08 04:15:45', '2020-12-08 04:15:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addons`
--
ALTER TABLE `addons`
  ADD KEY `addons_term_id_foreign` (`term_id`),
  ADD KEY `addons_addon_id_foreign` (`addon_id`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_user_id_foreign` (`user_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_vendor_id_foreign` (`vendor_id`),
  ADD KEY `comments_order_id_foreign` (`order_id`);

--
-- Indexes for table `comment_meta`
--
ALTER TABLE `comment_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comment_meta_comment_id_foreign` (`comment_id`),
  ADD KEY `comment_meta_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `customizers`
--
ALTER TABLE `customizers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `featured_user`
--
ALTER TABLE `featured_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `featured_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `live`
--
ALTER TABLE `live`
  ADD PRIMARY KEY (`id`),
  ADD KEY `live_order_id_foreign` (`order_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `locations_user_id_foreign` (`user_id`),
  ADD KEY `locations_role_id_foreign` (`role_id`),
  ADD KEY `locations_term_id_foreign` (`term_id`);

--
-- Indexes for table `medias`
--
ALTER TABLE `medias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medias_user_id_foreign` (`user_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meta`
--
ALTER TABLE `meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_term_id_foreign` (`term_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderlogs`
--
ALTER TABLE `orderlogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderlogs_order_id_foreign` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_vendor_id_foreign` (`vendor_id`),
  ADD KEY `orders_rider_id_foreign` (`rider_id`);

--
-- Indexes for table `order_meta`
--
ALTER TABLE `order_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_meta_order_id_foreign` (`order_id`),
  ADD KEY `order_meta_term_id_foreign` (`term_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plan_meta`
--
ALTER TABLE `plan_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_category`
--
ALTER TABLE `post_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_category_term_id_foreign` (`term_id`),
  ADD KEY `post_category_category_id_foreign` (`category_id`);

--
-- Indexes for table `product_meta`
--
ALTER TABLE `product_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_meta_term_id_foreign` (`term_id`);

--
-- Indexes for table `riderlogs`
--
ALTER TABLE `riderlogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `riderlogs_order_id_foreign` (`order_id`),
  ADD KEY `riderlogs_user_id_foreign` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `shop_day`
--
ALTER TABLE `shop_day`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shop_day_user_id_foreign` (`user_id`);

--
-- Indexes for table `signal_users`
--
ALTER TABLE `signal_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `signal_users_user_id_foreign` (`user_id`);

--
-- Indexes for table `terms`
--
ALTER TABLE `terms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `terms_auth_id_foreign` (`auth_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `userplans`
--
ALTER TABLE `userplans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userplans_user_id_foreign` (`user_id`),
  ADD KEY `userplans_plan_id_foreign` (`plan_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_plan_id_foreign` (`plan_id`);

--
-- Indexes for table `user_category`
--
ALTER TABLE `user_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_category_user_id_foreign` (`user_id`),
  ADD KEY `user_category_category_id_foreign` (`category_id`);

--
-- Indexes for table `user_meta`
--
ALTER TABLE `user_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_meta_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comment_meta`
--
ALTER TABLE `comment_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customizers`
--
ALTER TABLE `customizers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `featured_user`
--
ALTER TABLE `featured_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `live`
--
ALTER TABLE `live`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `medias`
--
ALTER TABLE `medias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `meta`
--
ALTER TABLE `meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orderlogs`
--
ALTER TABLE `orderlogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_meta`
--
ALTER TABLE `order_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan_meta`
--
ALTER TABLE `plan_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `post_category`
--
ALTER TABLE `post_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_meta`
--
ALTER TABLE `product_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `riderlogs`
--
ALTER TABLE `riderlogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `shop_day`
--
ALTER TABLE `shop_day`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `signal_users`
--
ALTER TABLE `signal_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms`
--
ALTER TABLE `terms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userplans`
--
ALTER TABLE `userplans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `user_category`
--
ALTER TABLE `user_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_meta`
--
ALTER TABLE `user_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addons`
--
ALTER TABLE `addons`
  ADD CONSTRAINT `addons_addon_id_foreign` FOREIGN KEY (`addon_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `addons_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comment_meta`
--
ALTER TABLE `comment_meta`
  ADD CONSTRAINT `comment_meta_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comment_meta_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `featured_user`
--
ALTER TABLE `featured_user`
  ADD CONSTRAINT `featured_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `live`
--
ALTER TABLE `live`
  ADD CONSTRAINT `live_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `locations_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `locations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medias`
--
ALTER TABLE `medias`
  ADD CONSTRAINT `medias_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `meta`
--
ALTER TABLE `meta`
  ADD CONSTRAINT `meta_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orderlogs`
--
ALTER TABLE `orderlogs`
  ADD CONSTRAINT `orderlogs_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_meta`
--
ALTER TABLE `order_meta`
  ADD CONSTRAINT `order_meta_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_meta_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_category`
--
ALTER TABLE `post_category`
  ADD CONSTRAINT `post_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_category_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_meta`
--
ALTER TABLE `product_meta`
  ADD CONSTRAINT `product_meta_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `riderlogs`
--
ALTER TABLE `riderlogs`
  ADD CONSTRAINT `riderlogs_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `riderlogs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `admin_roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `shop_day`
--
ALTER TABLE `shop_day`
  ADD CONSTRAINT `shop_day_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `signal_users`
--
ALTER TABLE `signal_users`
  ADD CONSTRAINT `signal_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `terms`
--
ALTER TABLE `terms`
  ADD CONSTRAINT `terms_auth_id_foreign` FOREIGN KEY (`auth_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `userplans`
--
ALTER TABLE `userplans`
  ADD CONSTRAINT `userplans_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plan_meta` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `userplans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plan_meta` (`id`);

--
-- Constraints for table `user_category`
--
ALTER TABLE `user_category`
  ADD CONSTRAINT `user_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_category_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_meta`
--
ALTER TABLE `user_meta`
  ADD CONSTRAINT `user_meta_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
