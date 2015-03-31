require_relative 'utilities'

module Ferry
  class Dumper < Utilities

    @dbenv = db_connect(environment)
    @dbname = YAML::load(IO.read("config/database.yml"))[@dbenv]["database"]
    @outfile = "#{@dbenv}_outfile"
    @commands = { "sqlite3" => "sqlite3 .dump > #{@outfile}",
                  "postgresql" => "pg_dump #{@dbname} > #{@outfile}",
                  "mysql2" => "mysqldump #{@dbname} > #{@outfile}"
                }

    def dump(environment)
      if check_db_valid(@dbenv)
        create_dirs
        execute
      else
        raise "#{@dbenv} is not supported by ferry at this time"
        return false
      end
    end

    def create_dirs
      FileUtils.mkdir "db" unless Dir["db"].present?
      FileUtils.mkdir "db/sql_dumps" unless Dir["db/sql_dumps"].present?
      @homedir = "db/sql_dumps/#{@dbenv}"
      FileUtils.mkdir @homedir unless Dir[@homedir].present?
    end

    def check_if_valid_request(db)
      %w[sqlite3 postgresql mysql2].include(db) ? true : false
    end

    def execute
      %x(#{@commands[@dbenv]})
    end

  end
end
