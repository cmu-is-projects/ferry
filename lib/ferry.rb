require "ferry/version"
require "csv"
require 'active_record'
require 'fileutils'
require 'yaml'

module Ferry
  class Export
    def to_csv()
      # this holds all the db config information. pretty much a rosetta stone for dbs
      info = YAML::load(IO.read("config/database.yml"))
      # this tells us the db rails is using
      db_type = info["production"]["adapter"]

      case db_type
        when "its sqlite3"
          puts "operating with sqlite3"
          info.keys.each do |environment|
            # in Rails 4.1+ environments inherit from default, which does not have database so we will not include it
            if(environment == 'default')
              next
            end
            # creating a 'csv' folder in the 'db' folder
            # connect to sqlite3 file
            ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: info[environment]['database'])
            unless(Dir.exists?('db/csv'))
              Dir.mkdir('db/csv')
              puts 'db/csv created'
            end
            # creating folders for each file (dev, test, prod, etc)
            unless(Dir.exists?('db/csv/'+environment))
              Dir.mkdir('db/csv/'+environment)
              puts 'db/csv/'+environment+' created'
            end
            # for each model in the db get all the records
            ActiveRecord::Base.connection.tables.each do |model|
              everything = ActiveRecord::Base.connection.execute('SELECT * FROM '+model+';')
              # do not create a csv for an empty table
              if everything[0].nil?
                next
              end
              # create a csv for each table, titled 'model.csv'
              CSV.open("db/csv/"+environment+"/"+model+".csv", "w") do |csv|
                size = everything[0].length / 2
                keys = everything[0].keys.first(size)

                #first row contains column names
                csv << keys

                everything.each do |row|
                  #subsequent rows hold record values
                  csv << row.values_at(*keys)
                end
              end
            end
          end

        when "mysql"
          puts "its mysql"

        when "postgresql"
          puts "its postgres"
          puts info.keys

          info.keys.each do |environment|

            #in Rails 4.1+ environments inherit from default, which does not have database so we will not include it
            if(environment == 'default')
              next
            end

            ActiveRecord::Base.establish_connection(
              adapter:  'postgresql',
              host:     info[environment]['host'] || 'localhost',
              username: info[environment]['username'],
              password: info[environment]['password'],
              database: info[environment]['database'],
              encoding: info[environment]['encoding']
            )

            #creating a 'csv' folder in the 'db' folder
            unless(Dir.exists?('db/csv'))
              Dir.mkdir('db/csv')
              puts 'db/csv created'
            end

            #creating folders for each file (dev, test, prod, etc)
            unless(Dir.exists?('db/csv/'+environment))
              Dir.mkdir('db/csv/'+environment)
              puts 'db/csv/'+environment+' created'
            end

            puts ActiveRecord::Base.connection.tables
            #for each model in the db get all the records
            ActiveRecord::Base.connection.tables.each do |model|
              everything = ActiveRecord::Base.connection.execute('SELECT * FROM '+model+';')
              #do not create a csv for an empty table
              if everything[0].nil?
                next
              end
              #create a csv for each table, titled 'model.csv'
              CSV.open("db/csv/"+environment+"/"+model+".csv", "w") do |csv|

                size = everything[0].length / 2
                keys = everything[0].keys.first(size)

                #first row contains column names
                csv << keys

                #subsequent rows hold record values
                everything.each do |row|
                  csv << row.values_at(*keys)
                end
              end
            end

module Ferry
  class ActiveRecord::Relation
    def migrate(options, &block)
      options[:max_workers] ||= 4
      options[:batch_size]  ||= 10_000

      log = Logger.new()

      active_workers = []
      collection = self
      collection.find_in_batches(batch_size: options[:batch_size]) do |batch|
        if active_workers.length >= options[:max_workers]
          log.write "active_workers oversized at capacity of #{active_workers.length}/#{options[:max_workers]}"
          finished_process = Process.wait
          log.write "finished_process: #{finished_process}"
          active_workers.delete finished_process
          log.write "active_workers capacity now at: #{active_workers.length}/#{options[:max_workers]}"
        else
          active_workers << fork do
            ActiveRecord::Base.connection.reconnect!
            log.write "kicking off engine on batch(#{batch.first}-#{batch.last})"
            engine = Engine.new()
            engine.run({log: log, batch: batch}, &block)
          end
        else
          puts "unknown db type"
        end
      end
    end
  end
end
