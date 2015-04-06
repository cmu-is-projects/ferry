require_relative 'utilities'

module Ferry
  class Filler < Utilities

    def fill(environment, content)
      # check to make sure db exists
      # drop database
      # prompt user to confirm that they will erase the current env db and refill
      # fill
      @dbadapter = db_connect(environment)
      @dbenv = environment
      @dbname = YAML::load(IO.read("config/database.yml"))[@dbenv]["database"]
      @filepath = content
      @commands = { "sqlite3" => "cat #{@filepath} | sqlite3 #{@dbname}.db",
                    "postgresql" => "psql -d #{@dbname} -f #{@filepath}",
                    "mysql2" => "mysql -p #{@dbname} < #{@filepath}"
                  }
      if check_valid_db(@dbadapter) && check_valid_filetype(@filepath)
        execute(@commands[@dbadapter])
        p "Complete!"
      else
        raise "Dump failed: Check to make sure #{@filepath} exists and is the proper type and that #{@dbenv} is supported in our documentation."
        return false
      end
    end

  end
end
