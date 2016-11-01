DROP DATABASE IF EXISTS DiningServices;
CREATE DATABASE DiningServices;
USE DiningServices;

/* Schema */

CREATE TABLE `User` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `lastName` VARCHAR(30) DEFAULT NULL,
   `firstName` VARCHAR(30) DEFAULT NULL,
   `middleName` VARCHAR(30) DEFAULT NULL,
   `fbId` INT(11) NOT NULL,
   `gender` CHAR(1) NOT NULL,
   `password` VARCHAR(30) NOT NULL,
   `firstSignIn` DATE,
   `email` VARCHAR(30) DEFAULT NULL,
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
   `institutionID` INT(11) NOT NULL,
   CONSTRAINT `FKOperationHours_institutionID` FOREIGN KEY (`institutionID`)
      REFERENCES `Institution` (`id`),
   PRIMARY KEY (`id`)
);

CREATE TABLE `CheckIn` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `locationId` INT(11),
   `userId` INT(11),
   `comment` VARCHAR(255) DEFAULT NULL,
   `date` DATE,
   PRIMARY KEY (`id`),
   CONSTRAINT `FKCheckIn_userId` FOREIGN KEY (`userId`)
      REFERENCES `User` (`id`),
   CONSTRAINT `FKCheckIn_locationId` FOREIGN KEY (`locationId`)
      REFERENCES `Location` (`id`)
);

CREATE TABLE `FoodType` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `type` VARCHAR(30) DEFAULT NULL,
   PRIMARY KEY (`id`)
);

CREATE TABLE `Dish` (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `foodTypeId` INT(11),
   `institutionId` INT(11),
   `name` VARCHAR(30) DEFAULT NULL,
   `price` DECIMAL(6,2),
   PRIMARY KEY (`id`),
   CONSTRAINT `FKDish_Institution` FOREIGN KEY (`institutionId`)
      REFERENCES `Institution` (`id`),
   CONSTRAINT `FKDish_FoodType` FOREIGN KEY (`foodTypeId`)
      REFERENCES `FoodType` (`id`)
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
  (2, 'Vegitarian'),
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
	(20,'Tuesday', 'Dinner', '19:30', '23:30', 4);
