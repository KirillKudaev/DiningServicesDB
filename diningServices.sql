DROP DATABASE IF EXISTS DiningServices;
CREATE DATABASE DiningServices;
USE DiningServices;

/* Schema */

CREATE TABLE `User` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `lastName` VARCHAR(35) DEFAULT NULL,
   `firstName` VARCHAR(35) DEFAULT NULL,
   `middleName` VARCHAR(35) DEFAULT NULL,
   `fbId` INT(11) DEFAULT NULL,
   `gender` CHAR(1) DEFAULT NULL,
   `password` VARCHAR(255) NOT NULL,
   `firstSignIn` DATE,
   `email` VARCHAR(70) DEFAULT NULL,
   `role` TINYINT NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Location` (
   `id` INT(11) NOT NULL,
   `name` VARCHAR(15),
   PRIMARY KEY (`id`)
 );

 CREATE TABLE `Institution` (
    `id` INT(11) NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`id`)
 );

 CREATE TABLE `OperationHours` (
   `id` INT(11) NOT NULL,
   `dayOfWeek` ENUM('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
   `name` ENUM('Breakfast','Lunch','Dinner') NOT NULL,
   `timeOpens` TIME,
   `timeCloses` TIME,
   `institutionId` INT(11),
   CONSTRAINT `FKOperationHours_institutionId` FOREIGN KEY (`institutionId`)
      REFERENCES `Institution` (`id`),
   PRIMARY KEY (`id`)
);

CREATE TABLE `CheckIn` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `locationId` INT(11),
   `userId` INT(11),
   `comment` VARCHAR(255) DEFAULT NULL,
   `sponsor` TINYINT,
   `date` DATE,
   PRIMARY KEY (`id`),
   CONSTRAINT `FKCheckIn_userId` FOREIGN KEY (`userId`)
      REFERENCES `User` (`id`),
   CONSTRAINT `FKCheckIn_locationId` FOREIGN KEY (`locationId`)
      REFERENCES `Location` (`id`)
);

CREATE TABLE `FoodType` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `type` VARCHAR(20) NOT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Dish` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `foodTypeId` INT(11),
   `institutionId` INT(11),
   `name` VARCHAR(50) NOT NULL,
   `price` DECIMAL(6,2),
   PRIMARY KEY (`id`),
   CONSTRAINT `FKDish_Institution` FOREIGN KEY (`institutionId`)
      REFERENCES `Institution` (`id`),
   CONSTRAINT `FKDish_FoodType` FOREIGN KEY (`foodTypeId`)
      REFERENCES `FoodType` (`id`)
);

CREATE TABLE `Menu` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `operationHoursId` INT(11) NOT NULL,
   `date` DATE,
	PRIMARY KEY (`id`),
   CONSTRAINT `FKMenu_operationHoursId` FOREIGN KEY (`operationHoursId`)
      REFERENCES `OperationHours` (`id`)
);


CREATE TABLE `DishXMenu` (
	`dishId` INT(11) NOT NULL,
	`menuId` INT(11) NOT NULL,
   CONSTRAINT `DishXMenu_dishId` FOREIGN KEY (`dishId`)
      REFERENCES `Dish` (`id`),
   CONSTRAINT `DishXMenu_menuId` FOREIGN KEY (`menuId`)
      REFERENCES `Menu` (`id`)
);

CREATE TABLE `Rating` (
   `userId` INT(11),
   `dishId` INT(11),
   `score` TINYINT,
   `comment` VARCHAR(255) DEFAULT NULL,
   `date` DATE,
   CONSTRAINT `FKRating_userId` FOREIGN KEY (`userId`)
      REFERENCES `User` (`id`),
   CONSTRAINT `FKRating_dishId` FOREIGN KEY (`dishId`)
      REFERENCES `Dish` (`id`)
);

INSERT INTO Location VALUES
   (1, 'Pub'),
   (2, 'Dining Room');

INSERT INTO User VALUES
   (1, 'Goodsell', 'Gavin', 'James', 12345, 'M', 'password', '2016-11-01', 'ggoodsell694@gmail.com', 1),
   (2, 'Kudaev', 'Kirill', '', 23456, 'M', 'password', '2016-11-01', 'kirill.Kudaev@principia.com', 1);


INSERT INTO FoodType VALUES
  (1, 'Omnivore'),
  (2, 'Vegetarian'),
  (3, 'Vegan');


INSERT INTO `Institution` VALUES
   (1,'Dining Room'),
   (2,'Dining Grill'),
   (3,'Pub'),
   (4,'Pub Grill');

INSERT INTO `OperationHours` VALUES
	(1,'Monday', 'Breakfast', '7:30', '9:30', 1),
	(2,'Monday', 'Breakfast', '7:30', '9:30', 2),
	(3,'Monday', 'Breakfast', '7:30', '9:30', 3),
	(4,'Monday', 'Breakfast', '7:30', '9:30', 4),
	(5,'Monday', 'Lunch', '11:30', '13:30', 1),
	(6,'Monday', 'Lunch', '11:30', '13:30', 2),
	(7,'Monday', 'Lunch', '11:30', '13:30', 3),
	(8,'Monday', 'Lunch', '11:30', '13:30', 4),
	(9,'Monday', 'Dinner', '17:30', '19:30', 1),
	(10,'Monday', 'Dinner', '18:30', '9:00', 2),
	(11,'Monday', 'Dinner', '19:30', '23:59', 3),
	(12,'Monday', 'Dinner', '19:30', '23:30', 4),
	(13,'Tuesday', 'Breakfast', '7:30', '9:30', 1),
	(14,'Tuesday', 'Breakfast', '7:30', '9:30', 2),
	(15,'Tuesday', 'Breakfast', '7:30', '9:30', 3),
	(16,'Tuesday', 'Breakfast', '7:30', '9:30', 4),
	(17,'Tuesday', 'Lunch', '11:30', '13:30', 1),
	(18,'Tuesday', 'Lunch', '11:30', '13:30', 2),
	(19,'Tuesday', 'Lunch', '11:30', '13:30', 3),
	(20,'Tuesday', 'Lunch', '11:30', '13:30', 4),
	(21,'Tuesday', 'Dinner', '17:30', '19:30', 1),
	(22,'Tuesday', 'Dinner', '18:30', '9:00', 2),
	(23,'Tuesday', 'Dinner', '19:30', '23:59', 3),
	(24,'Tuesday', 'Dinner', '19:30', '23:30', 4),
	(25,'Wednesday', 'Breakfast', '7:30', '9:30', 1),
	(26,'Wednesday', 'Breakfast', '7:30', '9:30', 2),
	(27,'Wednesday', 'Breakfast', '7:30', '9:30', 3),
	(28,'Wednesday', 'Breakfast', '7:30', '9:30', 4),
	(29,'Wednesday', 'Lunch', '11:30', '13:30', 1),
	(30,'Wednesday', 'Lunch', '11:30', '13:30', 2),
	(31,'Wednesday', 'Lunch', '11:30', '13:30', 3),
	(32,'Wednesday', 'Lunch', '11:30', '13:30', 4),
	(33,'Wednesday', 'Dinner', '17:30', '19:30', 1),
	(34,'Wednesday', 'Dinner', '18:30', '9:00', 2),
	(35,'Wednesday', 'Dinner', '19:30', '23:59', 3),
	(36,'Wednesday', 'Dinner', '19:30', '23:30', 4),
	(37,'Thursday', 'Breakfast', '7:30', '9:30', 1),
	(38,'Thursday', 'Breakfast', '7:30', '9:30', 2),
	(39,'Thursday', 'Breakfast', '7:30', '9:30', 3),
	(40,'Thursday', 'Breakfast', '7:30', '9:30', 4),
	(41,'Thursday', 'Lunch', '11:30', '13:30', 1),
	(42,'Thursday', 'Lunch', '11:30', '13:30', 2),
	(43,'Thursday', 'Lunch', '11:30', '13:30', 3),
	(44,'Thursday', 'Lunch', '11:30', '13:30', 4),
	(45,'Thursday', 'Dinner', '17:30', '19:30', 1),
	(46,'Thursday', 'Dinner', '18:30', '9:00', 2),
	(47,'Thursday', 'Dinner', '19:30', '23:59', 3),
	(48,'Thursday', 'Dinner', '19:30', '23:30', 4),
	(49,'Friday', 'Breakfast', '7:30', '9:30', 1),
	(50,'Friday', 'Breakfast', '7:30', '9:30', 2),
	(51,'Friday', 'Breakfast', '7:30', '9:30', 3),
	(52,'Friday', 'Breakfast', '7:30', '9:30', 4),
	(53,'Friday', 'Lunch', '11:30', '13:30', 1),
	(54,'Friday', 'Lunch', '11:30', '13:30', 2),
	(55,'Friday', 'Lunch', '11:30', '13:30', 3),
	(56,'Friday', 'Lunch', '11:30', '13:30', 4),
	(57,'Friday', 'Dinner', '17:30', '19:30', 1),
	(58,'Friday', 'Dinner', '18:30', '9:00', 2),
	(59,'Friday', 'Dinner', '19:30', '23:59', 3),
	(60,'Friday', 'Dinner', '19:30', '23:30', 4),
	(61,'Saturday', 'Breakfast', '7:30', '9:30', 1),
	(62,'Saturday', 'Breakfast', '7:30', '9:30', 2),
	(63,'Saturday', 'Breakfast', '7:30', '9:30', 3),
	(64,'Saturday', 'Breakfast', '7:30', '9:30', 4),
	(65,'Saturday', 'Lunch', '11:30', '13:30', 1),
	(66,'Saturday', 'Lunch', '11:30', '13:30', 2),
	(67,'Saturday', 'Lunch', '11:30', '13:30', 3),
	(68,'Saturday', 'Lunch', '11:30', '13:30', 4),
	(69,'Saturday', 'Dinner', '17:30', '19:30', 1),
	(70,'Saturday', 'Dinner', '18:30', '9:00', 2),
	(71,'Saturday', 'Dinner', '19:30', '23:59', 3),
	(72,'Saturday', 'Dinner', '19:30', '23:30', 4),
	(73,'Sunday', 'Breakfast', '7:30', '9:30', 1),
	(74,'Sunday', 'Breakfast', '7:30', '9:30', 2),
	(75,'Sunday', 'Breakfast', '7:30', '9:30', 3),
	(76,'Sunday', 'Breakfast', '7:30', '9:30', 4),
	(77,'Sunday', 'Lunch', '11:30', '13:30', 1),
	(78,'Sunday', 'Lunch', '11:30', '13:30', 2),
	(79,'Sunday', 'Lunch', '11:30', '13:30', 3),
	(80,'Sunday', 'Lunch', '11:30', '13:30', 4),
	(81,'Sunday', 'Dinner', '17:30', '19:30', 1),
	(82,'Sunday', 'Dinner', '18:30', '9:00', 2),
	(83,'Sunday', 'Dinner', '19:30', '23:59', 3),
	(84,'Sunday', 'Dinner', '19:30', '23:30', 4);
