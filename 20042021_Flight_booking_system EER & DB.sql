-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flight_booking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flight_booking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flight_booking` DEFAULT CHARACTER SET utf8 ;
USE `flight_booking` ;

-- -----------------------------------------------------
-- Table `flight_booking`.`passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`passenger` (
  `passenger_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`passenger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`flightClass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`flightClass` (
  `flight_class_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`flight_class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`ticket` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `passenger_id` INT NOT NULL,
  `flight_class_id` INT NOT NULL,
  `ticket_number` VARCHAR(50) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `confirmation_number` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_ticket_passenger1_idx` (`passenger_id` ASC) VISIBLE,
  INDEX `fk_ticket_flightClass1_idx` (`flight_class_id` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_passenger1`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `flight_booking`.`passenger` (`passenger_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_flightClass1`
    FOREIGN KEY (`flight_class_id`)
    REFERENCES `flight_booking`.`flightClass` (`flight_class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`flight` (
  `flight_id` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(50) NOT NULL,
  `departure_date_time` DATETIME NOT NULL,
  `arrival_date_time` DATETIME NOT NULL,
  `duration_in_minutes` INT NOT NULL,
  `distance_in_miles` INT NOT NULL,
  `ticket_id` INT NOT NULL,
  PRIMARY KEY (`flight_id`),
  INDEX `fk_flight_ticket1_idx` (`ticket_id` ASC) VISIBLE,
  CONSTRAINT `fk_flight_ticket1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `flight_booking`.`ticket` (`ticket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`airport` (
  `IATAcode` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NULL,
  `state` VARCHAR(50) NULL,
  `Airportcol` VARCHAR(45) NULL,
  `flight_id` INT NOT NULL,
  INDEX `fk_airport_flight1_idx` (`flight_id` ASC) VISIBLE,
  CONSTRAINT `fk_airport_flight1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flight_booking`.`flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flight_booking`.`airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flight_booking`.`airline` (
  `name` VARCHAR(50) NOT NULL,
  `flight_id` INT NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_airline_flight1_idx` (`flight_id` ASC) VISIBLE,
  CONSTRAINT `fk_airline_flight1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flight_booking`.`flight` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
