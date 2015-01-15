#!/bin/bash
# have necessary databases created
mysql -e 'create database ferry_test;'
psql -c 'create database ferry_test;' -U postgres
# run tests
bundle exec rspec
