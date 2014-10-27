module Ferry
  class Exporter < Utilities
    def environment
      ARGV[1]
    end

    def to_csv()
      db_type = db_connect(environment)
      FileUtils.mkdir "db/csv" unless Dir["db/csv"].present?
      homedir = "db/csv/#{environment}"
      FileUtils.mkdir homedir unless Dir[homedir].present?

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
      end #model
      puts "exported to db/csv/#{environment}"
    end

    def to_yaml()
      db_type = db_connect(environment)
      FileUtils.mkdir "db/yaml" unless Dir["db/yaml"].present?
      homedir = "db/yaml/#{environment}"
      FileUtils.mkdir homedir unless Dir[homedir].present?

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
      end #models
      puts "exported to db/yaml/#{environment}"
    end

    def export_to_service(*args)
      # exporting to services like AWS
    end

  end
end
