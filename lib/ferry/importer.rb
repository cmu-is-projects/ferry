require_relative 'utilities'

module Ferry
  class Importer < Utilities
    def row_sql_format(hash, columns)
      values = hash.values_at(*columns)
      values.map! do |value|
        value = ActiveRecord::Base::sanitize(value)
      end
      "(#{values.join(",")})"
    end

    def insert_sql(model, columns, values)
      col_names_sql = "(#{columns.join(",")})"
      model_sql = model.downcase
      sql_insert_beg = "INSERT INTO #{model_sql} #{col_names_sql} VALUES "
      ActiveRecord::Base.connection.begin_db_transaction
        values.each_slice(1000) do |records|
          sql_statement = sql_insert_beg + records.join(",") + ";"
          ActiveRecord::Base.connection.execute(sql_statement)
        end
      ActiveRecord::Base.connection.commit_db_transaction
    end

    def import(environment, model, filename)
      db_connect(environment)
      if(File.extname(filename) != ".csv")
        puts "Import aborted -- only csv import is supported"
        return false
      end
      lines = CSV.read(filename)
      if(lines.nil?)
        puts "Import aborted -- file not found"
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
        values << row_sql_format(record, col_names)
        import_bar.inc
      end
      insert_sql(model, col_names, values)
      puts ""
      puts "csv imported to #{model} table"
    end
  end
end
