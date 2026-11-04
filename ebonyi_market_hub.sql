-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2026 at 03:20 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ebonyi_market_hub`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `user_id`, `listing_id`, `quantity`, `added_at`, `updated_at`) VALUES
(51, 25, 13, 1, '2026-08-19 15:21:46', '2026-08-19 15:21:46'),
(63, 26, 22, 1, '2026-10-13 14:16:24', '2026-10-13 14:16:24'),
(67, 24, 24, 1, '2026-11-02 03:41:46', '2026-11-02 03:41:46');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `parent_id` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `icon`, `status`, `parent_id`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 'Real Estate', 'Properties for sale and rent', NULL, 'fa-home', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(2, 'Electronics', 'Phones, laptops, and gadgets', NULL, 'fa-mobile', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(3, 'Fashion', 'Clothing, shoes, and accessories', NULL, 'fa-tshirt', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(4, 'Vehicles', 'Cars, motorcycles, and parts', NULL, 'fa-car', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(5, 'Jobs', 'Employment opportunities', NULL, 'fa-briefcase', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(6, 'Services', 'Professional services', NULL, 'fa-cogs', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(7, 'Furniture', 'Home and office furniture', NULL, 'fa-couch', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(8, 'Books', 'Books, magazines, and educational materials', NULL, 'fa-book', 'active', NULL, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(10, 'New Items', 'Post New Items', NULL, 'fa-tag', 'active', NULL, 0, '2026-08-04 15:32:30', '2026-08-04 15:32:30'),
(11, 'Car', 'Listing of all brand of cars', NULL, 'fa-fas fa-shuttle-van', 'active', NULL, 0, '2026-08-06 15:29:16', '2026-08-06 15:29:16'),
(12, 'Babies', 'Get Your Baby\'s Dress', NULL, 'fa-tshirt', 'active', NULL, 0, '2026-08-06 16:49:24', '2026-08-06 16:49:24'),
(13, 'Used Items', 'All used Items', NULL, 'fa-tag', 'active', NULL, 0, '2026-08-07 09:23:39', '2026-08-07 09:23:39');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `discount_type` enum('percentage','fixed') DEFAULT 'percentage',
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT 0.00,
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `listing_id`, `created_at`) VALUES
(3, 24, 18, '2026-10-23 01:07:08');

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(11) NOT NULL,
  `job_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `resume_path` varchar(255) DEFAULT NULL,
  `cover_letter` text DEFAULT NULL,
  `status` enum('pending','reviewed','shortlisted','rejected','hired') DEFAULT 'pending',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `listings`
--

CREATE TABLE `listings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT 'Ebonyi',
  `property_type` enum('house','apartment','commercial','land','other') DEFAULT 'house',
  `listing_type` enum('sale','rent','lease') DEFAULT 'sale',
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `floor_area` decimal(10,2) DEFAULT NULL,
  `land_area` decimal(10,2) DEFAULT NULL,
  `item_condition` enum('new','used','refurbished') DEFAULT 'used',
  `brand` varchar(100) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `contact_email` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('active','pending','sold','rented','expired') DEFAULT 'pending',
  `is_featured` tinyint(1) DEFAULT 0,
  `views_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `listings`
--

INSERT INTO `listings` (`id`, `user_id`, `category`, `category_id`, `title`, `slug`, `description`, `price`, `location`, `city`, `state`, `property_type`, `listing_type`, `bedrooms`, `bathrooms`, `floor_area`, `land_area`, `item_condition`, `brand`, `contact_name`, `contact_phone`, `contact_email`, `image`, `status`, `is_featured`, `views_count`, `created_at`, `updated_at`) VALUES
(13, 23, 'Electronics', NULL, 'ELECTRONICS', 'lg-smart-television-1786105079', '55-Inch LG Smart Television for Sale, New', '350000.00', 'Ebonyi State', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'new', 'Lg', 'Chigozie Okeye', '08130413479', 'okeyechigozie30@gmail.com', 'uploads/listings/1786105079_images (3).jpg', 'active', 0, 0, '2026-08-07 12:18:00', '2026-08-19 14:48:45'),
(14, 31, 'Fashion', NULL, 'Fashion', 'female-treft-wear-1786108634', 'Nice Wear for ladies, this is perfect and affordable', '50000.00', 'Enugu', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Solomon Vicky', '08130413479', 'okeyechigozie38@gmail.com', 'uploads/listings/1786108634_download (9).jpg', 'active', 0, 3, '2026-08-07 13:17:14', '2026-10-23 01:39:06'),
(15, 25, 'Car', NULL, 'Cars', 'camry-1786108884', 'this is 2024 model', '10000000.00', 'Lagos State', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Chigozie Success', '08130413479', 'okeyechigozie32@gmail.com', 'uploads/listings/1786108884_images (22).jpg', 'active', 0, 1, '2026-08-07 13:21:24', '2026-08-19 14:48:59'),
(16, 27, 'Real Estate', NULL, 'Real Estate', 'three-bedroo-flats-for-rent-1786109320', 'Well tiled, gated three bedroom apartment, very spacious, with two toilets', '1500000.00', 'Abia', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Chigozie Blessing', '08130413479', 'okeyechigozie34@gmail.com', 'uploads/listings/1786109320_images (59).jpg', 'active', 0, 4, '2026-08-07 13:28:40', '2026-10-08 15:04:06'),
(17, 24, 'Electronics', NULL, 'Electronics', 'deep-freezer-1786117578', 'this is 150 litres deep freezer for sale, it is new and still in a carton', '400000.00', 'Ebonyi State', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'new', 'Hisense', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1786117578_images (8).jpg', 'active', 0, 6, '2026-08-07 15:46:18', '2026-10-23 01:35:41'),
(18, 24, 'Electronics', NULL, 'Electronics', 'standing-fan--1786117712', 'This is Industrial Fan for sale,new', '150000.00', 'Ebonyi State', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'new', 'Nexus', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1786117712_images (15).jpg', 'active', 0, 5, '2026-08-07 15:48:32', '2026-10-23 01:07:14'),
(19, 24, 'Electronics', NULL, 'Electronics', 'ceiling-fan-1786117920', 'This is Giant 60 New Ceiling  Fan for sale. New and in Carton. ', '45000.00', 'Abia', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'new', 'Giant 60', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1786117920_images (14).jpg', 'active', 0, 7, '2026-08-07 15:52:00', '2026-10-23 01:07:45'),
(20, 24, 'Fashion', NULL, 'Fashion', 'men-s-thrift-wear-1786118635', 'Men\\\'s coporate wear available in whole sale and retail. ', '60000.00', 'Enugu', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1786118635_images (42).jpg', 'active', 0, 7, '2026-08-07 16:03:55', '2026-11-02 04:10:01'),
(21, 24, 'Babies', NULL, 'babies clothings', 'babies-clothings-1786123283', 'babies threft waer', '25000.00', 'Abuja', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1786123283_download (10).jpg', 'active', 0, 10, '2026-08-07 17:21:23', '2026-10-23 01:13:22'),
(22, 24, 'Services', NULL, 'Need a website developer ', 'need-a-website-developer--1787153780', 'I need a full stack Developer for a priject', '200000.00', 'Remote', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1787153780_586772.jpg', 'active', 0, 4, '2026-08-19 15:36:20', '2026-10-23 01:36:25'),
(23, 26, 'Jobs', NULL, 'Graphics designer needed', 'graphics-designer-needed-1791470852', 'a good grpahics designer is needed urgently', '40000.00', 'Lagos', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Emmy John', '08130413479', 'okeyechigozie33@gmail.com', 'uploads/listings/1791470853_kings.jpg', 'active', 0, 0, '2026-10-08 14:47:33', '2026-10-08 14:47:33'),
(24, 24, 'Babies', NULL, 'HANGER FOR SALE', 'hanger-for-sale-1793589953', 'NEW BABIES HANGER FOR SALE', '25000.00', 'INTERNATIONAL MARKET', NULL, 'Ebonyi', 'house', 'sale', NULL, NULL, NULL, NULL, 'used', '', 'Chigozie Miracle', '08130413479', 'okeyechigozie3@gmail.com', 'uploads/listings/1793589953_IMG_20261023_004824.jpg', 'active', 0, 1, '2026-11-02 03:25:54', '2026-11-02 04:19:31');

-- --------------------------------------------------------

--
-- Table structure for table `listing_images`
--

CREATE TABLE `listing_images` (
  `id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `listing_images`
--

INSERT INTO `listing_images` (`id`, `listing_id`, `image_url`, `is_primary`, `sort_order`, `created_at`) VALUES
(13, 13, 'uploads/listings/1786105079_images (3).jpg', 1, 0, '2026-08-07 12:18:01'),
(14, 14, 'uploads/listings/1786108634_download (9).jpg', 1, 0, '2026-08-07 13:17:15'),
(15, 15, 'uploads/listings/1786108884_images (22).jpg', 1, 0, '2026-08-07 13:21:24'),
(16, 16, 'uploads/listings/1786109320_images (59).jpg', 1, 0, '2026-08-07 13:28:41'),
(17, 17, 'uploads/listings/1786117578_images (8).jpg', 1, 0, '2026-08-07 15:46:18'),
(18, 18, 'uploads/listings/1786117712_images (15).jpg', 1, 0, '2026-08-07 15:48:33'),
(19, 19, 'uploads/listings/1786117920_images (14).jpg', 1, 0, '2026-08-07 15:52:00'),
(20, 20, 'uploads/listings/1786118635_images (42).jpg', 1, 0, '2026-08-07 16:03:55'),
(21, 21, 'uploads/listings/1786123283_download (10).jpg', 1, 0, '2026-08-07 17:21:23'),
(22, 22, 'uploads/listings/1787153780_586772.jpg', 1, 0, '2026-08-19 15:36:20'),
(23, 23, 'uploads/listings/1791470853_kings.jpg', 1, 0, '2026-10-08 14:47:34'),
(24, 24, 'uploads/listings/1793589953_IMG_20261023_004824.jpg', 1, 0, '2026-11-02 03:25:55'),
(25, 24, 'uploads/listings/1793589955_1_IMG_20261023_004837.jpg', 0, 1, '2026-11-02 03:25:55');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `listing_id` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `listing_id`, `message`, `is_read`, `created_at`) VALUES
(5, 24, 26, NULL, 'fdghjkjdsfgmhjk', 1, '2026-08-22 09:31:14'),
(6, 26, 24, NULL, 'thank you', 1, '2026-08-22 09:45:14'),
(7, 24, 26, NULL, 'welcome', 1, '2026-10-08 14:32:40'),
(8, 26, 24, NULL, 'You are the best', 0, '2026-10-08 14:40:31');

-- --------------------------------------------------------

--
-- Table structure for table `newsletter_subscribers`
--

CREATE TABLE `newsletter_subscribers` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','unsubscribed') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `link`, `is_read`, `created_at`) VALUES
(18, 25, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-07 17:28:13'),
(19, 31, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-07 17:28:14'),
(20, 23, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 17:37:47'),
(21, 24, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 17:37:47'),
(22, 24, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 17:37:47'),
(23, 24, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 17:37:48'),
(24, 23, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 19:31:40'),
(25, 24, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 19:31:40'),
(26, 24, 'new_order', 'New Order Received!', 'You have a new order for \'babies clothings\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 19:46:04'),
(27, 23, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-07 19:46:04'),
(28, 25, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-07 20:23:55'),
(29, 24, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-07 20:23:55'),
(30, 25, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00042)', 'dashboard.php?tab=orders', 0, '2026-08-12 06:40:54'),
(31, 24, 'new_order', 'New Order Received!', 'You have a new order for \'0\' (Order #00043)', 'dashboard.php?tab=orders', 1, '2026-08-16 01:12:17'),
(32, 25, 'new_order', 'New Order Received!', 'You have a new order for \'Cars\' — Qty: 2 — ₦20,000,000.00 (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-19 15:10:15'),
(33, 31, 'new_order', 'New Order Received!', 'You have a new order for \'Fashion\' — Qty: 2 — ₦100,000.00 (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-19 15:10:15'),
(34, 23, 'new_order', 'New Order Received!', 'You have a new order for \'ELECTRONICS\' — Qty: 2 — ₦700,000.00 (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-19 15:10:15'),
(35, 31, 'new_order', 'New Order Received!', 'You have a new order for \'Fashion\' — Qty: 2 — ₦100,000.00 (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-19 15:25:14'),
(36, 23, 'new_order', 'New Order Received!', 'You have a new order for \'ELECTRONICS\' — Qty: 2 — ₦700,000.00 (Order #00000)', 'dashboard.php?tab=orders', 0, '2026-08-19 15:25:14'),
(37, 24, 'new_order', 'New Order Received!', 'You have a new order for \'Fashion\' — Qty: 1 — ₦60,000.00 (Order #00000)', 'dashboard.php?tab=orders', 1, '2026-08-19 15:25:14'),
(38, 26, 'message', 'New message from Mira', 'fdghjkjdsfgmhjk', 'dashboard.php', 1, '2026-08-22 09:31:14'),
(39, 24, 'message', 'New message from Emmy', 'thank you', 'dashboard.php', 1, '2026-08-22 09:45:14'),
(40, 26, 'message', 'New message from Mira', 'welcome', 'dashboard.php', 1, '2026-10-08 14:32:40'),
(41, 24, 'message', 'New message from Emmy', 'You are the best', 'dashboard.php', 0, '2026-10-08 14:40:31'),
(42, 23, 'new_order', 'New Order Received!', 'You have a new order for \'ELECTRONICS\' — Qty: 1 — ₦350,000.00 (Order #00052)', 'dashboard.php?tab=orders', 0, '2026-10-08 14:50:33'),
(43, 23, 'new_order', 'New Order Received!', 'You have a new order for \'ELECTRONICS\' — Qty: 1 — ₦350,000.00 (Order #00053)', 'dashboard.php?tab=orders', 0, '2026-10-23 01:06:07');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `listing_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `payment_status` enum('pending','paid','failed','refunded') DEFAULT 'pending',
  `shipping_address` text DEFAULT NULL,
  `billing_address` text DEFAULT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quantity` int(11) NOT NULL DEFAULT 1,
  `delivery_address` text DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `user_id`, `listing_id`, `store_id`, `total_amount`, `status`, `payment_status`, `shipping_address`, `billing_address`, `shipping_method`, `payment_method`, `notes`, `created_at`, `updated_at`, `quantity`, `delivery_address`, `subtotal`) VALUES
(24, 'ORD-20260807-CA8995', 24, 15, 25, '20050000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-07 17:28:12', '2026-08-07 17:28:13', 2, 'Abuja', '20000000.00'),
(26, 'ORD-20260807-B2A2C5', 30, 13, 23, '2640000.00', 'shipped', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-07 17:37:47', '2026-08-07 19:40:56', 4, 'onueke', '1400000.00'),
(30, 'ORD-20260807-BC9EE9', 30, 13, 23, '1150000.00', 'shipped', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-07 19:31:39', '2026-08-07 19:40:39', 2, 'Presco', '700000.00'),
(32, 'ORD-20260807-C62378', 26, 21, 24, '375000.00', 'confirmed', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-07 19:46:04', '2026-08-07 19:46:44', 1, 'Ebonyi State', '25000.00'),
(40, 'ORD-20260807-A8AA6A', 26, 15, 25, '10400000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-07 20:23:54', '2026-08-07 20:23:55', 1, 'hgjkk', '10000000.00'),
(42, 'ORD-20260812-550E8F', 24, 15, 25, '30000000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-12 06:40:53', '2026-08-12 06:40:53', 3, 'ebonyi', '30000000.00'),
(43, 'ORD-20260816-05B193', 24, 19, 24, '90000.00', 'delivered', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-16 01:12:16', '2026-11-02 04:20:30', 2, 'hjkl', '90000.00'),
(44, 'ORD-20260819-F01962', 24, 14, 31, '850000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-19 15:06:39', '2026-08-19 15:06:39', 3, 'enugu', '150000.00'),
(46, 'ORD-20260819-6F34E0', 24, 15, 25, '20800000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-19 15:10:14', '2026-08-19 15:10:15', 2, 'pfrescp', '20000000.00'),
(49, 'ORD-20260819-A02E1D', 24, 14, 31, '860000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-08-19 15:25:14', '2026-08-19 15:25:14', 2, 'ENUGU', '100000.00'),
(52, 'ORD-20261008-764E67', 26, 13, 23, '350000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-10-08 14:50:32', '2026-10-08 14:50:32', 1, 'enugu', '350000.00'),
(53, 'ORD-20261023-E7038C', 24, 13, 23, '350000.00', 'pending', 'pending', NULL, NULL, NULL, NULL, NULL, '2026-10-23 01:06:06', '2026-10-23 01:06:06', 1, 'cfghjkl', '350000.00');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `compare_price` decimal(10,2) DEFAULT NULL,
  `cost_per_item` decimal(10,2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `track_quantity` tinyint(1) DEFAULT 1,
  `allow_backorders` tinyint(1) DEFAULT 0,
  `weight` decimal(8,2) DEFAULT NULL,
  `dimensions` varchar(100) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT 0,
  `status` enum('active','draft','archived') DEFAULT 'active',
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `compare_price`, `cost_per_item`, `category_id`, `vendor_id`, `sku`, `barcode`, `quantity`, `track_quantity`, `allow_backorders`, `weight`, `dimensions`, `featured`, `status`, `meta_title`, `meta_description`, `created_at`, `updated_at`) VALUES
(1, 'Sample Product 1', 'This is a sample product description', '5000.00', NULL, NULL, NULL, 1, NULL, NULL, 0, 1, 0, NULL, NULL, 0, 'active', NULL, NULL, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(2, 'Sample Product 2', 'Another sample product', '7500.00', NULL, NULL, NULL, 1, NULL, NULL, 0, 1, 0, NULL, NULL, 0, 'active', NULL, NULL, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(3, 'Sample Product 3', 'Third sample product', '12000.00', NULL, NULL, NULL, 1, NULL, NULL, 0, 1, 0, NULL, NULL, 0, 'active', NULL, NULL, '2026-07-31 08:44:15', '2026-07-31 08:44:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_text` text DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_submissions`
--

CREATE TABLE `product_submissions` (
  `id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `property_inquiries`
--

CREATE TABLE `property_inquiries` (
  `id` int(11) NOT NULL,
  `property_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `inquiry_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('new','contacted','viewed','closed') DEFAULT 'new'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `category` varchar(50) DEFAULT 'general',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `setting_key`, `setting_value`, `category`, `created_at`) VALUES
(1, 'site_name', 'Ebonyi Market Hub', 'general', '2026-07-31 08:44:15'),
(2, 'site_email', 'info@ebonyimarkethub.com', 'general', '2026-07-31 08:44:15'),
(3, 'currency', 'NGN', 'general', '2026-07-31 08:44:15'),
(4, 'currency_symbol', '₦', 'general', '2026-07-31 08:44:15'),
(5, 'enable_storefronts', '1', 'storefront', '2026-07-31 08:44:15'),
(6, 'enable_vendor_registration', '1', 'storefront', '2026-07-31 08:44:15'),
(7, 'store_verification_required', '1', 'storefront', '2026-07-31 08:44:15'),
(8, 'max_products_free', '5', 'storefront', '2026-07-31 08:44:15'),
(9, 'max_products_premium', '100', 'storefront', '2026-07-31 08:44:15');

-- --------------------------------------------------------

--
-- Table structure for table `store_analytics`
--

CREATE TABLE `store_analytics` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `views` int(11) DEFAULT 0,
  `unique_visitors` int(11) DEFAULT 0,
  `listing_views` int(11) DEFAULT 0,
  `inquiries` int(11) DEFAULT 0,
  `orders` int(11) DEFAULT 0,
  `revenue` decimal(15,2) DEFAULT 0.00,
  `conversion_rate` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `store_followers`
--

CREATE TABLE `store_followers` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `store_reviews`
--

CREATE TABLE `store_reviews` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_text` text DEFAULT NULL,
  `response_text` text DEFAULT NULL,
  `response_date` timestamp NULL DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 1,
  `helpful_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `store_reviews`
--

INSERT INTO `store_reviews` (`id`, `store_id`, `reviewer_id`, `order_id`, `rating`, `review_text`, `response_text`, `response_date`, `is_approved`, `helpful_count`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 5, 'Excellent store! Highly recommended.', NULL, NULL, 1, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15'),
(2, 1, 1, NULL, 4, 'Good products and fast delivery.', NULL, NULL, 1, 0, '2026-07-31 08:44:15', '2026-07-31 08:44:15');

-- --------------------------------------------------------

--
-- Table structure for table `store_settings`
--

CREATE TABLE `store_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_name` varchar(100) NOT NULL,
  `store_slogan` varchar(255) DEFAULT NULL,
  `store_description` text DEFAULT NULL,
  `store_logo` varchar(255) DEFAULT NULL,
  `store_banner` varchar(255) DEFAULT NULL,
  `store_color_primary` varchar(7) DEFAULT '#ff7b00',
  `store_color_secondary` varchar(7) DEFAULT '#2c3e50',
  `store_layout` varchar(20) DEFAULT 'grid',
  `products_per_page` int(11) DEFAULT 12,
  `enable_reviews` tinyint(1) DEFAULT 1,
  `enable_ratings` tinyint(1) DEFAULT 1,
  `enable_contact_form` tinyint(1) DEFAULT 1,
  `enable_social_links` tinyint(1) DEFAULT 1,
  `facebook_url` varchar(255) DEFAULT NULL,
  `twitter_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `youtube_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `whatsapp_number` varchar(20) DEFAULT NULL,
  `opening_hours` text DEFAULT NULL,
  `shipping_policy` text DEFAULT NULL,
  `return_policy` text DEFAULT NULL,
  `payment_info` text DEFAULT NULL,
  `custom_css` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `store_settings`
--

INSERT INTO `store_settings` (`id`, `user_id`, `store_name`, `store_slogan`, `store_description`, `store_logo`, `store_banner`, `store_color_primary`, `store_color_secondary`, `store_layout`, `products_per_page`, `enable_reviews`, `enable_ratings`, `enable_contact_form`, `enable_social_links`, `facebook_url`, `twitter_url`, `instagram_url`, `youtube_url`, `linkedin_url`, `whatsapp_number`, `opening_hours`, `shipping_policy`, `return_policy`, `payment_info`, `custom_css`, `is_active`, `created_at`, `updated_at`) VALUES
(21, 23, 'Collins Stores', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:07:26', '2026-08-07 12:07:26'),
(22, 24, 'Mira Stores', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:19:56', '2026-08-07 12:19:56'),
(23, 25, 'Succy Stores', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:22:01', '2026-08-07 12:22:01'),
(24, 26, '', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:25:51', '2026-08-07 12:25:51'),
(25, 27, '', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:42:21', '2026-08-07 12:42:21'),
(26, 28, '', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:43:20', '2026-08-07 12:43:20'),
(27, 29, '', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:44:51', '2026-08-07 12:44:51'),
(28, 30, '', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:45:29', '2026-08-07 12:45:29'),
(29, 31, 'Solex Ventures', 'Quality products at great prices', 'Welcome to my store! Quality products and services.', NULL, NULL, '#ff7b00', '#2c3e50', 'grid', 12, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2026-08-07 12:47:26', '2026-08-07 12:47:26');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `author` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `position` varchar(100) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `status` enum('pending','approved') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `role` enum('admin','user','agent','employer','vendor','buyer','landlord','tenant') DEFAULT 'user',
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `is_vendor` tinyint(1) DEFAULT 0,
  `is_admin` tinyint(1) DEFAULT 0,
  `store_name` varchar(100) DEFAULT NULL,
  `store_description` text DEFAULT NULL,
  `store_logo` varchar(255) DEFAULT NULL,
  `store_banner` varchar(255) DEFAULT NULL,
  `store_slogan` varchar(255) DEFAULT NULL,
  `store_verified` tinyint(1) DEFAULT 0,
  `landlord_verified` tinyint(1) DEFAULT 0,
  `store_rating` decimal(2,1) DEFAULT 0.0,
  `total_sales` int(11) DEFAULT 0,
  `total_products` int(11) DEFAULT 0,
  `store_views` int(11) DEFAULT 0,
  `store_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `store_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `phone`, `avatar_url`, `role`, `status`, `address`, `city`, `state`, `zip_code`, `profile_image`, `is_vendor`, `is_admin`, `store_name`, `store_description`, `store_logo`, `store_banner`, `store_slogan`, `store_verified`, `landlord_verified`, `store_rating`, `total_sales`, `total_products`, `store_views`, `store_created_at`, `store_updated_at`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@ebonyimarkethub.com', '$2y$10$vmaCzTFhYt/3qFs9cs8xGeknXaayATj5JKqEhRKvjcg7Vw1GsnJJO', 'System', 'Administrator', NULL, NULL, 'admin', 'active', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, NULL, NULL, NULL, 1, 0, '0.0', 0, 0, 0, '2026-07-31 08:44:15', '2026-08-04 16:18:01', '2026-07-31 08:44:15', '2026-08-04 16:18:01'),
(23, 'Collins', 'okeyechigozie30@gmail.com', '$2y$10$Q0OmH/W41tUXjftD/JTwA.ZSc2Ss9M.8igBaCIEXOO4F5SSnQ7ePe', 'Chigozie', 'Okeye', '08130413479', 'uploads/avatars/avatar_23_1786104846.jpg', 'vendor', 'active', NULL, NULL, NULL, NULL, NULL, 1, 0, 'Collins Stores', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 1, 0, '0.0', 0, 0, 0, '2026-08-07 12:07:25', '2026-08-07 12:14:07', '2026-08-07 12:07:25', '2026-08-07 12:14:07'),
(24, 'Mira', 'okeyechigozie3@gmail.com', '$2y$10$RNLyybRa9NvLY1Wskl3UPubPrzc2XKIgpUlu/n1cTGTds8GRGiwbC', 'Chigozie', 'Miracle', '08130413479', 'uploads/avatars/avatar_24_1787153622.jpg', 'vendor', 'active', NULL, NULL, NULL, NULL, NULL, 1, 0, 'Mira Stores', 'We sell all type of items', NULL, NULL, 'Best selling', 1, 0, '0.0', 0, 0, 0, '2026-08-07 12:19:56', '2026-08-19 15:33:42', '2026-08-07 12:19:56', '2026-08-19 15:33:42'),
(25, 'Succy', 'okeyechigozie32@gmail.com', '$2y$10$AhArzkVxijTfO3KkavVgce4hHxUfnk4gOSJ16eVhi1Hfbp6clgloS', 'Chigozie', 'Success', '08130413479', 'uploads/avatars/avatar_25_1786108805.jpg', 'vendor', 'active', NULL, NULL, NULL, NULL, NULL, 1, 0, 'Succy Stores', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 1, 0, '0.0', 0, 0, 0, '2026-08-07 12:22:01', '2026-08-07 16:13:26', '2026-08-07 12:22:01', '2026-08-07 16:13:26'),
(26, 'Emmy', 'okeyechigozie33@gmail.com', '$2y$10$dwkRq8kRuCY5Af24cwutIuGLDmUfXBA7GQWWaIJyQu.kfFcGat5lW', 'Emmy', 'John', '08130413479', 'uploads/avatars/avatar_26_1786109100.jpg', 'buyer', 'active', NULL, NULL, NULL, NULL, NULL, 0, 0, '', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 0, 0, '0.0', 0, 0, 0, '2026-08-07 12:25:51', '2026-08-07 13:25:00', '2026-08-07 12:25:51', '2026-08-07 13:25:00'),
(27, 'Bless', 'okeyechigozie34@gmail.com', '$2y$10$ulDBTTS3tEsbcJYbwmamzeFXqeMKLAIL3HchUB6qRdmCh6gHvJTHK', 'Chigozie', 'Blessing', '08130413479', 'uploads/avatars/avatar_27_1786109137.jpg', 'landlord', 'active', NULL, NULL, NULL, NULL, NULL, 0, 0, '', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 1, 0, '0.0', 0, 0, 0, '2026-08-07 12:42:21', '2026-08-07 16:13:22', '2026-08-07 12:42:21', '2026-08-07 16:13:22'),
(28, 'Fri', 'okeyechigozie35@gmail.com', '$2y$10$vTqtih6Edj20SpZfI3fvZOC6eopStqVHF3/mP20JR/2ZiJoVx0yea', 'Friday', 'Igwe', '08130413479', NULL, 'tenant', 'active', NULL, NULL, NULL, NULL, NULL, 0, 0, '', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 0, 0, '0.0', 0, 0, 0, '2026-08-07 12:43:20', '2026-08-07 12:43:20', '2026-08-07 12:43:20', '2026-08-07 12:43:20'),
(29, 'Gr8Collins', 'okeyechigozie36@gmail.com', '$2y$10$cIhXXLtLxXD7lKkMgXrG..RT5HR3R/.F9PLwDpLn2DwFbjy2vN3eC', 'Chigozie', 'Okeye', '08130413479', NULL, 'landlord', 'active', NULL, NULL, NULL, NULL, NULL, 0, 0, '', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 1, 0, '0.0', 0, 0, 0, '2026-08-07 12:44:51', '2026-08-07 16:13:19', '2026-08-07 12:44:51', '2026-08-07 16:13:19'),
(30, 'Xrex', 'okeyechigozie37@gmail.com', '$2y$10$Vw1ABJkLG/Y87fuc6XUcLe/KtjkH8pX7v.xjl61on5VRO8PjjGNEm', 'Xty', 'Rex', '09130413479', 'uploads/avatars/avatar_30_1786130722.jpg', 'buyer', 'active', NULL, NULL, NULL, NULL, NULL, 0, 0, '', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 0, 0, '0.0', 0, 0, 0, '2026-08-07 12:45:29', '2026-08-07 19:25:22', '2026-08-07 12:45:29', '2026-08-07 19:25:22'),
(31, 'Solex', 'okeyechigozie38@gmail.com', '$2y$10$ZtAbX1p.wDE.2/UNN6QAAOr6rAnb9skdAVbpqS6fX7xD6b/NENZDm', 'Solomon', 'Vicky', '08130413479', 'uploads/avatars/avatar_31_1786108535.jpg', 'vendor', 'active', NULL, NULL, NULL, NULL, NULL, 1, 0, 'Solex Ventures', 'Welcome to my store! Quality products and services.', NULL, NULL, NULL, 1, 0, '0.0', 0, 0, 0, '2026-08-07 12:47:26', '2026-10-21 16:12:22', '2026-08-07 12:47:26', '2026-10-21 16:12:22');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_cart_item` (`user_id`,`listing_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_listing` (`listing_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_parent` (`parent_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_code` (`code`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_favorite` (`user_id`,`listing_id`),
  ADD KEY `listing_id` (`listing_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `listings`
--
ALTER TABLE `listings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_price` (`price`),
  ADD KEY `idx_location` (`location`),
  ADD KEY `idx_featured` (`is_featured`);

--
-- Indexes for table `listing_images`
--
ALTER TABLE `listing_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_listing` (`listing_id`),
  ADD KEY `idx_primary` (`is_primary`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sender` (`sender_id`),
  ADD KEY `idx_receiver` (`receiver_id`),
  ADD KEY `idx_listing` (`listing_id`);

--
-- Indexes for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_read` (`is_read`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_store` (`store_id`),
  ADD KEY `idx_order_number` (`order_number`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order` (`order_id`),
  ADD KEY `idx_listing` (`listing_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `idx_category` (`category_id`),
  ADD KEY `idx_vendor` (`vendor_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product` (`product_id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product` (`product_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `product_submissions`
--
ALTER TABLE `product_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `property_inquiries`
--
ALTER TABLE `property_inquiries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_key` (`setting_key`);

--
-- Indexes for table `store_analytics`
--
ALTER TABLE `store_analytics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_store_date` (`store_id`,`date`),
  ADD KEY `idx_store` (`store_id`),
  ADD KEY `idx_date` (`date`);

--
-- Indexes for table `store_followers`
--
ALTER TABLE `store_followers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_follow` (`store_id`,`follower_id`),
  ADD KEY `idx_store` (`store_id`),
  ADD KEY `idx_follower` (`follower_id`);

--
-- Indexes for table `store_reviews`
--
ALTER TABLE `store_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_store` (`store_id`),
  ADD KEY `idx_reviewer` (`reviewer_id`),
  ADD KEY `idx_rating` (`rating`),
  ADD KEY `idx_approved` (`is_approved`);

--
-- Indexes for table `store_settings`
--
ALTER TABLE `store_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_store` (`user_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_is_vendor` (`is_vendor`),
  ADD KEY `idx_store_verified` (`store_verified`),
  ADD KEY `idx_landlord_verified` (`landlord_verified`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listings`
--
ALTER TABLE `listings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `listing_images`
--
ALTER TABLE `listing_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `newsletter_subscribers`
--
ALTER TABLE `newsletter_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_submissions`
--
ALTER TABLE `product_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_inquiries`
--
ALTER TABLE `property_inquiries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `store_analytics`
--
ALTER TABLE `store_analytics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_followers`
--
ALTER TABLE `store_followers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_reviews`
--
ALTER TABLE `store_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `store_settings`
--
ALTER TABLE `store_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD CONSTRAINT `job_applications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `listings`
--
ALTER TABLE `listings`
  ADD CONSTRAINT `listings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `listings_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `listing_images`
--
ALTER TABLE `listing_images`
  ADD CONSTRAINT `listing_images_ibfk_1` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_submissions`
--
ALTER TABLE `product_submissions`
  ADD CONSTRAINT `product_submissions_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `property_inquiries`
--
ALTER TABLE `property_inquiries`
  ADD CONSTRAINT `property_inquiries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `store_analytics`
--
ALTER TABLE `store_analytics`
  ADD CONSTRAINT `store_analytics_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `store_followers`
--
ALTER TABLE `store_followers`
  ADD CONSTRAINT `store_followers_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `store_followers_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `store_reviews`
--
ALTER TABLE `store_reviews`
  ADD CONSTRAINT `store_reviews_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `store_reviews_ibfk_2` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `store_settings`
--
ALTER TABLE `store_settings`
  ADD CONSTRAINT `store_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
