require 'active_record'
require 'csv'
require 'ferry/version'
require 'yaml'

module Ferry
  class Exporter
    def which_db_env
      ARGV[0]
    end
    def to_csv
      info = YAML::load(IO.read("config/database.yml"))
      db_type = info[which_db_env]["adapter"]
      case db_type
      when "sqlite3"
        puts "operating with sqlite3"
        homedir = "ferry_to_csv_#{which_db_env}"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        FileUtils.mkdir homedir unless Dir[homedir].present?

        ActiveRecord::Base.connection.tables.each do |model|
          full_table = ActiveRecord::Base.connection.execute('SELECT * FROM '+model+';')
          # do not create a csv for an empty table
          if !full_table[0].nil?
            CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
              size = full_table[0].length / 2
              keys = full_table[0].keys.first(size)

              #first row contains column names
              csv << keys

              full_table.each do |row|
                csv << row.values_at(*keys)
              end
            end
          end
        end
      when "postgresql"
        puts "operating with postgres"
      when "mysql"
        puts "operating with mysql"
      else
        puts "Unknown db type or no database associated with this application."
      end
    end
  end
end
