ALTER TABLE `User`
ADD sponsorNotification TINYINT;

CREATE TABLE `TimeType` (
   `id` INT(11) NOT NULL,
   `name` VARCHAR(15) NOT NULL,
   PRIMARY KEY (`id`)
 );

 CREATE TABLE `MealTimeNotification` (
   `userId` INT(11) NOT NULL,
   `OperationHourId` INT(11) NOT NULL,
   `timeTypeId` INT(11) NOT NULL,
   CONSTRAINT `FKMealTimeNotification_userId` FOREIGN KEY (`userId`)
      REFERENCES `User` (`id`),
   CONSTRAINT `FKMealTimeNotification_OperationHourId` FOREIGN KEY (`OperationHourId`)
         REFERENCES `OperationHours` (`id`),
   CONSTRAINT `FKMealTimeNotification_timeTypeId` FOREIGN KEY (`timeTypeId`)
      REFERENCES `TimeType` (`id`)
);

CREATE TABLE `DishNotification` (
  `userId` INT(11) NOT NULL,
  `dishId` INT(11) NOT NULL,
  CONSTRAINT `FKDishNotification_userId` FOREIGN KEY (`userId`)
        REFERENCES `User` (`id`),
  CONSTRAINT `FKDishNotification_dishId` FOREIGN KEY (`dishId`)
     REFERENCES `Dish` (`id`)
);

 INSERT INTO `TimeType` VALUES
    (1,'open'),
    (2,'close'),
    (3,'both');
