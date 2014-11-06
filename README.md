![ferry](doc/ferry_readme_icon_2.png)

<!-- ![Build Status](https://travis-ci.org/cmu-is-projects/ferry.png)(https://travis-ci.org/cmu-is-projects/ferry) -->

## What is Ferry?
Ferry is a command-line tool rubygem designed for for data migrations and manipulation, maintained as an open-source project by the students of [Carnegie Mellon's Information Systems department](http://www.cmu.edu/information-systems/) currently [Anthony Corletti](http://github.com/anthcor) and [Logan Watanabe](http://github.com/loganwatanabe). The inspiration for ferry was brought from collective internship experiences and from the growing prevalence of big data migration and manipulation challenges that companies, corporations, universities, and organizations face in today's information age.

## What can I use Ferry for? (Use Cases)
See the [ferry_demo](http://github.com/cmu-is-projects/ferry_demo.com) app or our [GitHub pages site](http://cmu-is-projects.github.com/ferry) for guidance on using Ferry!

Migration and Manipulation use cases
  - Exporting data to various file formats (.csv, .yml, .sql)
  - Importing data from various file formats
  - Migrating data to third party hosts (Amazon S3, Oracle)
  - Migrating data to a different database

## Some current development items
#### Please feel free to open an issue or pull request with your suggestions
- Database-switcher guide tool
- 3rd party connections
- Allowing user to write own rake tasks (e.g. importing and exporting data to S3 or related services)
- Rolling back on errors or mishaps during migrations and manipulations
- Host API and docs via GitHub pages

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
