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


    #  test to_csv
    #  chekc that all files exist, first and last records match

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
              keys = full_table[0].keys
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
        homedir = "lib/ferry_to_csv_#{which_db_env}"
        puts "connected to #{which_db_env} env db"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        mysql_bar = ProgressBar.new("psql_to_csv", 100)
        ActiveRecord::Base.connection.tables.each do |model|
          columns = ActiveRecord::Base.connection.execute(
            "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS`
            WHERE `TABLE_SCHEMA`= '#{info[which_db_env]['database']}' AND `TABLE_NAME`='#{model}';")
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
        puts "switching #{which_db_env} env to #{switch_to_db_type} ... "
        File.open("config/database.yml", "w") {|f| f.write info.to_yaml}
        puts "switched #{which_db_env} env to #{switch_to_db_type}"
      else
        puts "#{switch_to_db_type} is currently unsupported"
      end

    end

    def to_yaml
      info = YAML::load(IO.read("config/database.yml"))
      db_type = info[which_db_env]["adapter"]
      case db_type
      when "sqlite3"
        puts "operating with sqlite3"
        homedir = "lib/ferry_to_yaml_#{which_db_env}"
        ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        sqlite_pbar = ProgressBar.new("sqlite_to_yaml", 100)
        i = 0
        ActiveRecord::Base.connection.tables.each do |model|
          db_object = {}
          db_output = {}
          full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
          if !full_table[0].nil?
            size = full_table[0].length / 2
            keys = full_table[0].keys.first(size)
            db_object["columns"] = keys
            model_arr=[]
            full_table.each do |row|
              model_arr << row.values_at(*keys)
            end
            db_object["records"] = model_arr
            db_output[model] = db_object
            if i==0
              File.open("#{homedir}/#{which_db_env}_data.yml",'w') do |file|
                YAML::dump(db_output, file)
              end
            else
              File.open("#{homedir}/#{which_db_env}_data.yml",'a') do |file|
                YAML::dump(db_output, file)
              end
            end
            i+=1
          end
        end
        sqlite_pbar.inc
        sqlite_pbar.finish

      when "postgresql"
        puts "operating with postgres"
        homedir = "lib/ferry_to_yaml_#{which_db_env}"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        psql_pbar = ProgressBar.new("psql_to_yaml", 100)

        i = 0
        ActiveRecord::Base.connection.tables.each do |model|
          db_object = {}
          db_output = {}
          full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
          if !full_table[0].nil?
            keys = full_table[0].keys
            db_object["columns"] = keys
            model_arr=[]
            full_table.each do |row|
              model_arr << row.values_at(*keys)
            end
            db_object["records"] = model_arr
            db_output[model] = db_object
            if i==0
              File.open("#{homedir}/#{which_db_env}_data.yml",'w') do |file|
                YAML::dump(db_output, file)
              end
            else
              File.open("#{homedir}/#{which_db_env}_data.yml",'a') do |file|
                YAML::dump(db_output, file)
              end
            end
            i+=1
          end
        end
        psql_pbar.inc
        psql_pbar.finish

      when "mysql2"
        puts "operating with mysql2"
        homedir = "lib/ferry_to_yaml_#{which_db_env}"
        puts "connected to #{which_db_env} env db"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
        FileUtils.mkdir homedir unless Dir[homedir].present?
        puts "exporting tables to #{homedir}"
        mysql_bar = ProgressBar.new("psql_to_yaml", 100)
        i=0
        ActiveRecord::Base.connection.tables.each do |model|
          db_object = {}
          columns = ActiveRecord::Base.connection.execute(
            "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS`
            WHERE `TABLE_SCHEMA`= '#{info[which_db_env]['database']}' AND `TABLE_NAME`='#{model}';")

            col_names=[]
            columns.each do |col|
              col_names.append(col[0])
            end
            db_object["columns"] = col_names
            model_arr=[]
            full_table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
            full_table.each do |row|
              model_arr << row
            end
            db_object["records"] = model_arr
            db_export = {}
            db_export[model] = db_object

            if i==0
              File.open("#{homedir}/#{which_db_env}_data.yml",'w') do |file|
                YAML::dump(db_export, file)
              end
            else
              File.open("#{homedir}/#{which_db_env}_data.yml",'a') do |file|
                YAML::dump(db_export, file)
              end
            end
            i+=1   

        end

        mysql_bar.inc
        mysql_bar.finish

      when "mongo"
        puts "mongo is currently not supported"
      else
        puts "Unknown db type or no database associated with this application."
      end
    end











    def export_to_service(*args)
      # exporting to services like AWS
    end

    
  end


  class Importer

    def which_db_env
      ARGV[1]
    end

    def import(model, filename)
      info = YAML::load(IO.read("config/database.yml"))
      db_type = info[which_db_env]["adapter"]
      # import_pbar = ProgressBar.new("import", 100)

      case db_type
      when "sqlite3"
        ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
      when "postgresql"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
      when "mysql2"
        ActiveRecord::Base.establish_connection(adapter: db_type, database: info[which_db_env]['database'])
        puts "connected to #{which_db_env} env db"
      else
        puts "Unsupported db type or no database associated with this application."
      end
      #now connected to activerecord

      if(File.extname(filename) != ".csv")
        puts "Import aborted -- only csv import is supported"
        return false
      end

      lines = File.new(filename).readlines
      if(lines.nil?)
        puts "Import aborted -- file not found"
        return false
      end

      header = lines.shift.strip
      keys = header.split(',')

      lines.each do |line|
        values = line.strip.split(',')
        attributes = Hash[keys.zip values]
        # puts ActiveRecord::Base.connection.subclasses
        # const = model.classify.constantize
        # const.create(attributes)
        Module.const_get(model).create(attributes)
        # ActiveRecord::Base.connection.const_get(model).create(attributes)
      end




    end

    
  end



end
