

alter table jardins.abonnements enable row level security;

create policy "Lecture publique"
on jardins.abonnements
as permissive
for select
to public
using (true);


alter table jardins.calendriers enable row level security;

create policy "Lecture publique"
on jardins.calendriers
as permissive
for select
to public
using (true);

alter table jardins.distributions enable row level security;

create policy "Lecture publique"
on jardins.distributions
as permissive
for select
to public
using (true);

alter table jardins.frequences enable row level security;

create policy "Lecture publique"
on jardins.frequences
as permissive
for select
to public
using (true);

alter table jardins.modes_paiement enable row level security;

create policy "Lecture publique"
on jardins.modes_paiement
as permissive
for select
to public
using (true);

alter table jardins.plannings enable row level security;

create policy "Lecture publique"
on jardins.plannings
as permissive
for select
to public
using (true);

alter table jardins.preparations enable row level security;

create policy "Lecture publique"
on jardins.preparations
as permissive
for select
to public
using (true);

alter table jardins.tournees enable row level security;

create policy "Lecture publique"
on jardins.tournees
as permissive
for select
to public
using (true);


alter table jardins.cotisations enable row level security;

create policy "Lecture publique"
on jardins.cotisations
as permissive
for select
to public
using (true);


alter table jardins.profils enable row level security;

create policy "Lecture publique"
on jardins.profils
as permissive
for select
to public
using (true);


alter table jardins.propositions enable row level security;

create policy "Lecture publique"
on jardins.propositions
as permissive
for select
to public
using (true);
