require_relative 'utilities'

module Ferry
  class Importer < Utilities

    def environment
      ARGV[1]
    end

    def import(model, filename)
      db_connect(environment)
      #now connected to activerecord

      if(File.extname(filename) != ".csv")
        puts "Import aborted -- only csv import is supported"
        return false
      end

      lines = File.new(filename).readlines
      if(lines.nil?)
        puts "Import aborted -- file not found"
        return false
      end

      header = lines.shift.strip
      keys = header.split(',')

      lines.each do |line|
        values = line.strip.split(',')
        attributes = Hash[keys.zip values]
        # puts ActiveRecord::Base.connection.subclasses
        # const = model.classify.constantize
        # const.create(attributes)
        Module.const_get(model).create(attributes)
        # ActiveRecord::Base.connection.const_get(model).create(attributes)
      end

    end

  end
end
