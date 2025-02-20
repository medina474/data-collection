

create table jardins.compositions (
  composition bigint not null,
  panier_id bigint not null,
  produit_id bigint,
  qte numeric,
  prix numeric
);

alter table jardins.compositions
  add foreign key (panier_id) references jardins.paniers not valid;

alter table jardins.compositions
  add foreign key (produit_id) references jardins.produits not valid;
