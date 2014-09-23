namespace :db do
  desc "Dump schema and data to db/schema.rb and db/data.yml"
  task(:dump => [ "db:schema:dump", "db:data:dump" ])

  namespace :data do
	    def db_dump_data_file (extension = "yml")
	      "#{dump_dir}/data.#{extension}"
	    end

	    desc "Dump contents of database to db/data.extension (defaults to yaml)"
	    task :dump => :environment do
	      # format_class = ENV['class'] || "YamlDb::Helper"
	      # helper = format_class.constantize
	      # SerializationHelper::Base.new(helper).dump db_dump_data_file helper.extension
	      puts "yolo"
	    end
	end
end
