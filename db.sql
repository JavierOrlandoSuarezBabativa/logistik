/* chanhe in branch  */
/* Mensaje de que el archivo ya esta en un repositorio de Git */
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
-- Table `mydb`.`Bodegas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bodegas` (
  `Id_Bodega` INT NOT NULL AUTO_INCREMENT,
  `Administrador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Bodega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `Id_Usuario` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Cedula` VARCHAR(45) NOT NULL,
  `Celular` VARCHAR(45) NOT NULL,
  `Cargo` VARCHAR(45) NOT NULL,
  `Contraseña` VARCHAR(45) NOT NULL,
  `Bodegas_Id_Bodega` INT NOT NULL,
  PRIMARY KEY (`Id_Usuario`),
  INDEX `fk_Usuarios_Bodegas_idx` (`Bodegas_Id_Bodega` ASC),
  CONSTRAINT `fk_Usuarios_Bodegas`
    FOREIGN KEY (`Bodegas_Id_Bodega`)
    REFERENCES `mydb`.`Bodegas` (`Id_Bodega`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modulos` (
  `Id_Modulo` INT NOT NULL AUTO_INCREMENT,
  `Bodegas_Id_Bodega` INT NOT NULL,
  `Nombre_Modulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Modulo`),
  INDEX `fk_Modulos_Bodegas1_idx` (`Bodegas_Id_Bodega` ASC),
  CONSTRAINT `fk_Modulos_Bodegas1`
    FOREIGN KEY (`Bodegas_Id_Bodega`)
    REFERENCES `mydb`.`Bodegas` (`Id_Bodega`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`referencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`referencias` (
  `Id_Referencia` INT NOT NULL AUTO_INCREMENT,
  `Modulos_Id_Modulo` INT NOT NULL,
  `Referencia_Equipo` VARCHAR(45) NOT NULL,
  `Modelo` YEAR(4) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Valor` FLOAT NOT NULL,
  `CPU` VARCHAR(45) NOT NULL,
  `Storage` VARCHAR(45) NOT NULL,
  `Pulgadas` VARCHAR(45) NOT NULL,
  `Bateria` VARCHAR(45) NOT NULL,
  INDEX `fk_referencias_Modulos1_idx` (`Modulos_Id_Modulo` ASC),
  PRIMARY KEY (`Id_Referencia`),
  CONSTRAINT `fk_referencias_Modulos1`
    FOREIGN KEY (`Modulos_Id_Modulo`)
    REFERENCES `mydb`.`Modulos` (`Id_Modulo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`equipos` (
  `Id_Equipo` INT NOT NULL AUTO_INCREMENT,
  `Referencias_Id_Referencia` INT NOT NULL,
  `Cantidades` DECIMAL NOT NULL,
  `Fecha_Ingreso` DATE NOT NULL,
  PRIMARY KEY (`Id_Equipo`),
  INDEX `fk_equipos_referencias1_idx` (`Referencias_Id_Referencia` ASC),
  CONSTRAINT `fk_equipos_referencias1`
    FOREIGN KEY (`Referencias_Id_Referencia`)
    REFERENCES `mydb`.`referencias` (`Id_Referencia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`destinatarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`destinatarios` (
  `Id_Destinatario` INT NOT NULL AUTO_INCREMENT,
  `Cedula` VARCHAR(45) NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `Observaciones` VARCHAR(200) NOT NULL,
  `Numero_Guia` BIGINT NULL,
  PRIMARY KEY (`Id_Destinatario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`solicitudes` (
  `Numero_Solicitud` INT NOT NULL AUTO_INCREMENT,
  `Id_Referencia` INT NOT NULL,
  `Destinatarios_Id_Destinatario` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Estado_Solicitud` VARCHAR(45) NULL,
  `Valor_Total` FLOAT NULL,
  `Fecha` DATE NOT NULL,
  `Fecha_Envio` DATE NULL,
  PRIMARY KEY (`Numero_Solicitud`),
  INDEX `fk_solicitudes_destinatarios1_idx` (`Destinatarios_Id_Destinatario` ASC),
  CONSTRAINT `fk_solicitudes_destinatarios1`
    FOREIGN KEY (`Destinatarios_Id_Destinatario`)
    REFERENCES `mydb`.`destinatarios` (`Id_Destinatario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`salidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`salidas` (
  `Brand` VARCHAR(45) NOT NULL,
  `Ref` VARCHAR(45) NOT NULL,
  `Serial` VARCHAR(45) NOT NULL,
  `Date` VARCHAR(45) NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seriales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seriales` (
  `id_Serial` INT NOT NULL,
  `id_Ref` INT NOT NULL,
  `Serial` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Serial`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
