-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema video_rental
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema video_rental
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `video_rental` DEFAULT CHARACTER SET utf8 ;
USE `video_rental` ;

-- -----------------------------------------------------
-- Table `video_rental`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_rental`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `video_rental`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_rental`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_user_role_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `video_rental`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `video_rental`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_rental`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `video_rental`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_rental`.`movies` (
  `movie_id` INT NOT NULL AUTO_INCREMENT,
  `barcode` VARCHAR(50) NOT NULL,
  `daily_rent_rate` DECIMAL(5,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `video_rental`.`coupons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_rental`.`coupons` (
  `code` VARCHAR(50) NOT NULL,
  `description` VARCHAR(255) NULL,
  `discount` DECIMAL(2,1) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `video_rental`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `video_rental`.`rental` (
  `customer_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `rent_date` DATETIME NOT NULL,
  `return_date` DATETIME NOT NULL,
  `coupons_code` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`customer_id`, `movie_id`),
  INDEX `fk_rental_movies1_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_rental_coupons1_idx` (`coupons_code` ASC) VISIBLE,
  CONSTRAINT `fk_rental_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `video_rental`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_movies1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `video_rental`.`movies` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_coupons1`
    FOREIGN KEY (`coupons_code`)
    REFERENCES `video_rental`.`coupons` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
