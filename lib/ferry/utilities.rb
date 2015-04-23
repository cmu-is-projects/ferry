module Ferry
  class Utilities

    def check_valid_db(db)
      %w[sqlite3 postgresql mysql2].include?(db) ? true : false
    end

    def check_valid_filetype(filepath)
      %w[csv json sql yml].include?(filepath.split('.').last) ? true : false
    end

    def db_connect(environment)
      db_config = YAML::load(IO.read("config/database.yml"))
      if db_config[environment].nil?
        raise "No database associated with #{environment} environment"
      end
      db_type = db_config[environment]["adapter"]
      if ['sqlite3', 'postgresql', 'mysql2'].include?(db_type)
        ActiveRecord::Base.establish_connection(adapter: db_type, database: db_config[environment]['database'])
        puts "operating with "+db_type
        return db_type
      else
        raise "#{db_type} is not supported by ferry at this time"
      end
    end

    def execute(command)
      `#{command}`
    end

    def make_starter_files
      if !File.exist?("lib/tasks/ferry.rake") && !File.exist?("config/captain.rb")
        install_dir = `bundle show ferry`.chomp
        ferryfile_contents = File.open("#{install_dir}/doc/ferryfile_contents.rb", "rb")
        captain_contents = File.open("#{install_dir}/doc/config/captain.rb", "rb")
        File.open("Ferryfile", 'w') {|f| f.write(ferryfile_contents.read)}
        File.open("config/captain.rb", 'w') {|f| f.write(captain_contents.read)}
      else
        puts "hmm the files already exist"
      end
    end

    def print_version
      puts "Ferry #{Ferry::VERSION}"
    end

  end
end
