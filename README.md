# Ferry

## What is Ferry?
Ferry is a data migration and data manipulation tool that seeks to quickly and easily reduce overhead when dealing with big data problems.

## What can I use Ferry for? (Use Cases)
See the [ferry_demo](http://github.com/cmu-is-projects/ferry_demo.com) ROR/Sqlite app for guidance on using Ferry!

Manipulation Use Cases
  - RESTful column/ row interaction

Migration
  - Exporting data to various file formats (.csv, .sql, .yml)
  - Importing data from various file formats
  - Migrating data to third party hosts (Amazon S3, Oracle)
  - Migrating data to a different database

## TO-DOs
- [ ] Refactoring before public release
- [x] Define action-items for refactor
- [x] Provide working example(s) of using ferry (ferry_demo app)
- [ ] CLI tool
- [ ] Simple CSV export
  - [ ] using sqlite3
  - [ ] using psql
- [ ] RESTful column interaction
  - [ ] Understanding relationships between generating migrations and migration files in place
- [ ] Tests
- [ ] Rolling back on errors / mishaps during migrations and manipulations
  - [ ] Host documentation site via GitHub pages

## Installation
Add this line to your application's Gemfile:

    gem 'ferry'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ferry

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ferry/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
