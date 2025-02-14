update livraisons_import set produit_id = 1 where produit in ('APS', 'APDS', 'APS15', 'APDS15','APSS12', 'APDSS12', 'APSS6', 'APDSS6', 'MPSSO', 'MPSH');
update livraisons_import set produit_id = 2 where produit in ('APF', 'APDF', 'APF15', 'APDF15', 'APSF12', 'MPFH');
update livraisons_import set produit_id = 3 where produit in ('ABF1');
update livraisons_import set produit_id = 4 where produit in ('ABF2');
update livraisons_import set produit_id = 5 where produit in ('ABF3');
update livraisons_import set produit_id = 6 where produit in ('ABOEUF6');
update livraisons_import set produit_id = 7 where produit in ('ABF4');

update livraisons_import set panier_id = 1 where produit in ('APS');
update livraisons_import set panier_id = 2 where produit in ('APS15');
update livraisons_import set panier_id = 3 where produit in ('APF');
update livraisons_import set panier_id = 4 where produit in ('APF15');
update livraisons_import set panier_id = 7 where produit in ('MPSSO');
update livraisons_import set panier_id = 8 where produit in ('ABF1');
update livraisons_import set panier_id = 9 where produit in ('ABF2');
update livraisons_import set panier_id = 10 where produit in ('ABF3');
update livraisons_import set panier_id = 11 where produit in ('ABOEUF6');
update livraisons_import set panier_id = 12 where produit in ('ABF4');

update livraisons_import set depot_id = 99 where depot_text in ('99');
update livraisons_import set depot_id = 99 where depot_text = 'ZMA';
update livraisons_import set depot_id = 70 where depot_text in ('70','71');
update livraisons_import set depot_id = 28 where depot_text in ('28', '58');
update livraisons_import set depot_id = 62 where depot_text in ('41', '67', '62');
update livraisons_import set depot_id = 75 where depot_text = '75';
update livraisons_import set depot_id = 49 where depot_text in ('49');
update livraisons_import set depot_id = 23 where depot_text in ('23');
update livraisons_import set depot_id = 2 where depot_text in ('02');
update livraisons_import set depot_id = 3 where depot_text in ('03');
update livraisons_import set depot_id = 4 where depot_text in ('04');
update livraisons_import set depot_id = 33 where depot_text = '33';
update livraisons_import set depot_id = 37 where depot_text = '00';
update livraisons_import set depot_id = 37 where depot_text in ('ZMM');
update livraisons_import set depot_id = 42 where depot_text in ('42','43','72');
update livraisons_import set depot_id = 64 where depot_text in ('64','69');
update livraisons_import set depot_id = 31 where depot_text in ('31');
update livraisons_import set depot_id = 14 where depot_text in ('14','54');
update livraisons_import set depot_id = 29 where depot_text in ('29');
update livraisons_import set depot_id = 46 where depot_text in ('46');
update livraisons_import set depot_id = 10 where depot_text = '10';
update livraisons_import set depot_id = 25 where depot_text in ('25');
update livraisons_import set depot_id = 32 where depot_text in ('32');
update livraisons_import set depot_id = 15 where depot_text in ('15');
update livraisons_import set depot_id = 6 where depot_text in ('06');
update livraisons_import set depot_id = 50 where depot_text in ('50', '51','52','53');
update livraisons_import set depot_id = 57 where depot_text in ('57');
update livraisons_import set depot_id = 38 where depot_text in ('38');
update livraisons_import set depot_id = 65 where depot_text in ('65');
update livraisons_import set depot_id = 32 where depot_text in ('ZMR');
update livraisons_import set depot_id = 27 where depot_text in ('27');
update livraisons_import set depot_id = 35 where depot_text in ('35');
update livraisons_import set depot_id = 9 where depot_text in ('09');
update livraisons_import set depot_id = 8 where depot_text in ('08');
update livraisons_import set depot_id = 13 where depot_text in ('13');
update livraisons_import set depot_id = 61 where depot_text in ('61');
update livraisons_import set depot_id = 19 where depot_text in ('19');
update livraisons_import set depot_id = 26 where depot_text in ('26');
update livraisons_import set depot_id = 12 where depot_text in ('12');
update livraisons_import set depot_id = 22 where depot_text in ('22');
update livraisons_import set depot_id = 16 where depot_text in ('16');
update livraisons_import set depot_id = 18 where depot_text in ('18');
update livraisons_import set depot_id = 44 where depot_text in ('44','45', '73');
update livraisons_import set depot_id = 30 where depot_text in ('30');
update livraisons_import set depot_id = 24 where depot_text in ('24', '74');
update livraisons_import set depot_id = 47 where depot_text in ('47');
update livraisons_import set depot_id = 48 where depot_text in ('48');
update livraisons_import set depot_id = 77 where depot_text in ('77');
update livraisons_import set depot_id = 11 where depot_text in ('11');
update livraisons_import set depot_id = 35 where depot_text in ('35');
update livraisons_import set depot_id = 5 where depot_text in ('05');
update livraisons_import set depot_id = 1 where depot_text in ('01');
update livraisons_import set depot_id = 80 where depot_text in ('80');
update livraisons_import set depot_id = 21 where depot_text in ('21');
update livraisons_import set depot_id = 81 where depot_text in ('81','82');
update livraisons_import set depot_id = 7 where depot_text in ('07');
update livraisons_import set depot_id = 20 where depot_text in ('20', '40');
update livraisons_import set depot_id = 17 where depot_text in ('17');
update livraisons_import set depot_id = 60 where depot_text in ('60');
update livraisons_import set depot_id = 55 where depot_text in ('55');
update livraisons_import set depot_id = 36 where depot_text in ('36');
update livraisons_import set depot_id = 78 where depot_text in ('78');
update livraisons_import set depot_id = 83 where depot_text in ('83');
update livraisons_import set depot_id = 37 where depot_text in ('37');
update livraisons_import set depot_id = 13 where depot_text in ('34');


insert into livraisons (jardin_id, abonnement_id, distribution_id, produit_id, qte, livre, planning_id)
select 1 as jardin_id,
  import.abonnement_id as abonnement_id,
  depot_id as distribution_id,
  import.produit_id,
  import.qte,
  CASE
    WHEN livre = 0 THEN 'à livrer'::livraison
    WHEN livre = 1 THEN 'livré'::livraison
  END,
  p.planning_id  as planning_id
from livraisons_import import
join plannings p on p.jour = import.jour
where abonnement_id not in (28568, 29534, 28758, 29171,29561,28232,28263,28546,29560,
28585,28588,29337,29591,28407,28408,28415,28405,28406,29438,28409,28544,29584,29592,
28361,28690,28179,28694,29276,28798,29419,28623,28573,29511,28398,29501);

refresh materialized view detail_depots with data;
refresh materialized view detail_livraisons with data;

-- Adhérents profil salariés sont ceux qui sont livrés lors de la tournée 6
update adherents a set profil_id = 3
where exists (select 1 from detail_livraisons dl where dl.adherent_id = a.adherent_id and dl.tournee_id = 6);
