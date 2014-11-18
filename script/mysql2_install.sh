#!/bin/bash

# install mysql
mysql=`brew list | grep mysql`
if [[ ! $mysql ]]; then
  echo ''
  echo '##### Installing Formula Mysql via homebrew ...'
  brew install mysql
  echo '##### starting local mysql server'
  mysql.server start
fi

# install postgres gem
mysql_gem=`gem list mysql2`
if [[ ! $mysql_gem ]]; then
  echo ''
  echo '##### Installing Mysql2 Gem ...'
  gem install mysql2
fi
