require 'active_record'
require 'csv'
require 'ferry/version'
require 'progressbar'
require 'yaml'

module Ferry
  class Exporter

    def which_db_env
      ARGV[1]
    end

    def switch_to_db_type
      ARGV[1]
    end

    def to_csv
      info = YAML::load(IO.read("config/database.yml"))
      db_type = info[which_db_env]["adapter"]
      case db_type
      when "sqlite3"
        puts "operating with sqlite3"
        homedir = "lib/ferry_to_csv_#{which_db_env}"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        sqlite_pbar = ProgressBar.new("sqlite_to_csv", 100)
        ActiveRecord::Base.connection.tables.each do |model|
          full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
          # do not create a csv for an empty table
          if !full_table[0].nil?
            CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
              size = full_table[0].length / 2
              keys = full_table[0].keys.first(size)
              #first row contains column names
              csv << keys
              full_table.each do |row|
                csv << row.values_at(*keys)
                sqlite_pbar.inc
              end
            end
          end
        end
      when "postgresql"
        puts "operating with postgres"
        homedir = "lib/ferry_to_csv_#{which_db_env}"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        psql_pbar = ProgressBar.new("psql_to_csv", 100)
        ActiveRecord::Base.connection.tables.each do |model|
          full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
          # do not create a csv for an empty table
          if full_table.num_tuples > 0
            CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
              size = full_table[0].length / 2
              keys = full_table[0].keys.first(size)
              #first row contains column names
              csv << keys
              full_table.each do |row|
                csv << row.values_at(*keys)
                psql_pbar.inc
              end
            end
          end
        end
      when "mysql"
        puts "mysql is currently not supported"
      when "mongo"
        puts "mongo is currently not supported"
      else
        puts "Unknown db type or no database associated with this application."
      end
    end

    def to_new_db_type
      info = YAML::load(IO.read("config/database.yml"))
      current_db_type = info[which_db_env]["adapter"]
      puts "current_db_type: #{current_db_type}"
      puts "to_new_db_type: #{switch_to_db_type}"
    end

  end
end
