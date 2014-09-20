require "ferry/version"
require "ferry/engine"
require "ferry/logger"
require "csv"
require 'active_record'
require 'fileutils'

module Ferry


  class Export
    def to_csv(db_type)

      # ActiveRecord::Base.connection
      #ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3') #need to automatically get db name

      type = db_type.downcase
      case type
        when "sqlite"
          puts "its sqlite"


          Dir.foreach('db/') do |f| 
            if f =~ %r{\A*\.sqlite3\z}i     #only checking .sqlite3 files

              ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/'+f)  #connect to sqlite3 file

              unless(Dir.exists?('db/csv'))   #creating a 'csv' folder in the 'db' folder
                Dir.mkdir('db/csv')
                puts 'db/csv created'
              end

                f.slice!(".sqlite3")
                unless(Dir.exists?('db/csv/'+f))    #creating folders for each file (dev, test, prod, etc)
                  Dir.mkdir('db/csv/'+f)
                  puts 'db/csv/'+f+' created'
                end

                      ActiveRecord::Base.connection.tables.each do |model|                                #for each model in the db
                        everything = ActiveRecord::Base.connection.execute('SELECT * FROM '+model+';')    #get all the records

                        if everything[0].nil?   #do not create a csv for an empty table
                          next
                        end

                        CSV.open("db/csv/"+f+"/"+model+".csv", "w") do |csv|    #create a csv for each table, titled 'model.csv'

                          size = everything[0].length / 2
                          keys = everything[0].keys.first(size)

                          csv << keys     #first row contains column names
                          
                          everything.each do |row|
                            csv << row.values_at(*keys)     #subsequent rows hold record values
                          end
                        end
                      end
            end

          end


        when "mysql"
          puts "its mysql"
        when "postgres"
          puts "its postgres"
        else
          puts "unknown db type"
      end
          
            
      puts Time.now()

    end
  end

  # class ActiveRecord::Relation
    # def migrate(options, &block)
    #   options[:max_workers] ||= 4
    #   options[:batch_size]  ||= 10_000

    #   log = Logger.new()

    #   active_workers = []
    #   collection = self
    #   collection.find_in_batches(batch_size: options[:batch_size]) do |batch|
    #     if active_workers.length >= options[:max_workers]
    #       log.write "active_workers oversized at capacity of #{active_workers.length}/#{options[:max_workers]}"
    #       finished_process = Process.wait
    #       log.write "finished_process: #{finished_process}"
    #       active_workers.delete finished_process
    #       log.write "active_workers capacity now at: #{active_workers.length}/#{options[:max_workers]}"
    #     else
    #       active_workers << fork do
    #         ActiveRecord::Base.connection.reconnect!
    #         log.write "kicking off engine on batch(#{batch.first}-#{batch.last})"
    #         engine = Engine.new()
    #         engine.run({log: log, batch: batch}, &block)
    #       end
    #     end
    #     ActiveRecord::Base.connection.reconnect!
    #   end
    # end
  # end
end
