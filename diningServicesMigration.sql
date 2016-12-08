/*
Migration script for DiningServices Database
*/
CREATE TABLE `Follower` (
   `followerId` INT NOT NULL,
   `followingId` INT NOT NULL,
   UNIQUE KEY (`followerId`, `followingId`),
   CONSTRAINT `FKFollower_followerId` FOREIGN KEY (`followerId`)
      REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKFollower_followingId` FOREIGN KEY (`followingId`)
      REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `OverallRating` (
   `userId` INT NOT NULL,
   `menuId` INT NOT NULL,
   `serviceScore` TINYINT NOT NULL,
   `foodScore` TINYINT NOT NULL,
   `cleanlinessScore` TINYINT NOT NULL,
   `comment` VARCHAR(255),
   UNIQUE KEY (`userId`, `menuId`),
   CONSTRAINT `FKOverallRating_userId` FOREIGN KEY (`userId`)
      REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKOverallRating_menuId` FOREIGN KEY (`menuId`)
      REFERENCES `Menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `TimeType` (
   `id` INT NOT NULL,
   `name` VARCHAR(15) NOT NULL,
   PRIMARY KEY (`id`)
 );

 CREATE TABLE `MealTimeNotification` (
   `userId` INT NOT NULL,
   `OperationHourId` INT NOT NULL,
   `timeTypeId` INT NOT NULL,
   CONSTRAINT `FKMealTimeNotification_userId` FOREIGN KEY (`userId`)
      REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
   CONSTRAINT `FKMealTimeNotification_OperationHourId` FOREIGN KEY (`OperationHourId`)
         REFERENCES `OperationHours` (`id`),
   CONSTRAINT `FKMealTimeNotification_timeTypeId` FOREIGN KEY (`timeTypeId`)
      REFERENCES `TimeType` (`id`)
);

CREATE TABLE `DishNotification` (
  `userId` INT NOT NULL,
  `dishId` INT NOT NULL,
  CONSTRAINT `FKDishNotification_userId` FOREIGN KEY (`userId`)
        REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKDishNotification_dishId` FOREIGN KEY (`dishId`)
     REFERENCES `Dish` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE User
ADD COLUMN sponsorNotification TINYINT,
MODIFY lastName VARCHAR(35) NOT NULL,
MODIFY firstName VARCHAR(35) NOT NULL,
MODIFY firstSignIn DATE NOT NULL,
MODIFY email VARCHAR(70) NOT NULL;

ALTER TABLE Location
MODIFY name VARCHAR(30) NOT NULL;


ALTER TABLE OperationHours
DROP FOREIGN KEY `FKOperationHours_institutionId`;

ALTER TABLE OperationHours
MODIFY timeOpens TIME NOT NULL,
MODIFY timecloses TIME NOT NULL,
MODIFY institutionId INT NOT NULL;

ALTER TABLE OperationHours
ADD CONSTRAINT `FKOperationHours_institutionId` FOREIGN KEY (`institutionId`)
   REFERENCES `Institution` (`id`);

ALTER TABLE CheckIn
DROP FOREIGN KEY `FKCheckIn_locationId`;

ALTER TABLE CheckIn
MODIFY locationId INT NOT NULL;

ALTER TABLE CheckIn
ADD CONSTRAINT `FKCheckIn_locationId` FOREIGN KEY (locationId)
   REFERENCES Location (id) ON DELETE CASCADE ON UPDATE CASCADE,
DROP FOREIGN KEY `FKCheckIn_userId`;

ALTER TABLE CheckIn
MODIFY userId INT NOT NULL;

ALTER TABLE CheckIn
ADD CONSTRAINT `FKCheckIn_userId` FOREIGN KEY (userId)
   REFERENCES User (id) ON DELETE CASCADE ON UPDATE CASCADE,
MODIFY sponsor TINYINT NOT NULL,
MODIFY `date` DATETIME NOT NULL;

ALTER TABLE Dish
DROP FOREIGN KEY `FKDish_FoodType`,
DROP FOREIGN KEY `FKDish_Institution`;

ALTER TABLE Dish
MODIFY foodTypeId INT NOT NULL,
MODIFY institutionId INT NOT NULL,
MODIFY price DECIMAL(6,2) NOT NULL;

ALTER TABLE Dish
ADD CONSTRAINT `FKDish_FoodType` FOREIGN KEY (`foodTypeId`)
REFERENCES `FoodType` (`id`),
ADD CONSTRAINT `FKDish_Institution` FOREIGN KEY (`institutionId`)
REFERENCES `Institution` (`id`);

ALTER TABLE Menu
MODIFY `date` DATE NOT NULL;

RENAME TABLE Rating TO DishRating;

ALTER TABLE DishRating
DROP FOREIGN KEY `FKRating_dishId`,
DROP FOREIGN KEY `FKRating_userId`;

ALTER TABLE DishRating
MODIFY userId INT NOT NULL,
MODIFY dishId INT NOT NULL,
MODIFY score TINYINT NOT NULL,
MODIFY `date` DATE NOT NULL;

ALTER TABLE DishRating
ADD CONSTRAINT `FKDishRating_dishId` FOREIGN KEY (`dishId`)
REFERENCES `Dish` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FKDishRating_userId` FOREIGN KEY (`userId`)
   REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO `TimeType` VALUES
   (1,'open'),
   (2,'close'),
   (3,'both');

ALTER TABLE DishRating ADD id INT PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE User ADD CONSTRAINT UNIQUE (email);
