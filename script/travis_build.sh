#!/bin/bash
mysql -e 'create database ferry_test;'
psql -c 'create database ferry_test;' -U postgres
bundle exec rspec
