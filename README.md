![ferry](doc/ferry_readme_icon_2.png)

[![Build Status](https://travis-ci.org/cmu-is-projects/ferry.svg?branch=master)](https://travis-ci.org/cmu-is-projects/ferry)
[![Gem Version](https://badge.fury.io/rb/ferry.svg)](http://badge.fury.io/rb/ferry)

## What is Ferry?
Ferry is a command-line tool rubygem designed for Rails data migrations and manipulation, primarily maintained as an open-source project by the students of [Carnegie Mellon's Information Systems department](http://www.cmu.edu/information-systems/) since August 2014. The inspiration for ferry was brought from collective internship experiences and from the growing prevalence of big data migration and manipulation challenges that companies, corporations, universities, and organizations face in today's information age. A large thanks in part to [CustomInk's Technology Team](https://github.com/customink) and their [blog articles](http://technology.customink.com) for advice and guidance during the first semester (Fall 2014) of development.

## What can I use Ferry for?
See the [ferry_demo](http://github.com/cmu-is-projects/ferry_demo) app or our [GitHub pages site](http://cmu-is-projects.github.com/ferry) for further documentation on using Ferry!

Rails Migration and Manipulation use cases
  - Exporting data to various file formats (.csv, .yml, .sql)
  - Importing data from various file formats
  - Migrating data to third party hosts (Amazon S3, Oracle)
  - Migrating data to a different database

Coming soon ...
  - Configurable Migration Scripting
    - The idea behind this feature is for developers to provide options for arguments in an executable script that contains the configuration and necessary tasks/ actions for the operations of whatever data migration or manipulation they are seeking to carry out.
    - Similar to how [capistrano](https://github.com/capistrano/capistrano) configures deploy.rb.
  - Data Visualization
    - With inspiration from [d3](http://d3js.org), we are hoping to create functionality that allows developers to deploy informative and visually appealing graphs and documents that can be shared over an internal network to be broadcasted to servers for display either on internal office displays or to URL's ... all from executing a simple command-line statement.
    - We will be making use of [d3](http://d3js.org) for visualizations and are looking for current solutions to this business need and if there are any successful or not-so-successful solutions out there to compete with.

## Some current development items
#### Please feel free to open an issue or pull request with your suggestions
- Database-switcher guide tool
- 3rd party connections
- Configurability
  - Allowing user to write own rake tasks (e.g. importing and exporting data to S3 or related services)
- Rolling back on errors or mishaps during migrations and manipulations

## Installation
Add this line to your Rails application's Gemfile:
``` ruby
gem 'ferry'
```

And then execute:
``` sh
$ bundle
```

Or install it yourself as:
``` sh
$ gem install ferry
```

To view what Ferry can do for you just run:
``` sh
$ ferry --help
```

## Exporting
Ferry can export data from a database connected to a Rails app into a CSV or YAML file.
We currently only support exporting of SQLite3, MySQL2, and PostgreSQL databases.

Run `ferry --to_csv [environment] [table]` in your Rails directory to export to csv:
```sh
$ ferry --to_csv production users
```
Running the above command will export the "users" table from the database connected to the "production" environment.
A csv file populated with the "users" table data will be created at /db/csv/test/users.csv (the path will be created and if there is a users.csv it will be overwritten).

Run `ferry --to_yaml [environment] [table]` in your Rails directory to export to yaml:
```sh
$ ferry --to_yaml development users
```
Similarly, running the above command in the Rails directory will export the "users" table from the database connected to the "development" environment.
A yaml file populated with the "users" table data will be created at /db/yaml/test/users.csv (the path will be created and if there is a users.csv it will be overwritten).

## Importing
Ferry can import a csv file of validated records into a table of a Rails-connected database.
The csv file must:
  - Have headers that match field names of the table
  - Have values that meet the table's constraints (i.e. required fields, correct data types, unique PKs, etc.)

Run `ferry --import [environment] [table] [file path]` in your Rails directory to import a csv to a database table:
```sh
$ ferry --import development users db/csv/import_data.csv
```
Running the above command will import the import_data.csv to the "users" table in the "development" environment.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/ferry/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

If you wish to open a pull request or issue for anything at all please feel free to do so!

A large driving factor in the development of Ferry is contributing something meaningful to the open-source community and the developer community at large. Being college students who have access to such an unbelievable amount of developement resources for creating cool projects, we felt a need to give back - we wanted to start a project that would face unique challenges such that others who face similar challenges could turn to us for help and guidance. We hope that Ferry continues to be a project that both provides benefit to businesses and developers along with giving back to the open-source and greater developer community.
