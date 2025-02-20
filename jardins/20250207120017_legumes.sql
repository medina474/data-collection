

create table jardins.stocks (
  stock_id bigint,
  qte numeric
);

alter table jardins.stocks enable row level security;

create policy "Lecture publique"
on jardins.stocks
as permissive
for select
to public
using (true);
