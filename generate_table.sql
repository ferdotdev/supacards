create table cards (
  id bigint generated always as identity primary key,
  cc text not null,
  cvv text not null,
  expiration_date text not null
);
