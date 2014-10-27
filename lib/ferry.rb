require 'active_record'
require 'csv'
require 'ferry/exporter'
require 'ferry/importer'
require 'ferry/utilities'
require 'ferry/version'
require 'progressbar'
require 'optparse'
require 'pp'
require 'yaml'
require 'enumerator'
require 'pp'

module Ferry
  class Utilities
      def db_connect(environment)
      db_config = YAML::load(IO.read("config/database.yml"))
      db_type = db_config[environment]["adapter"]

      if ['sqlite3', 'postgresql', 'mysql2'].include?(db_type)
        ActiveRecord::Base.establish_connection(adapter: db_type, database: db_config[environment]['database'])
        puts "operating with "+db_type
        return db_type
      else
        puts "Unsupported db type or no database associated with this application."
        return false
      end
    end
  end

  class Exporter < Utilities
    def environment
      ARGV[1]
    end


    def to_csv(environment)
      db_type = db_connect(environment)
      FileUtils.mkdir "db/csv" unless Dir["db/csv"].present?
      homedir = "db/csv/#{environment}"
      FileUtils.mkdir homedir unless Dir[homedir].present?

      num_tables = ActiveRecord::Base.connection.tables.length
      pbar = ProgressBar.new("to_csv", num_tables)

      ActiveRecord::Base.connection.tables.each do |model|
        table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
        #check for empty tables?


        CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
          case db_type
            when 'sqlite3'
              keys = table[0].keys.first(table[0].length / 2)
              csv << keys
              table.each do |row|
                csv << row.values_at(*keys)
              end
            when 'postgresql'
              keys = table[0].keys
              csv << keys
              table.each do |row|
                csv << row.values_at(*keys)
              end
            when 'mysql2'
              db_config = YAML::load(IO.read("config/database.yml"))
              columns = ActiveRecord::Base.connection.execute("SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`= '#{db_config[environment]['database']}' AND `TABLE_NAME`='#{model}';")
              col_names=[]
              columns.each do |col|
                col_names.append(col[0])
              end
              csv << col_names
              table.each do |row|
                csv << row
              end
            else
              puts "error in db type"
              return false
          end #case
        end #CSV
        pbar.inc(1)
      end #model
      puts ""
      puts "exported to db/csv/#{environment}"
    end

    def to_yaml()
      db_type = db_connect(environment)
      FileUtils.mkdir "db/yaml" unless Dir["db/yaml"].present?
      homedir = "db/yaml/#{environment}"
      FileUtils.mkdir homedir unless Dir[homedir].present?

      num_tables = ActiveRecord::Base.connection.tables.length
      pbar = ProgressBar.new("to_csv", num_tables)

      ActiveRecord::Base.connection.tables.each do |model|
        table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};")
        db_object = {}
        db_output = {}
        #check for empty tables?

          case db_type
            when 'sqlite3'
              keys = table[0].keys.first(table[0].length / 2)
              db_object["columns"] = keys
              model_arr=[]
              table.each do |row|
                model_arr << row.values_at(*keys)
              end
              db_object["records"] = model_arr
              db_output[model] = db_object
              File.open("#{homedir}/#{environment}_data.yml",'a') do |file|
                YAML::dump(db_output, file)
              end
            when 'postgresql'
              keys = table[0].keys
              db_object["columns"] = keys
              model_arr=[]
              table.each do |row|
                model_arr << row.values_at(*keys)
              end
              db_object["records"] = model_arr
              db_output[model] = db_object
              File.open("#{homedir}/#{environment}_data.yml",'a') do |file|
                YAML::dump(db_output, file)
              end
            when 'mysql2'
              db_config = YAML::load(IO.read("config/database.yml"))
              columns = ActiveRecord::Base.connection.execute("SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`= '#{db_config[environment]['database']}' AND `TABLE_NAME`='#{model}';")
              col_names=[]
              columns.each do |col|
                col_names.append(col[0])
              end
              db_object["columns"] = col_names
              model_arr=[]
              table.each do |row|
                model_arr << row
              end
              db_object["records"] = model_arr
              db_output[model] = db_object
              File.open("#{homedir}/#{environment}_data.yml",'a') do |file|
                YAML::dump(db_output, file)
              end
            else
              puts "error in db type"
              return false
          end #case
          pbar.inc(1)
      end #models
      puts ""
      puts "exported to db/yaml/#{environment}"
    end

    def export_to_service(*args)
      # exporting to services like AWS
    end

  end


  class Importer < Utilities

    def environment
      ARGV[1]
    end

    def row_sql_format(hash, columns)
      values = hash.values_at(*columns)
      values.map! do |value|
        value = ActiveRecord::Base::sanitize(value)
      end
      "(#{values.join(",")})"
    end

    def insert_sql(model, columns, values)
      num_inserts = values.length
      col_names_sql = "(#{columns.join(",")})"
      model_sql = model.downcase #do we need to check if it exists?
      sql_insert_beg = "INSERT INTO #{model_sql} #{col_names_sql} VALUES "

      ActiveRecord::Base.connection.begin_db_transaction  #to ensure that if the insert is done in batches, only carries out if none error
        values.each_slice(1000) do |records|
          sql_statement = sql_insert_beg + records.join(",") + ";"
          ActiveRecord::Base.connection.execute(sql_statement)  #inserts to db
        end
      ActiveRecord::Base.connection.commit_db_transaction
    end

    def import(environment, model, filename)
      db_connect(environment)
      #now connected to activerecord

      if(File.extname(filename) != ".csv")
        puts "Import aborted -- only csv import is supported"
        return false
      end

      lines = CSV.read(filename)
      if(lines.nil?)
        puts "Import aborted -- file not found"
        return false
      end

      pbar = ProgressBar.new("import", lines.length-1)

      col_names = lines.shift #removes the header array from lines

      records = []
      lines.each do |line|
        record = Hash[col_names.zip line]
        records << record
      end

      values = []
      records.map do |record|
        values << row_sql_format(record, col_names)
        pbar.inc
      end

      insert_sql(model, col_names, values)
      puts ""
      puts "csv imported to #{model} table"

    end

  end


end
