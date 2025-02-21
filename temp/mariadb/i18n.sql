CREATE DATABASE `i18n`;
USE `i18n`;

GRANT SELECT, SHOW VIEW ON `i18n`.* TO 'cinema';

CREATE TABLE Pays (
  `code-2` varchar(2) NOT NULL PRIMARY KEY COMMENT 'iso 3166-1 alpha 2',
  `code-3` varchar(3) NOT NULL COMMENT 'iso 3166-1 alpha 3',
  `code-num` integer NOT NULL COMMENT 'iso 3166-1 numeric',
  `nom` varchar(45) NOT NULL,
  `drapeau-unicode` char(2),
  `drapeau-svg` text
) ENGINE=InnoDB;

CREATE TABLE Langue
(
  `code` char(3) NOT NULL PRIMARY KEY,
  `langue` varchar(20),
  `français` varchar(20)
) ENGINE=InnoDB;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/i18n-pays.csv'
REPLACE INTO TABLE Pays
FIELDS TERMINATED BY ',' ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/docker-entrypoint-initdb.d/i18n-langue.csv'
REPLACE INTO TABLE Langue
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
