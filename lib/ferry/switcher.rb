require_relative 'utilities'

module Ferry
  class Switcher < Utilities
    def to_new_db_type(which_db_env, switch_to_db_type)
      if ['sqlite', 'postgresql', 'mysql'].include?(switch_to_db_type)
        info = YAML::load(IO.read("config/database.yml"))
        current_db_type = info[which_db_env]["adapter"]
        puts "switching the #{which_db_env} database's adapter"
        puts "current_db_type: #{current_db_type}"
        puts "to_new_db_type: #{switch_to_db_type}"
        if ['postgresql', 'mysql'].include?(switch_to_db_type)
          info[which_db_env]["adapter"] = switch_to_db_type
          puts "switching #{which_db_env} env to #{switch_to_db_type} ... "
          File.open("config/database.yml", "w") {|f| f.write info.to_yaml}
          puts "switched #{which_db_env} env to #{switch_to_db_type} in database.yml"
          call = %x(bundle show ferry).chomp
          %x(chmod 4755 #{call}/script/#{switch_to_db_type}_install.sh)
          %x(#{call}/script/#{switch_to_db_type}_install.sh)
          puts "installed necessary dependencies for #{which_db_env} env to #{switch_to_db_type}"
        elsif switch_to_db_type == 'sqlite'
          puts "#{switch_to_db_type} already installed on mac!"
        else
          puts "#{switch_to_db_type} is currently unsupported"
        end
      end
    end
  end
end
