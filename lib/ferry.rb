require "ferry/version"
require "csv"
require 'active_record'
require 'fileutils'
require 'yaml'
require 'ferry/tasks'

module Ferry
  class Exporter
    def to_csv()
      # this holds all the db config information. pretty much a rosetta stone for dbs
      info = YAML::load(IO.read("config/database.yml"))
      # this tells us the db rails is using
      db_type = info["production"]["adapter"]
      case db_type
        when "its sqlite3"
          puts "operating with sqlite3"
        when "mysql"
          puts "its mysql"
        when "postgresql"
          puts "its postgres"
        else
          puts "Unknown db type or no database associated with this application."
        end
      end
    end
  end
end
