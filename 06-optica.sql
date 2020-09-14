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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveidor` (
  `NIF` VARCHAR(9) NOT NULL,
  `nom` VARCHAR(40) NOT NULL,
  `adreça` VARCHAR(75) NOT NULL,
  `telefon` VARCHAR(12) NULL,
  `fax` VARCHAR(12) NULL,
  PRIMARY KEY (`NIF`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ullerra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ullerra` (
  `idUllerra` INT NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `graducio` VARCHAR(4) NOT NULL,
  `montura` VARCHAR(45) NOT NULL,
  `colorMontura` VARCHAR(45) NOT NULL,
  `colorVidre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUllerra`, `marca`),
  UNIQUE INDEX `idUllerra_UNIQUE` (`idUllerra` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Compra` (
  `nifProveidor` VARCHAR(9) NULL,
  `marcaUlleres` VARCHAR(45) NULL,
  INDEX `FK_compra_proveidor_idx` (`nifProveidor` ASC) VISIBLE,
  INDEX `FK_compra_ullera_idx` (`marcaUlleres` ASC) VISIBLE,
  CONSTRAINT `FK_compra_proveidor`
    FOREIGN KEY (`nifProveidor`)
    REFERENCES `mydb`.`Proveidor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_compra_ullera`
    FOREIGN KEY (`marcaUlleres`)
    REFERENCES `mydb`.`Ullerra` (`marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `correoElectronic` VARCHAR(60) NOT NULL,
  `nom` VARCHAR(30) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(12) NOT NULL,
  `dataRegistre` DATE NOT NULL,
  PRIMARY KEY (`correoElectronic`),
  UNIQUE INDEX `correoElectronic_UNIQUE` (`correoElectronic` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Registre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Registre` (
  `idRegistre` INT NOT NULL,
  `correoElectronic` VARCHAR(60) NULL,
  `recomendat` VARCHAR(45) NULL,
  PRIMARY KEY (`idRegistre`),
  INDEX `FK_registre_client_idx` (`correoElectronic` ASC) VISIBLE,
  CONSTRAINT `FK_registre_client`
    FOREIGN KEY (`correoElectronic`)
    REFERENCES `mydb`.`Client` (`correoElectronic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Venta` (
  `idVenta` INT NOT NULL,
  `correoClient` VARCHAR(60) NOT NULL,
  `nomEmpleat` VARCHAR(45) NOT NULL,
  `ulleraId` INT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `FK_venta_ullera_idx` (`ulleraId` ASC) VISIBLE,
  INDEX `FK_venta_client_idx` (`correoClient` ASC) VISIBLE,
  CONSTRAINT `FK_venta_ullera`
    FOREIGN KEY (`ulleraId`)
    REFERENCES `mydb`.`Ullerra` (`idUllerra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_venta_client`
    FOREIGN KEY (`correoClient`)
    REFERENCES `mydb`.`Client` (`correoElectronic`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO client values ('joelberenguermartinez@gmail.com', 'Joel B.', 'Carrer dAdra, 61, Terrassa, 08225', '627727968', '2020-09-11');
INSERT INTO proveidor values ('00000001R','Josep Maria', 'Av. Abat Marcet, Terrassa, 08225', '620030789', '22131231');
INSERT INTO registre values (000000000001, 'joelberenguermartinez@gmail.com', 'Francesc');
INSERT INTO compra values('00000001R', 'RayBan');
INSERT INTO ullerra values (000022222221, 'RayBan', '+1.5', 'Pasta','Blanc','Transparent');
INSERT INTO venta values (000033333332, 'joelberenguermartinez@gmail.com', 'Francesc', 000022222221);