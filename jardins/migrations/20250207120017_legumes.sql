create table stocks (
  stock_id bigint,
  qte numeric
);

alter table stocks enable row level security;

create policy "Lecture publique"
on stocks
as permissive
for select
to public
using (true);