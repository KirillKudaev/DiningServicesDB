/*
Migration script for DiningServices Database
*/
CREATE TABLE `Follower` (
   `followerId` INT NOT NULL,
   `followingId` INT NOT NULL,
   UNIQUE KEY (`followerId`, `followingId`),
   CONSTRAINT `FKFollower_followerId` FOREIGN KEY (`followerId`)
      REFERENCES `User` (`id`),
   CONSTRAINT `FKFollower_followingId` FOREIGN KEY (`followingId`)
      REFERENCES `User` (`id`)
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
      REFERENCES `User` (`id`),
   CONSTRAINT `FKFollower_menuId` FOREIGN KEY (`menuId`)
      REFERENCES `Menu` (`id`)
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
      REFERENCES `User` (`id`),
   CONSTRAINT `FKMealTimeNotification_OperationHourId` FOREIGN KEY (`OperationHourId`)
         REFERENCES `OperationHours` (`id`),
   CONSTRAINT `FKMealTimeNotification_timeTypeId` FOREIGN KEY (`timeTypeId`)
      REFERENCES `TimeType` (`id`)
);

CREATE TABLE `DishNotification` (
  `userId` INT NOT NULL,
  `dishId` INT NOT NULL,
  CONSTRAINT `FKDishNotification_userId` FOREIGN KEY (`userId`)
        REFERENCES `User` (`id`),
  CONSTRAINT `FKDishNotification_dishId` FOREIGN KEY (`dishId`)
     REFERENCES `Dish` (`id`)
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
MODIFY timeOpens TIME NOT NULL,
MODIFY timecloses TIME NOT NULL,
MODIFY institutionId INT NOT NULL;



ALTER TABLE CheckIn
DROP FOREIGN KEY `FKCheckIn_locationId`;

ALTER TABLE CheckIn
MODIFY locationId INT NOT NULL;

ALTER TABLE CheckIn
ADD CONSTRAINT `FKCheckIn_locationId` FOREIGN KEY (locationId)
   REFERENCES Location (id),
DROP FOREIGN KEY `FKCheckIn_userId`;

ALTER TABLE CheckIn
MODIFY userId INT NOT NULL;

ALTER TABLE CheckIn
ADD CONSTRAINT `FKCheckIn_userId` FOREIGN KEY (userId)
   REFERENCES User (id),
MODIFY sponsor TINYINT NOT NULL,
MODIFY `date` DATETIME NOT NULL;

ALTER TABLE Dish
MODIFY foodTypeId INT NOT NULL,
MODIFY institutionId INT NOT NULL,
MODIFY price DECIMAL(6,2) NOT NULL;

ALTER TABLE Menu
MODIFY `date` DATE NOT NULL;

RENAME TABLE Rating TO DishRating;
ALTER TABLE DishRating
MODIFY userId INT NOT NULL,
MODIFY dishId INT NOT NULL,
MODIFY score TINYINT NOT NULL,
MODIFY `date` DATE NOT NULL;

INSERT INTO `TimeType` VALUES
   (1,'open'),
   (2,'close'),
   (3,'both');
