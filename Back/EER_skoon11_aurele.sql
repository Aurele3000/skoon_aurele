-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema skoon1_aurele
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema skoon1_aurele
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `skoon1_aurele` DEFAULT CHARACTER SET utf8 ;
USE `skoon1_aurele` ;

-- -----------------------------------------------------
-- Table `skoon1_aurele`.`adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`adresse` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ville` VARCHAR(45) NOT NULL,
  `rue` VARCHAR(45) NOT NULL,
  `code_postal` INT NOT NULL,
  `geolocalisation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`agenda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_horaire_debut` DATETIME NOT NULL,
  `date_horaire_fin` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`equipement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`equipement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `proprietaire` VARCHAR(45) NOT NULL,
  `type_evenemnt` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`media` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`evenement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`evenement` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `nombre_personne` INT NOT NULL,
  `equipement_id` INT NOT NULL,
  `adresse_id` INT NOT NULL,
  `agenda_id` INT NOT NULL,
  `media_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_evenement_equipement1_idx` (`equipement_id` ASC),
  INDEX `fk_evenement_adresse1_idx` (`adresse_id` ASC),
  INDEX `fk_evenement_agenda1_idx` (`agenda_id` ASC),
  INDEX `fk_evenement_media1_idx` (`media_id` ASC),
  CONSTRAINT `fk_evenement_equipement1`
    FOREIGN KEY (`equipement_id`)
    REFERENCES `skoon1_aurele`.`equipement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evenement_adresse1`
    FOREIGN KEY (`adresse_id`)
    REFERENCES `skoon1_aurele`.`adresse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evenement_agenda1`
    FOREIGN KEY (`agenda_id`)
    REFERENCES `skoon1_aurele`.`agenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evenement_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `skoon1_aurele`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`messagerie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`messagerie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(45) NOT NULL,
  `date_heure_emission` DATETIME NOT NULL,
  `evenement_id` INT NOT NULL,
  `media_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_messagerie_evenement1_idx` (`evenement_id` ASC),
  INDEX `fk_messagerie_media1_idx` (`media_id` ASC),
  CONSTRAINT `fk_messagerie_evenement1`
    FOREIGN KEY (`evenement_id`)
    REFERENCES `skoon1_aurele`.`evenement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messagerie_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `skoon1_aurele`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `administrateur` VARCHAR(45) NOT NULL,
  `nettoyeur` VARCHAR(45) NOT NULL,
  `preteur` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`participant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`participant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pseudo` VARCHAR(45) NOT NULL,
  `activites` VARCHAR(45) NOT NULL,
  `role_id` INT NOT NULL,
  `evenement_id` INT NOT NULL,
  `equipement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_participant_role1_idx` (`role_id` ASC),
  INDEX `fk_participant_evenement1_idx` (`evenement_id` ASC),
  INDEX `fk_participant_equipement1_idx` (`equipement_id` ASC),
  CONSTRAINT `fk_participant_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `skoon1_aurele`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participant_evenement1`
    FOREIGN KEY (`evenement_id`)
    REFERENCES `skoon1_aurele`.`evenement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participant_equipement1`
    FOREIGN KEY (`equipement_id`)
    REFERENCES `skoon1_aurele`.`equipement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `skoon1_aurele`.`skooner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skoon1_aurele`.`skooner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(45) NOT NULL,
  `adresse_id` INT NOT NULL,
  `participant_id` INT NOT NULL,
  `messagerie_id` INT NOT NULL,
  `agenda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_skooner_adresse_idx` (`adresse_id` ASC),
  INDEX `fk_skooner_participant1_idx` (`participant_id` ASC),
  INDEX `fk_skooner_messagerie1_idx` (`messagerie_id` ASC),
  INDEX `fk_skooner_agenda1_idx` (`agenda_id` ASC),
  CONSTRAINT `fk_skooner_adresse`
    FOREIGN KEY (`adresse_id`)
    REFERENCES `skoon1_aurele`.`adresse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skooner_participant1`
    FOREIGN KEY (`participant_id`)
    REFERENCES `skoon1_aurele`.`participant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skooner_messagerie1`
    FOREIGN KEY (`messagerie_id`)
    REFERENCES `skoon1_aurele`.`messagerie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skooner_agenda1`
    FOREIGN KEY (`agenda_id`)
    REFERENCES `skoon1_aurele`.`agenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
