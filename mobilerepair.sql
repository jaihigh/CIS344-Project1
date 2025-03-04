-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerID` INT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `PhoneNumber` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Device` (
  `DeviceID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `Brand` VARCHAR(45) NOT NULL,
  `Model` VARCHAR(45) NOT NULL,
  `IssueDescription` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeviceID`),
  INDEX `fk_device_customer_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_device_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Repair_Request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Repair_Request` (
  `RequestID` INT NOT NULL AUTO_INCREMENT,
  `CustomerID` INT NOT NULL,
  `DeviceID` INT NOT NULL,
  `RequestDate` DATE NOT NULL,
  `Status` VARCHAR(45) NULL,
  `EstimatedCost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`RequestID`),
  INDEX `fk_repair_customer_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_repair_device_idx` (`DeviceID` ASC) VISIBLE,
  CONSTRAINT `fk_repair_customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_repair_device`
    FOREIGN KEY (`DeviceID`)
    REFERENCES `mydb`.`Device` (`DeviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Technician`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Technician` (
  `TechnicianID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Specialization` VARCHAR(100) NOT NULL,
  `Availability` TINYINT(1) NULL,
  PRIMARY KEY (`TechnicianID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inventory` (
  `PartID` INT NOT NULL AUTO_INCREMENT,
  `PartName` VARCHAR(100) NOT NULL,
  `QuantityInStock` INT NOT NULL,
  PRIMARY KEY (`PartID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `RequestID` INT NULL,
  `PaymentDate` DATE NOT NULL,
  `AmountPaid` DECIMAL(10,2) NOT NULL,
  `PaymentMethod` ENUM('Cash', 'Credit Card', 'Online') NOT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `fk_payment_request_idx` (`RequestID` ASC) VISIBLE,
  CONSTRAINT `fk_payment_request`
    FOREIGN KEY (`RequestID`)
    REFERENCES `mydb`.`Repair_Request` (`RequestID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
