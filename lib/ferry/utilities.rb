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
end
