DROP DATABASE IF EXISTS DiningServices;
CREATE DATABASE DiningServices;
USE DiningServices;

/* Schema */

CREATE TABLE `User` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `lastName` VARCHAR(35) DEFAULT NULL,
   `firstName` VARCHAR(35) DEFAULT NULL,
   `middleName` VARCHAR(35) DEFAULT NULL,
   `fbId` INT(11) NOT NULL,
   `gender` CHAR(1) NOT NULL,
   `password` VARCHAR(255) NOT NULL,
   `firstSignIn` DATE,
   `email` VARCHAR(70) DEFAULT NULL,
   `role` TINYINT(1) NOT NULL,
   /*`image`*/
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
   `sponsor` TINYINT(1),
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
   `score` TINYINT(11),
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

INSERT INTO Dish VALUES
  (1, 1, 1, 'Salmon', 5.50),
  (2, 2, 1, 'Veggie Burger', 3.30),
  (3, 1, 3, 'Vanilla Shake', 2.55);


INSERT INTO `OperationHours` VALUES
	(1,'Monday', 'Breakfast', '7:30', '9:30', 1),
	(2,'Monday', 'Breakfast', '7:30', '9:30', 3),
	(3,'Monday', 'Breakfast', '7:30', '9:30', 4),
	(4,'Monday', 'Lunch', '11:30', '13:30', 1),
	(5,'Monday', 'Lunch', '11:30', '13:30', 3),
	(6,'Monday', 'Lunch', '11:30', '13:30', 4),
	(7,'Monday', 'Dinner', '17:30', '19:30', 1),
	(8,'Monday', 'Dinner', '18:30', '9:00', 2),
	(9,'Monday', 'Dinner', '19:30', '23:59', 3),
	(10,'Monday', 'Dinner', '19:30', '23:30', 4),
	(11,'Tuesday', 'Breakfast', '7:30', '9:30', 1),
	(12,'Tuesday', 'Breakfast', '7:30', '9:30', 3),
	(13,'Tuesday', 'Breakfast', '7:30', '9:30', 4),
	(14,'Tuesday', 'Lunch', '11:30', '13:30', 1),
	(15,'Tuesday', 'Lunch', '11:30', '13:30', 3),
	(16,'Tuesday', 'Lunch', '11:30', '13:30', 4),
	(17,'Tuesday', 'Dinner', '17:30', '19:30', 1),
	(18,'Tuesday', 'Dinner', '18:30', '9:00', 2),
	(19,'Tuesday', 'Dinner', '19:30', '23:59', 3),
	(20,'Tuesday', 'Dinner', '19:30', '23:30', 4),
	(21,'Wednesday', 'Breakfast', '7:30', '9:30', 1),
	(22,'Wednesday', 'Breakfast', '7:30', '9:30', 3),
	(23,'Wednesday', 'Breakfast', '7:30', '9:30', 4),
	(24,'Wednesday', 'Lunch', '11:30', '13:30', 1),
	(25,'Wednesday', 'Lunch', '11:30', '13:30', 3),
	(26,'Wednesday', 'Lunch', '11:30', '13:30', 4),
	(27,'Wednesday', 'Dinner', '17:30', '19:30', 1),
	(28,'Wednesday', 'Dinner', '18:30', '9:00', 2),
	(29,'Wednesday', 'Dinner', '19:30', '23:59', 3),
	(30,'Wednesday', 'Dinner', '19:30', '23:30', 4),
	(31,'Thursday', 'Breakfast', '7:30', '9:30', 1),
	(32,'Thursday', 'Breakfast', '7:30', '9:30', 3),
	(33,'Thursday', 'Breakfast', '7:30', '9:30', 4),
	(34,'Thursday', 'Lunch', '11:30', '13:30', 1),
	(35,'Thursday', 'Lunch', '11:30', '13:30', 3),
	(36,'Thursday', 'Lunch', '11:30', '13:30', 4),
	(37,'Thursday', 'Dinner', '17:30', '19:30', 1),
	(38,'Thursday', 'Dinner', '18:30', '9:00', 2),
	(39,'Thursday', 'Dinner', '19:30', '23:59', 3),
	(40,'Thursday', 'Dinner', '19:30', '23:30', 4),
	(41,'Friday', 'Breakfast', '7:30', '9:30', 1),
	(42,'Friday', 'Breakfast', '7:30', '9:30', 3),
	(43,'Friday', 'Breakfast', '7:30', '9:30', 4),
	(44,'Friday', 'Lunch', '11:30', '13:30', 1),
	(45,'Friday', 'Lunch', '11:30', '13:30', 3),
	(46,'Friday', 'Lunch', '11:30', '13:30', 4),
	(47,'Friday', 'Dinner', '17:30', '19:30', 1),
	(48,'Friday', 'Dinner', '18:30', '9:00', 2),
	(49,'Friday', 'Dinner', '19:30', '23:59', 3),
	(50,'Friday', 'Dinner', '19:30', '23:30', 4),
	(51,'Friday', 'Breakfast', '7:30', '9:30', 1),
	(52,'Saturday', 'Breakfast', '7:30', '9:30', 3),
	(53,'Saturday', 'Breakfast', '7:30', '9:30', 4),
	(54,'Saturday', 'Lunch', '11:30', '13:30', 1),
	(55,'Saturday', 'Lunch', '11:30', '13:30', 3),
	(56,'Saturday', 'Lunch', '11:30', '13:30', 4),
	(57,'Saturday', 'Dinner', '17:30', '19:30', 1),
	(58,'Saturday', 'Dinner', '18:30', '9:00', 2),
	(59,'Saturday', 'Dinner', '19:30', '23:59', 3),
	(60,'Saturday', 'Dinner', '19:30', '23:30', 4),
	(61,'Sunday', 'Breakfast', '7:30', '9:30', 1),
	(62,'Sunday', 'Breakfast', '7:30', '9:30', 3),
	(63,'Sunday', 'Breakfast', '7:30', '9:30', 4),
	(64,'Sunday', 'Lunch', '11:30', '13:30', 1),
	(65,'Sunday', 'Lunch', '11:30', '13:30', 3),
	(66,'Sunday', 'Lunch', '11:30', '13:30', 4),
	(67,'Sunday', 'Dinner', '17:30', '19:30', 1),
	(68,'Sunday', 'Dinner', '18:30', '9:00', 2),
	(69,'Sunday', 'Dinner', '19:30', '23:59', 3),
	(70,'Sunday', 'Dinner', '19:30', '23:30', 4);

