-- ADA PADEL Maintenance Hub - Supabase setup
-- Run this entire script in Supabase SQL Editor.
create table if not exists public.maintenance_data (
  id text primary key,
  kind text not null check (kind in ('task','priority','checklist','history')),
  data jsonb not null,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id) on delete set null
);

alter table public.maintenance_data enable row level security;

-- Ensure authenticated browser clients have table privileges; RLS still limits access.
grant usage on schema public to authenticated;
grant select, insert, update, delete on public.maintenance_data to authenticated;

drop policy if exists "Authenticated team can read maintenance data" on public.maintenance_data;
create policy "Authenticated team can read maintenance data"
  on public.maintenance_data for select to authenticated using (true);

drop policy if exists "Authenticated team can insert maintenance data" on public.maintenance_data;
create policy "Authenticated team can insert maintenance data"
  on public.maintenance_data for insert to authenticated with check (true);

drop policy if exists "Authenticated team can update maintenance data" on public.maintenance_data;
create policy "Authenticated team can update maintenance data"
  on public.maintenance_data for update to authenticated using (true) with check (true);

drop policy if exists "Authenticated team can delete maintenance data" on public.maintenance_data;
create policy "Authenticated team can delete maintenance data"
  on public.maintenance_data for delete to authenticated using (true);

-- Enable realtime notifications for synchronized devices (ignore duplicate if already enabled).
do $$ begin
  alter publication supabase_realtime add table public.maintenance_data;
exception when duplicate_object then null;
when undefined_object then raise notice 'Publication supabase_realtime was not found; enable Realtime for maintenance_data in the dashboard.';
end $$;
