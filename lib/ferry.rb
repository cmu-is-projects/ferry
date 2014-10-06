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
      ARGV[2]
    end

    def to_csv
      info = YAML::load(IO.read("config/database.yml"))
      db_type = info[which_db_env]["adapter"]
      case db_type
      when "sqlite3"
        puts "operating with sqlite3"
        homedir = "lib/ferry_to_csv_#{which_db_env}"
        ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        sqlite_pbar = ProgressBar.new("sqlite_to_csv", 100)
        ActiveRecord::Base.connection.tables.each do |model|
          full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
          if !full_table[0].nil?
            CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
              size = full_table[0].length / 2
              keys = full_table[0].keys.first(size)
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
          if full_table.num_tuples > 0
            CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
              size = full_table[0].length / 2
              keys = full_table[0].keys.first(size)
              csv << keys
              full_table.each do |row|
                csv << row.values_at(*keys)
                psql_pbar.inc
              end
            end
          end
        end
      when "mysql2"
        puts "operating with mysql2"
        homedir = "lib/ferry_to_csv_#{environment}"
        puts "connected to #{which_db_env} env db"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{environment} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        mysql_bar = ProgressBar.new("psql_to_csv", 100)
        ActiveRecord::Base.connection.tables.each do |model|
          columns = ActiveRecord::Base.connection.execute(
            "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS`
            WHERE `TABLE_SCHEMA`= '#{info[environment]['database']}' AND `TABLE_NAME`='#{model}';")
          CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
            col_names=[]
            columns.each do |col|
              col_names.append(col[0])
            end
            csv << col_names
            full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
            full_table.each do |row|
              csv << row
              mysql_bar.inc
            end
          end
        end
      when "mongo"
        puts "mongo is currently unsupported"
      else
        puts "Unknown db type or no database associated with this application."
      end
    end

    def to_new_db_type
      info = YAML::load(IO.read("config/database.yml"))
      current_db_type = info[which_db_env]["adapter"]
      puts "switching the #{which_db_env} database's adapter"
      puts "current_db_type: #{current_db_type}"
      puts "to_new_db_type: #{switch_to_db_type}"

      if ['sqlite', 'postgresql', 'mysql'].include?(switch_to_db_type)
        info[which_db_env]["adapter"] = switch_to_db_type
        File.open("config/database.yml", "w") {|f| f.write info}
      end

    end
  end
end
