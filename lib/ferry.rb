require 'active_record'
require 'csv'
require 'ferry/version'
# require 'progressbar'
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
      db_type = info[which_db_env||"production"]["adapter"]



      #issues:
      #   csv placement in directory:  do we want it in the lib?
      #   the case where dev/test dbs are different from production db (sqlite for dev/test, pg for prod??)
      #   empty ARGs
      #   ARGs with invalid values


      case db_type
      when "sqlite3"
        puts "operating with sqlite3"

        if(which_db_env)
          lite_exporter(which_db_env, info)
        else #no db_env is specified
          info.keys.each do |environment|

            if(environment == 'default')  #in Rails 4.1+ environments inherit from default, which does not have database so we will not include it
              next
            end
            lite_exporter(environment, info)
          end
        end

      when "postgresql"
        puts "operating with postgres"

        if(which_db_env)
          pg_exporter(which_db_env, info)
        else
          info.keys.each do |environment|

            if(environment == 'default')  #in Rails 4.1+ environments inherit from default, which does not have database so we will not include it
              next
            end
            pg_exporter(environment, info)
          end
        end

      when "mysql2"
        puts "operating with mysql2"

        if(which_db_env)
          mysql_exporter(which_db_env, info)
        else
          info.keys.each do |environment|

            if(environment == 'default')  #in Rails 4.1+ environments inherit from default, which does not have database so we will not include it
              next
            end

            mysql_exporter(environment, info)

          end
        end  
      when "mongo"
        puts "mongo is currently not supported"
      else
        puts "Unknown db type or no database associated with this application."
      end
    end





    def mysql_exporter(environment, info)
      homedir = "lib/ferry_to_csv_#{environment}"
      ActiveRecord::Base.establish_connection(    #this may not work on default rails if production db is not created (must run rake db:create:all)
        adapter:  'mysql2',
        host:     info[environment]['host'] || 'localhost', 
        username: info[environment]['username'], 
        password: info[environment]['password'], 
        database: info[environment]['database']
      )
      puts "connected to #{environment} env db"
      FileUtils.mkdir homedir unless Dir[homedir].present?
      puts "exporting tables to #{homedir}"
      # psql_pbar = ProgressBar.new("psql_to_csv", 100)

      ActiveRecord::Base.connection.tables.each do |model|                              #for each model in the db
        columns = ActiveRecord::Base.connection.execute("SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`= '#{info[environment]['database']}' AND `TABLE_NAME`='#{model}';")
        CSV.open("#{homedir}/#{model}.csv", "w") do |csv|

          col_names=[]
          columns.each do |col|
            col_names.append(col[0])  #append the column names to an array, makes for good formatting
          end
          csv << col_names  #first csv row is of column names

          full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
          full_table.each do |row|
            csv << row  #not sure if this will hold, but no 'values_at' method exists
            # psql_pbar.inc
          end
        end
      end
    end

    def pg_exporter(environment, info)
      homedir = "lib/ferry_to_csv_#{environment}"
      ActiveRecord::Base.establish_connection(
        adapter:  'postgresql', 
        host:     info[environment]['host'] || 'localhost', 
        username: info[environment]['username'], 
        password: info[environment]['password'], 
        database: info[environment]['database'], 
        encoding: info[environment]['encoding']
      )
      puts "connected to #{environment} env db"
      FileUtils.mkdir homedir unless Dir[homedir].present?
      puts "exporting tables to #{homedir}"
      # psql_pbar = ProgressBar.new("psql_to_csv", 100)
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
              # psql_pbar.inc
            end
          end
        end
      end
    end

    def lite_exporter(environment, info)
      homedir = "lib/ferry_to_csv_#{environment}"
      ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: info[environment]['database'])  #connect to sqlite3 file
      puts "connected to #{environment} env db"
      FileUtils.mkdir homedir unless Dir[homedir].present?
      puts "exporting tables to #{homedir}"
      # sqlite_pbar = ProgressBar.new("sqlite_to_csv", 100)
      ActiveRecord::Base.connection.tables.each do |model|                                #for each model in the db
        full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")    #get all the records
        if !full_table[0].nil?
          CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
            size = full_table[0].length / 2
            keys = full_table[0].keys.first(size)
            #first row contains column names
            csv << keys
            full_table.each do |row|
              csv << row.values_at(*keys)
              # sqlite_pbar.inc
            end
          end
        end
      end
    end







    def to_new_db_type
      info = YAML::load(IO.read("config/database.yml"))
      current_db_type = info[which_db_env]["adapter"]
      puts "switching the #{which_db_env} database's adapter"
      puts "current_db_type: #{current_db_type}"
      puts "to_new_db_type: #{switch_to_db_type}"

      # check for dependencies
      # if dependencies exist - install them
      # create new connection
      # transfer old db into new connection
      # drop old connection
      # update the config file
      # profit
    end

  end
end
