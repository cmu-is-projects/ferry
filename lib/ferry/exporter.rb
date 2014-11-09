require_relative 'utilities'

module Ferry
  class Exporter < Utilities
    def to_csv(environment, model)
      db_type = db_connect(environment)
      FileUtils.mkdir "db" unless Dir["db"].present? #to help with tests
      FileUtils.mkdir "db/csv" unless Dir["db/csv"].present?
      homedir = "db/csv/#{environment}"
      FileUtils.mkdir homedir unless Dir[homedir].present?
      table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};") #error raised here if no table
      CSV.open("#{homedir}/#{model}.csv", "w") do |csv|
        case db_type
        when 'sqlite3'
          csv_bar = ProgressBar.new("to_csv", table.length)
          keys = table[0].keys.first(table[0].length / 2)
          csv << keys
          table.each do |row|
            csv << row.values_at(*keys)
            csv_bar.inc
          end
        when 'postgresql'
          csv_bar = ProgressBar.new("to_csv", table.num_tuples)
          keys = table[0].keys
          csv << keys
          table.each do |row|
            csv << row.values_at(*keys)
            csv_bar.inc
          end
        when 'mysql2'
          csv_bar = ProgressBar.new("to_csv", table.count)
          db_config = YAML::load(IO.read("config/database.yml"))
          columns = ActiveRecord::Base.connection.execute("SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_SCHEMA`= '#{db_config[environment]['database']}' AND `TABLE_NAME`='#{model}';")
          col_names=[]
          columns.each do |col|
            col_names.append(col[0])
          end
          csv << col_names
          table.each do |row|
            csv << row
            csv_bar.inc
          end
        else
          raise "#{db_type} is not supported by ferry at this time"
          return false
        end
      end
      puts ""
      puts "exported to db/csv/#{environment}"
    end

    def to_yaml(environment, model)
      db_type = db_connect(environment)
      FileUtils.mkdir "db" unless Dir["db"].present? #to help with tests
      FileUtils.mkdir "db/yaml" unless Dir["db/yaml"].present?
      homedir = "db/yaml/#{environment}"
      FileUtils.mkdir homedir unless Dir[homedir].present?
      table = ActiveRecord::Base.connection.execute("SELECT * FROM #{model};") #error raised here is no table
        db_object = {}
        db_output = {}
        case db_type
          when 'sqlite3'
            yaml_bar = ProgressBar.new("to_csv", table.length)
            keys = table[0].keys.first(table[0].length / 2)
            db_object["columns"] = keys
            model_arr=[]
            table.each do |row|
              model_arr << row.values_at(*keys)
              yaml_bar.inc
            end
            db_object["records"] = model_arr
            db_output[model] = db_object
            File.open("#{homedir}/#{model}.yml",'a') do |file|
              YAML::dump(db_output, file)
            end
          when 'postgresql'
            yaml_bar = ProgressBar.new("to_csv", table.num_tuples)
            keys = table[0].keys
            db_object["columns"] = keys
            model_arr=[]
            table.each do |row|
              model_arr << row.values_at(*keys)
              yaml_bar.inc
            end
            db_object["records"] = model_arr
            db_output[model] = db_object
            File.open("#{homedir}/#{model}.yml",'a') do |file|
              YAML::dump(db_output, file)
            end
          when 'mysql2'
            yaml_bar = ProgressBar.new("to_csv", table.count)
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
              yaml_bar.inc
            end
            db_object["records"] = model_arr
            db_output[model] = db_object
            File.open("#{homedir}/#{model}.yml",'a') do |file|
              YAML::dump(db_output, file)
            end
          else
            puts "error in db type"
            return false
        end
      puts ""
      puts "exported to db/yaml/#{environment}"
    end
  end
end
