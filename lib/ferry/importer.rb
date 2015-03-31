require_relative 'utilities'

module Ferry
  # TODO
  # things to consider for importer
  # - columns not matching and handling those errors
  class Importer < Utilities

    def row_sql_format(hash, columns, adapter)
      values = hash.values_at(*columns)
      values.map! do |value|
        if(adapter=="mysql2" && (value=='t' || value =='f'))
          value=='t' ? value=1 : value=0
        end
        value = ActiveRecord::Base::sanitize(value)
      end
      "(#{values.join(",")})"
    end

    def insert_sql(model, columns, values)
      col_names_sql = "(#{columns.join(",")})"
      model_sql = model.downcase
      sql_insert_beg = "INSERT INTO #{model_sql} #{col_names_sql} VALUES "
      ActiveRecord::Base.transaction do
        values.each_slice(500) do |records|
          sql_statement = sql_insert_beg + records.join(",") + ";"
          ActiveRecord::Base.connection.execute(sql_statement)
        end
      end
    end

    def import_csv(environment, model, filename)
      if(File.extname(filename) != ".csv")
        raise "Please choose a csv file"
        return false
      end
      db_connect(environment)
      adapter = YAML::load(IO.read("config/database.yml"))[environment]["adapter"]
      lines = CSV.read(filename)
      if(lines.nil?)
        raise "#{filename} file not found"
        return false
      end
      import_bar = ProgressBar.new("import", lines.length-1)
      col_names = lines.shift
      records = []
      lines.each do |line|
        record = Hash[col_names.zip line]
        records << record
      end
      values = []
      records.map do |record|
        values << row_sql_format(record, col_names, adapter)
        import_bar.inc
      end
      insert_sql(model, col_names, values)
      puts ""
      puts "csv imported to #{model} table"
    end

    def import_json(environment, model, filename)
      if(File.extname(filename) != ".json")
        raise "Please choose a json file"
        return false
      end
      db_connect(environment)
      adapter = YAML::load(IO.read("config/database.yml"))[environment]["adapter"]
      file = File.read(filename)
      column_titles = JSON.parse(file).first.keys
      data = JSON.parse(file)
      import_bar = ProgressBar.new("import", data.length-1)
      records = []
      data.each do |record|
        record = Hash[record]
        records << record
      end
      values = []
      records.map do |record|
        values << row_sql_format(record, column_titles, adapter)
        import_bar.inc
      end
      insert_sql(model, column_titles, values)
      puts ""
      puts "json imported to #{model} table"
    end

  end
end
