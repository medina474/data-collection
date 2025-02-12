create table compositions (
  composition bigint not null,
  panier_id bigint not null,
  produit_id bigint,
  qte numeric,
  prix numeric
);


alter table compositions
  add foreign key (panier_id) references paniers not valid;

alter table compositions
  add foreign key (produit_id) references produits not valid;
