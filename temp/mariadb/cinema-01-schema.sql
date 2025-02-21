USE `cinema`;

CREATE TABLE `Serie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serie` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `Etablissement` (
  `id` int(11) NOT NULL,
  `nom` varchar(60) DEFAULT NULL,
  `voie` varchar(60) DEFAULT NULL,
  `codepostal` varchar(8) DEFAULT NULL,
  `ville` varchar(40) DEFAULT NULL,
  `coordonnees` point NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  SPATIAL KEY `idx_coordonnees` (`coordonnees`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Film` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `titre` varchar(80) NOT NULL,
  `titre_original` varchar(80) DEFAULT NULL,
  `annee` int(11) DEFAULT NULL,
  `sortie` date DEFAULT NULL,
  `duree` int(11) DEFAULT NULL,
  `serie` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `serie` (`serie`),
  CONSTRAINT `Film_ibfk_1` FOREIGN KEY (`serie`) REFERENCES `Serie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Film_Genre` (
  `film` uuid NOT NULL,
  `genre` int(11) NOT NULL,
  PRIMARY KEY (`film`,`genre`),
  CONSTRAINT `Film_Genre_ibfk_2` FOREIGN KEY (`film`) REFERENCES `Film` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Genre` (
  `id` int(11) NOT NULL,
  `genre` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Personne` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `naissance` date DEFAULT NULL,
  `deces` date DEFAULT NULL,
  `artiste` varchar(30) DEFAULT NULL,
  `nationalite` char(2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_personne_nom` (`nom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `Equipe` (
  `film` uuid NOT NULL,
  `personne` uuid NOT NULL,
  `role` varchar(25) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`film`,`personne`),
  KEY `film` (`film`),
  KEY `personne` (`personne`),
  CONSTRAINT `Equipe_Film_fk` FOREIGN KEY (`film`) REFERENCES `Film` (`id`),
  CONSTRAINT `Equipe_Personne_fk` FOREIGN KEY (`personne`) REFERENCES `Personne` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE TABLE `Reference` (
  `id` uuid NOT NULL,
  `site` int(11) NOT NULL,
  `lien` tinytext NOT NULL,
  PRIMARY KEY (`id`,`site`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Salle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `etablissement` int(11) NOT NULL,
  `salle` varchar(20) NOT NULL,
  `sieges` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Salle_ibfk_1` (`etablissement`),
  CONSTRAINT `Salle_ibfk_1` FOREIGN KEY (`etablissement`) REFERENCES `Etablissement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Seance` (
  `id` int(11) NOT NULL,
  `film` uuid NOT NULL,
  `salle` int(11) NOT NULL,
  `seance` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Seance_ibfk_1` (`film`),
  KEY `Seance_ibfk_2` (`salle`),
  CONSTRAINT `Seance_ibfk_1` FOREIGN KEY (`film`) REFERENCES `Film` (`id`),
  CONSTRAINT `Seance_ibfk_2` FOREIGN KEY (`salle`) REFERENCES `Salle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;





CREATE TABLE `Site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `Societe` (
  `id` uuid NOT NULL,
  `societe` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*
CREATE TABLE `Synopsis` (
  `film` uuid NOT NULL,
  `langue` char(3) NOT NULL,
  `synopsis` text NOT NULL,
  PRIMARY KEY (`film`,`langue`),
  KEY `langue` (`langue`),
  CONSTRAINT `Synopsis_ibfk_1` FOREIGN KEY (`film`) REFERENCES `Film` (`id`),
  CONSTRAINT `Synopsis_ibfk_2` FOREIGN KEY (`langue`) REFERENCES `i18n`.`Langue` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
*/

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Film_sans_equipe` AS select `Film`.`titre` AS `titre`,count(`Equipe`.`film`) AS `nb` from (`Film` left join `Equipe` on(`Equipe`.`film` = `Film`.`id`)) group by `Film`.`titre` having count(`Equipe`.`film`) = 0;
CREATE TABLE `Vote` (
  `film` uuid NOT NULL,
  `moyenne` decimal(4,2) NOT NULL,
  `nombre` int(11) NOT NULL,
  PRIMARY KEY (`film`),
  CONSTRAINT `Vote_ibfk_1` FOREIGN KEY (`film`) REFERENCES `Film` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Personne_Acteur` AS select `Personne`.`id` AS `id`,coalesce(`Personne`.`artiste`,concat(`Personne`.`prenom`,' ',`Personne`.`nom`)) AS `nom`,`Personne`.`naissance` AS `naissance`,`Personne`.`deces` AS `deces`,`Personne`.`nationalite` AS `nationalite`,count(`Film`.`id`) AS `nb` from ((`Personne` join `Equipe` on(`Equipe`.`personne` = `Personne`.`id`)) left join `Film` on(`Film`.`id` = `Equipe`.`film`)) where `Equipe`.`role` = 'actor' group by 1,2,3,4;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `Personne_sans_role` AS select `Personne`.`id` AS `id`,`Personne`.`prenom` AS `prenom`,`Personne`.`nom` AS `nom`,count(`Equipe`.`personne`) AS `nb` from (`Personne` left join `Equipe` on(`Equipe`.`personne` = `Personne`.`id`)) group by 1,2,3 having count(`Equipe`.`personne`) = 0;
