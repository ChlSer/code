- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.5.11-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6376
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных pharm
CREATE DATABASE IF NOT EXISTS `pharm` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `pharm`;

-- Дамп структуры для таблица pharm.blacklist
CREATE TABLE IF NOT EXISTS `blacklist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_city` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_city` (`id_city`),
  KEY `id_order` (`id_order`),
  CONSTRAINT `FK_blacklist_city` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_blacklist_orders` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pharm.blacklist: ~2 rows (приблизительно)
INSERT IGNORE INTO `blacklist` (`id`, `id_city`, `id_order`) VALUES
	(1, 2, 6),
	(2, 1, 2),
	(4, 2, 5),
	(5, 1, 4);

-- Дамп структуры для таблица pharm.city
CREATE TABLE IF NOT EXISTS `city` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_region` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_region` (`id_region`),
  CONSTRAINT `FK_city_region` FOREIGN KEY (`id_region`) REFERENCES `region` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pharm.city: ~4 rows (приблизительно)
INSERT IGNORE INTO `city` (`id`, `id_region`, `name`) VALUES
	(1, 4, 'Орехово-Зуево'),
	(2, 1, 'Волгоград'),
	(3, 1, 'Волжский'),
	(4, 2, 'Светлогорск'),
	(5, 3, 'Саратов');

-- Дамп структуры для таблица pharm.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pharm.orders: ~6 rows (приблизительно)
INSERT IGNORE INTO `orders` (`id`, `name`) VALUES
	(1, 'Ранитидин'),
	(2, 'Фамотидин'),
	(3, 'Омепразол'),
	(4, 'Мебеверин'),
	(5, 'Метоклопрамид'),
	(6, 'Ондансетрон');

-- Дамп структуры для таблица pharm.pharmacy
CREATE TABLE IF NOT EXISTS `pharmacy` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_city` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_city` (`id_city`),
  CONSTRAINT `FK_pharmacy_city` FOREIGN KEY (`id_city`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pharm.pharmacy: ~8 rows (приблизительно)
INSERT IGNORE INTO `pharmacy` (`id`, `id_city`, `name`) VALUES
	(1, 2, 'Волгоградская аптека № 1'),
	(2, 2, 'Волгоградская аптека № 2'),
	(3, 3, 'Волжская аптека № 1'),
	(4, 3, 'Волжская аптека № 2'),
	(5, 1, 'Аптека № 1'),
	(6, 1, 'Аптека № 2'),
	(7, 4, 'Светлогорская Аптека № 1'),
	(8, 5, 'Саратовская Аптека № 2');

-- Дамп структуры для таблица pharm.pharm_store
CREATE TABLE IF NOT EXISTS `pharm_store` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pharmacy` int(10) unsigned NOT NULL,
  `id_order` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_order_in_pharm` (`id_pharmacy`,`id_order`),
  KEY `id_order` (`id_order`),
  KEY `id_pharm` (`id_pharmacy`) USING BTREE,
  CONSTRAINT `FK_pharm_store_orders` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pharm_store_pharmacy` FOREIGN KEY (`id_pharmacy`) REFERENCES `pharmacy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pharm.pharm_store: ~14 rows (приблизительно)
INSERT IGNORE INTO `pharm_store` (`id`, `id_pharmacy`, `id_order`, `count`) VALUES
	(1, 5, 4, 200),
	(2, 5, 5, 100),
	(3, 5, 3, 300),
	(4, 6, 1, 20),
	(5, 6, 2, 200),
	(6, 6, 6, 50),
	(7, 1, 1, 5),
	(8, 1, 3, 500),
	(9, 2, 4, 400),
	(10, 2, 6, 300),
	(11, 2, 5, 200),
	(12, 3, 1, 100),
	(13, 4, 5, 500),
	(14, 8, 4, 10),
	(15, 7, 6, 200),
	(16, 8, 5, 100);

-- Дамп структуры для таблица pharm.region
CREATE TABLE IF NOT EXISTS `region` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы pharm.region: ~4 rows (приблизительно)
INSERT IGNORE INTO `region` (`id`, `name`) VALUES
	(1, 'Волгоградская область'),
	(2, 'Красноярский край'),
	(3, 'Саратовская область'),
	(4, 'Московская область');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;




SELECT 
`region`.`name` AS `Регион`,
`city`.`name` AS `Город`,
`PHARM`.`name` AS `Аптека`,
(
	SELECT COUNT(`pharm_store`.`id_order`)
	FROM `pharm_store`, `pharmacy`
	WHERE `pharm_store`.`id_pharmacy` = `pharmacy`.`id` 
	AND `pharm_store`.`id_pharmacy` = `PHARM`.`id`
	AND `pharm_store`.`id_order` NOT IN (SELECT `blacklist`.`id_order` FROM `blacklist` WHERE `blacklist`.`id_city`=`pharmacy`.`id_city`)
) AS `Кол-во уникального товара. Запрещенка не учитывается`
FROM `region`,`city`,`pharmacy` AS `PHARM`
WHERE
`PHARM`.`id_city` = `city`.`id` AND 
`city`.`id_region` = `region`.`id`
