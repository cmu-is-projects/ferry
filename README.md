![ferry](doc/ferry_readme_icon.png)

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

### Datebase to CSV
Currently, Ferry supports SQLite, PosgreSQL, and MySQL database connections  ...
Making a simple call like ```ferry to_csv yourdbenvironment``` in any Rails app and Ferry will place a folder in your lib directory with a folder titled ferry_to_csv_yourdbenvironment.

## TO-DOs
- [ ] Refactoring before public release October 17th!!!
- [ ] TEST!!! EVERYTHING!!!
  - [ ] Provide working example(s) of using ferry (see [ferry_demo](http://github.com/cmu-is-projects/ferry_demo.com) app)
- [ ] ferry --help
- [ ] CLI tool dev
- [ ] Simple CSV export & import
  - [x] using sqlite3
  - [x] using psql
  - [x] using MySQL
  - [ ] using other dbs ...
- [ ] Simple YAML export & import
- [ ] Forking processes to make them faster!
- [ ] RESTful column interaction
- [ ] 3rd party connections (importing and exporting data to S3 or related services)
  - [ ] Understanding relationships between generating migrations and migration files in place
- [ ] Rolling back on errors / mishaps during migrations and manipulations
  - [ ] Host documentation site via GitHub pages (ferry.github.io)

## Installation
Add this line to your application's Gemfile:
``` ruby
gem 'ferry'
```

And then execute:
``` sh
bundle
```

Or install it yourself as:
``` sh
gem install ferry
```

To view what Ferry can do for you just run:
``` sh
ferry --help
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ferry/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
