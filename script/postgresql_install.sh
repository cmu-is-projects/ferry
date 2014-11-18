#!/bin/bash

# install postgres
postgres=`brew list | grep postgres`
if [[ ! $postgres ]]; then
  echo ''
  echo '##### Installing Postgres via Postgres.app ...'
  echo '##### To Downloads folder'
  cd ~/Downloads
  echo '##### curl -O https://github.com/PostgresApp/PostgresApp/releases/download/9.3.5.2/Postgres-9.3.5.2.zip'
  curl -O https://github.com/PostgresApp/PostgresApp/releases/download/9.3.5.2/Postgres-9.3.5.2.zip
  echo '##### Open that zip'
  open Postgres-9.3.5.2.zip
  echo '##### Moving to Applications dir'
  mv ~/Downloads/Postgres.app /Applications/Postgres.app
  echo '##### Starting Postgres'
  open Postgres.app
fi

# install postgres gem
pg_gem=`gem list pg`
if [[ ! $pg_gem ]]; then
  echo ''
  echo '##### Installing PG Gem ...'
  gem install pg
fi
