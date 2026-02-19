-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Feb 19. 09:40
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `webshop`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','shipped','completed','cancelled') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `main_image` varchar(255) DEFAULT NULL,
  `sizes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category`, `main_image`, `sizes`) VALUES
(1, 'Nike Air Force 1 07 Triple White', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 40000.00, 15, 'Sneakerek', '/img/termek1.webp', '40, 41, 42'),
(2, 'Nike Air Force 1 Black Chunky Rope Laces Beige', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 45000.00, 15, 'Sneakerek', '/img/termek2.webp', '40, 41, 42'),
(3, 'NIKE AIR FORCE 1 LOW 07 BLACK WHITE ROPE LACES', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 45000.00, 15, 'Sneakerek', '/img/termek3.webp', '40, 41, 42'),
(4, 'NIKE AIR FORCE 1 LOW 07 WHITE Rose Rope Laces', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 50000.00, 15, 'Sneakerek', '/img/termek4.webp', '40, 41, 42'),
(5, 'Nike Air Force 1 Low Supreme White', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 55000.00, 15, 'Sneakerek', '/img/termek5.webp', '40, 41, 42'),
(6, 'Nike Air Force 1 Low Supreme Black', 'A Nike Air Force 1 Low Supreme Black egy ikonikus sneaker a mindennapokra. Az egyszerű fekete borítású megjelenést egy élénk piros Supreme felirat teszi különlegessé...', 55000.00, 15, 'Sneakerek', '/img/termek6.webp', '40, 41, 42'),
(7, 'Nike Air Force 1 Mid Supreme White', 'A Supreme visszavesz az agresszív márkajelzésből, és helyette egy egyszerű és finom dizájnt választ, az ikonikus piros Box Logót a fehér-fehér Air Force 1 Mid sarkán...', 60000.00, 15, 'Sneakerek', '/img/termek7.webp', '40, 41, 42'),
(8, 'Nike Air Force 1 Low Off-White MCA University Blue', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 410000.00, 15, 'Sneakerek', '/img/termek8.webp', '40, 41, 42'),
(9, 'Air Jordan 1 Retro High Og Chicago Lost And Found', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 80000.00, 15, 'Sneakerek', '/img/termek9.webp', '40, 41, 42'),
(10, 'Air Jordan 1 Retro Low OG SP Travis Scott Canary', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 120000.00, 15, 'Sneakerek', '/img/termek10.webp', '40, 41, 42'),
(11, 'Air Jordan 1 Retro High Dior', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 1200000.00, 15, 'Sneakerek', '/img/termek11.webp', '40, 41, 42'),
(12, 'Nike Air Jordan 1 Retro High Mocha', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 180000.00, 15, 'Sneakerek', '/img/termek12.webp', '40, 41, 42'),
(13, 'Air Jordan 1 Retro High OG Bred Patent', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 80000.00, 15, 'Sneakerek', '/img/termek13.webp', '40, 41, 42'),
(14, 'Air Jordan 1 Retro High White University Blue Black', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 130000.00, 15, 'Sneakerek', '/img/termek14.webp', '40, 41, 42'),
(15, 'Air Jordan 1 Retro High OG NRG Not For Resale', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 280000.00, 15, 'Sneakerek', '/img/termek15.webp', '40, 41, 42'),
(16, 'Adidas Campus 00s Core Black', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 30000.00, 15, 'Sneakerek', '/img/termek16.webp', '40, 41, 42'),
(17, 'Adidas Campus 00s Crystal White Core Black', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 30000.00, 15, 'Sneakerek', '/img/termek17.webp', '40, 41, 42'),
(18, 'Adidas Campus 00s Better Scarlet Cloud White', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 30000.00, 15, 'Sneakerek', '/img/termek18.webp', '40, 41, 42'),
(19, 'UGG Tazz Slipper Sand', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 40000.00, 15, 'Sneakerek', '/img/termek19.webp', '40, 41, 42'),
(31, 'S Logo Zip Up Hooded Sweatshirt', 'A Nike Air Force 1 07 Triple White sneaker egy igazán egyszerű, de sikkes darab...', 70000.00, 15, 'Ruházat', '/img/termek31.webp', 'S, M, L');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','admin') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Megkötések a táblához `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Megkötések a táblához `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
