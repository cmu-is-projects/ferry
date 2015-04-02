require_relative 'utilities'

module Ferry
  class Dumper < Utilities

    def dump(environment)
      @dbadapter = db_connect(environment)
      @dbenv = environment
      @dbname = YAML::load(IO.read("config/database.yml"))[@dbenv]["database"]
      @outfile_path = "db/sql_dumps/#{@dbname}/#{@dbadapter}/#{@dbenv}/dumpfile.sql"
      @commands = { "sqlite3" => "sqlite3 db/#{@dbenv}.sqlite3 .dump > #{@outfile_path}",
                    "postgresql" => "pg_dump #{@dbname} > #{@outfile_path}",
                    "mysql2" => "mysqldump #{@dbname} > #{@outfile_path}"
                  }
      if check_valid_db(@dbadapter)
        create_dirs
        execute(@commands[@dbadapter])
        p "Complete!"
      else
        raise "Dump failed :: #{@dbadapter} is not supported by ferry at this time"
        return false
      end
    end

    def create_dirs
      homedir = "db/sql_dumps/#{@dbname}/#{@dbadapter}/#{@dbenv}"
      FileUtils.mkpath homedir unless Dir[homedir].present?
      FileUtils.touch(@outfile_path) unless File.exist?(@outfile_path)
    end

    def check_valid_db(db)
      %w[sqlite3 postgresql mysql2].include?(db) ? true : false
    end

    def execute(command)
      `#{command}`
    end

  end
end
