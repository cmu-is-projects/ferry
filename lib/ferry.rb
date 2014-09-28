require 'active_record'
require 'csv'
require 'fileutils'
require 'ferry/version'
require 'yaml'

module Ferry
  class Exporter
    # this holds all the db config information. pretty much a rosetta stone for dbs
    info = YAML::load(IO.read("config/database.yml"))
    # this tells us the db rails is using
    db_type = info["production"]["adapter"]
    case db_type
    when "its sqlite3"
      puts "operating with sqlite3"
    when "postgresql"
      puts "its postgres"
    when "mysql"
      puts "its mysql"
    else
      puts "Unknown db type or no database associated with this application."
    end
  end
end
