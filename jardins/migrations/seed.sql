\connect jardins;

insert into jardins (jardin_id,jardin,tva) values
(1,'Jardins de Cocagne Thaon les Vosges','FR42400245775'),
(2,'IUT de Saint Dié des Vosges',NULL);

insert into contacts (contact_id,jardin_id,contact,telephone,email) values
(1,1,'Christophine Séchion','0699880001','cs@gmail.com'),
(2,2,'Emmanuel Medina','0688100873','emmanuel.medina@univ-lorraine.fr');

update jardins set contact_id = 1 where jardin_id = 1;
update jardins set contact_id = 2 where jardin_id = 2;

insert into adresses (adresse_id,jardin_id,adresse,codepostal,ville,localisation) values
(1,1,'Prairie Claudel','88150','Thaon-les-Vosges','SRID=4326;POINT(6.427672 48.2531016)'),
(34,2,'11 rue de l''Université','88100','Saint Dié des Vosges','SRID=4326;POINT(6.942109 48.289973)');

update jardins set adresse_id = 1 where jardin_id = 1;
update jardins set adresse_id = 34 where jardin_id = 2;

insert into profils (profil_id, profil) values 
(1, 'adhérent'),
(2, 'employé'),
(3, 'étudiant'),
(4, 'professionnel');

-- Calendrier général

insert into saisons (saison_id,jardin_id,saison,date_debut,date_fin) values
(1,1,'2025','2025-01-01','2025-12-31'),
(2,2,'2024-2025','2024-09-01','2025-06-30');

insert into fermetures (fermeture_id,jardin_id,saison_id,semaine) values
(1,1,1,1),
(2,1,1,52),
(3,2,2,52),
(4,2,2,1);

insert into feries (ferie_id,jardin_id,ferie,jour) values
(1,1,'Lundi de Pâques','2025-04-21'),
(2,1,'Fête du Travail','2025-05-01'),
(3,1,'Victoire 1945','2025-05-08'),
(4,1,'Ascension','2025-05-29'),
(5,1,'Pentecôte','2025-06-09'),
(6,1,'Fête nationale','2025-07-14'),
(7,1,'Assomption','2025-08-15'),
(8,1,'Toussaint','2025-11-01'),
(9,1,'Armistice 1918','2025-11-11');

insert into cotisations (cotisation_id, saison_id, profil_id, montant) values 
(1, 1, 1, 25.0),
(2, 1, 2, 0.0),
(3, 1, 3, 5.0),
(4, 1, 4, 250.0);

-- Dépôts

insert into contacts (contact_id,jardin_id,contact,telephone,email) values
(3,1,'Iseline Triiwel','0755044134',NULL),
(4,1,'Matthis Krütt','0685215584',NULL),
(5,1,'Zeynep Soğan','0751346748',NULL),
(6,1,'Maria Carciofo',NULL,NULL),
(7,1,'Mustafa Patlıcan',NULL,NULL),
(8,1,'Marco Melanzana',NULL,NULL),
(9,1,'Daisy Eggplant',NULL,NULL),
(10,1,'Denys Baklazhany',NULL,NULL),
(11,1,'Fernanda Berenjena',NULL,NULL),
(12,1,'Cristian Vânătă',NULL,NULL),
(13,1,'Marjane Badmajan',NULL,NULL),
(14,1,'Elyas Batenjal',NULL,NULL),
(15,1,'Robert Jacquesriviere',NULL,NULL),
(16,1,'Fursy Galriawla','0678283490',NULL),
(17,1,'Louise Mesclun',NULL,NULL),
(18,1,'Albert Potager',NULL,NULL),
(19,1,'Francine Verger',NULL,NULL),
(20,1,'Hugo Bosquet',NULL,NULL),
(21,1,'Léa Rosier',NULL,NULL),
(22,1,'Loubna Ben Allal',NULL,NULL),
(23,1,'Tiera Guinn Fletcher',NULL,NULL);

insert into adresses (adresse_id,jardin_id,adresse,codepostal,ville,localisation) values
(2,1,'6 av. Salvador Allende','88000','Épinal','SRID=4326;POINT(6.4599403 48.1938105)'),
(3,1,'12 rue Armand Colle','88000','Épinal','SRID=4326;POINT(6.4489619 48.1604568)'),
(4,1,'15 rue Général de Reffye','88000','Épinal','SRID=4326;POINT(6.4323215 48.1819469)'),
(5,1,'rue de la papeterie','88000','Dinozé','SRID=4326;POINT(6.4738942 48.1383687)'),
(6,1,'36 bis rue de la Plaine','88190','Golbey','SRID=4326;POINT(6.4426982 48.1929337)'),
(7,1,'avenue des Terres St Jean','88190','Golbey','SRID=4326;POINT(6.4692286 48.1891998)'),
(8,1,'17 rue André Vitu','88000','Épinal','SRID=4326;POINT(6.465403 48.1775685)'),
(15,1,'15 rue du Maréchal Lyautey','88000','Épinal','SRID=4326;POINT(6.4457306 48.177777)'),
(20,1,'9 rue de la Louvière','88000','Épinal','SRID=4326;POINT(6.4531588 48.1723212)');

insert into adresses (adresse_id,jardin_id,adresse,codepostal,ville,localisation) values
(9,1,'24 rue du Gal de Gaulle','88200','St Nabord','SRID=4326;POINT(6.5807814 48.0510352)'),
(10,1,'26 rue de la Joncherie','88200','Remiremont','SRID=4326;POINT(6.5934293 48.0189339)'),
(11,1,'6 place C. Poncelet','88200','Remiremont','SRID=4326;POINT(6.5917178 48.0159918)'),
(12,1,'7 rue du Savron','88220','Raon-aux-Bois','SRID=4326;POINT(6.5036466 48.0504027)'),
(13,1,'1 rue Moncey','88460','Docelles','SRID=4326;POINT(6.6162166 48.1460719)');

insert into adresses (adresse_id,jardin_id,adresse,codepostal,ville,localisation) values
(16,1,'Zac Barbazan','88600','Bruyères','SRID=4326;POINT(6.7208371 48.2032056)'),
(17,1,'2 rue de Fraisne','88600','Bruyères','SRID=4326;POINT(6.7196903 48.2050495)'),
(18,1,'7 rue de la République','88400','Gérardmer','SRID=4326;POINT(6.877433 48.074172)'),
(19,1,'24 route du Noirpré','88530','Le Tholy','SRID=4326;POINT(6.7477787 48.0812967)');

insert into adresses (adresse_id,jardin_id,adresse,codepostal,ville,localisation) values
(21,1,'1 place de Verdun', '88440', 'Nomexy', 'SRID=4326;POINT(6.386527 48.305704)'),
(22,1,'Ruelle de Monsey', '88450', 'Vincey', 'SRID=4326;POINT(6.330850 48.337907)'),
(23,1,'15 rue Ste Barbe','88130','Charmes','SRID=4326;POINT(6.2951122 48.3777043)'),
(24,1,'Bld Georges Clemenceau','88130','Charmes','SRID=4326;POINT(6.298452 48.375298)');

insert into adresses (adresse_id,jardin_id,adresse,codepostal,ville,localisation) values
(25,1,'5 rue du Ruisseau','88150','Thaon les Vosges','SRID=4326;POINT(6.423976 48.208795)'),
(26,1,'ZI Route Charles Pellerin','88190','Golbey','SRID=4326;POINT(6.423976 48.208795)'),
(27,1,'7 allée des Primevères','88390','Les Forges','SRID=4326;POINT(6.397633 48.171791)'),
(14,1,'12 rue  Raymond Poincaré','88000','Épinal','SRID=4326;POINT(6.449693 48.175374)'),
(28,1,'4 place Christian Poncelet','88200','Remiremont','SRID=4326;POINT(6.592068 48.015964)'),
(29,1,'8 quai Barbier','88000','Épinal','SRID=4326;POINT(6.445190 48.171198)'),
(30,1,'allée des Érables','88000','Épinal','SRID=4326;POINT(6.454908 48.203990)'),
(31,1,'7 rue du Boudiou','88000','Épinal','SRID=4326;POINT(6.447245 48.174228)'),
(32,1,'2 rue des Amériques','88190','Golbey','SRID=4326;POINT(6.428831 48.200150)'),
(33,1,'9 rue de la Louvière','88000','Épinal','SRID=4326;POINT(6.452073 48.171806)'),
(35,1,'26 quai des Bons Enfants','88000','Épinal','0101000000370B6AAE89C31940D4E649E361164840'),
(36,1,'29 rue François de Neufchâteau','88000','Épinal','01010000009C679192C3C419406C5F402FDC164840'),
(37,1,'8 rue de la Préfecture','88000','Épinal','01010000000046860B2FC719400DA3C5BE09164840'),
(38,1,'15 rue des Jardiniers','88000','Épinal','01010000007FDDE9CE13CF1940DA6F928BD6154840'),
(39,1,'22 rue de la Moselle','88190','Golbey','0101000000440B1A44B5C21940C029070EC3184840'),
(40,1,'22 pl. d''Avrinsart','88000','Épinal','010100000090BFB4A84FD2194005977D0D77174840'),
(41,1,'16 Qur de la Magdeleine','88000','Épinal','0101000000FE37407AD4C11940575EF23FF9174840'),
(42,1,'1 Rue de la Préfecture','88000','Épinal','0101000000EC51B81E85CB1940384BC97212164840'),
(43,1,'45 boulevard d''Alsace','88400','Gérardmer','0101000000CD00BCAA58811B40D18F2B9A73094840'),
(44,1,'18 Rue des Chaseaux','88200','Remiremont','0101000000138255F5F25B1A40829CE6D319024840'),
(45,1,'15 Av. du Maréchal de Lattre de Tassigny','88000','Épinal','SRID=4326;POINT(6.443127 48.177728)'),
(46,1,'6 Quai des Bons Enfants','88000','Épinal', 'SRID=4326;POINT(6.445643 48.175605)'),
(47,1,'4 Pl. du Général de Gaulle','88000','Épinal', 'SRID=4326;POINT(6.442305 48.178180)'),
(48,1,'12 rue du Struthof','88000','Épinal','SRID=4326;POINT(6.456332 48.153667)'),
(49,1,'12 rue Julien Ruellet','88000','Saint Laurent', 'SRID=4326;POINT(6.458201 48.148279)'),
(50,1,'21 rue Jacques Brel','88190','Golbey','SRID=4326;POINT(6.423633 48.198616)'),
(51,1,'1 route de Mazeley','88150','Oncourt','SRID=4326;POINT(6.377770 48.251139)'),
(52,1,'5 rue du Haut du Camp','88440','Nomexy','SRID=4326;POINT(6.380297 48.307381)'),
(53,1,'10 rue du docteur Sayer','88330','Châtel','SRID=4326;POINT(6.390317 48.315380)'),
(54,1,'21 rue du Saint Oger','88000','Deyvillers','SRID=4326;POINT(6.513466 48.203747)'),
(55,1,'rue des Forts','88390','Uxegney','SRID=4326;POINT(6.381738 48.198477)'),
(56,1,'rue du Haut du Butté','88440','Frizon','SRID=4326;POINT(6.362618 48.284125)'),
(57,1,'Allée des alouettes','88150','Girmont','SRID=4326;POINT(6.443350 48.259520)'),
(58,1,'3 rue du Haut des Étages','88000','Épinal','SRID=4326;POINT(6.454961 48.185961)'),
(59,1,'56 chemin du Moulin','88000','Épinal','SRID=4326;POINT(6.475722 48.179868)'),
(60,1,'43 rue du Centre','88200','Saint Nabord','SRID=4326;POINT(6.583557 48.051127)'),
(61,1,'19 rue de la Moselotte','88200','Saint Étienne les Remiremont','SRID=4326;POINT(6.613694 48.020207)'),
(62,1,'5 av. de Provence','88000','Épinal','SRID=4326;POINT(6.4487861 48.1690093)'),
(63,1,'5 rue du Chapitre','88000','Épinal','SRID=4326;POINT(6.4511496 48.1736396)'),
(64,1,'557 rue du Chêne','88220','Hadol','SRID=4326;POINT(6.484004 48.108499)');

insert into depots (depot_id,jardin_id,depot,adresse_id,contact_id,capacite) values
(1,1,'Jardins de Cocagne',1,NULL,100),
(3,1,'Église Saint Antoine',3,4,60),
(4,1,'Ligue de l’enseignement',4,5,40),
(5,1,'APF - Local extérieur – ESAT',5,23,20),
(6,1,'Ecodenn’ergie',6,22,20),
(7,1,'Botanic',7,6,20),
(8,1,'Chambre d’Agriculture',8,7,20),
(9,1,'Pharmacie Saint Nabord',9,15,20),
(10,1,'Association GACI',10,11,80),
(11,1,'Office du tourisme',11,12,20),
(12,1,'Raon aux Bois',12,NULL,20),
(13,1,'Docelles',13,20,20),
(14,1,'Centre Léo Lagrange',2,8,60),
(15,1,'3e Rive (Café Associatif)',15,9,20),
(16,1,'Point Vert Mafra',16,13,20),
(17,1,'Brico Marché',17,14,20),
(18,1,'Pro & Cie',18,NULL,40),
(19,1,'Le Tholy',19,21,20),
(99,1,'Livraison à domicile',NULL,NULL,100),
(20,1,'Maison de l’Étudiant',20,10,20),
(21,1,'Secours Catholique',21,17,20),
(22,1,'Résidence du Monsey',22,16,20),
(23,1,'Charmes',23,NULL,20),
(24,1,'Complexe Sportif',24,NULL,40),
(25,1,'Moustaches Bikes',25,NULL,20),
(26,1,'Papeterie Norske Skog',26,NULL,20),
(27,1,'Les Forges',27,18,20),
(28,1,'Maison de l''Environnement',14,NULL,20),
(29,1,'Vosgelis Remiremont',28,19,20),
(30,1,'Vosgelis',29,NULL,20),
(31,1,'Crédit Agricole',30,NULL,20),
(32,1,'Biocoop',31,NULL,20),
(33,1,'Fives',32,NULL,20),
(34,1,'Asso Étudiant Universitaire',33,NULL,20),
(35,1,'Hadol',64,NULL,20);

-- Calendriers

insert into calendriers (calendrier_id,jardin_id,calendrier) values
(1,1,'Livraisons du mardi'),
(2,1,'Livraisons du mercredi'),
(3,1,'Livraisons du jeudi'),
(4,1,'Livraisons du vendredi');

insert into frequences (frequence_id,jardin_id,frequence) values
(1,1,'hebdomadaire'),
(2,1,'15 jours'),
(3,1,'libre');

-- Produits

insert into produits (produit_id,jardin_id,produit,prix,marge) values
(1,1,'Panier simple',13.80,40.0),
(2,1,'Panier familial',23.70,40.0),
(3,1,'Panier fruité 1',14.00,70.0),
(4,1,'Panier fruité 2',17.00,70.0),
(5,1,'Panier fruité 3',23.00,70.0),
(6,1,'Oeufs x6',3.20,50.0),
(7,1,'Panier entreprise',25.00,70.0);

insert into paniers (panier_id,produit_id,panier,frequence_id,quantite,prix) values
(1,1,'Panier simple hebdomadaire',1,50,690.0),
(2,1,'Panier simple 15 jours',2,25,404.0),
(3,2,'Panier familial hebdomadaire',1,50,1185.0),
(4,2,'Panier familial 15 jours',2,25,658.0),
(5,1,'Panier simple unité',3,1,13.8),
(6,2,'Panier familial unité',3,1,23.7),
(7,1,'Panier solidaire',3,1,2.5),
(8,3,'Panier fruité 1',3,1,14.0),
(9,4,'Panier fruité 2',3,1,17.0),
(10,5,'Panier fruité 3',3,1,23.0),
(11,6,'Oeufs x6',3,1,3.05),
(12,7,'Panier fruité 4',3,1,23.5);

insert into paniers (panier_id,produit_id,panier,frequence_id,quantite,prix) values
(13,1,'Panier simple hebdomadaire à domicile',1,50,894.0),
(14,1,'Panier simple 15 jours à domicile',2,25,497.0),
(15,2,'Panier familial hebdomadaire à domicile',1,50,1447.0),
(16,2,'Panier familial 15 jours à domicile',2,25,857.0);


insert into paniers (panier_id,produit_id,panier,frequence_id,quantite,prix) values
(17,1,'Panier simple soutien x12',1,12,196.0),
(18,1,'Panier simple soutien x6',2,6,98.0),
(19,2,'Panier familial soutien x12',1,12,318.0),
(20,2,'Panier familial soutien x6',2,6,160.0);

-- Production

insert into preparations (preparation_id,jardin_id,preparation,jour) values
(1,1,'Mardi',1),
(2,1,'Jeudi',3);
