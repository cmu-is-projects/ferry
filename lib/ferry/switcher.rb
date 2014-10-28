require_relative 'utilities'

module Ferry
  class Switcher < Utilities
    def to_new_db_type
      info = YAML::load(IO.read("config/database.yml"))
      current_db_type = info[which_db_env]["adapter"]
      puts "switching the #{which_db_env} database's adapter"
      puts "current_db_type: #{current_db_type}"
      puts "to_new_db_type: #{switch_to_db_type}"
      if ['sqlite', 'postgresql', 'mysql'].include?(switch_to_db_type)
        info[which_db_env]["adapter"] = switch_to_db_type
        puts "switching #{which_db_env} env to #{switch_to_db_type} ... "
        File.open("config/database.yml", "w") {|f| f.write info.to_yaml}
        puts "switched #{which_db_env} env to #{switch_to_db_type}"
      else
        puts "#{switch_to_db_type} is currently unsupported"
      end
    end
  end
end
