require 'ferry'
require 'fileutils'

ENV["RAILS_ENV"] = "test"


ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                        :database => File.dirname(__FILE__) + "/ferry.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'
Dir[File.dirname(__FILE__) + "/models/*.rb"].each{ |file| require file }
# load File.dirname(__FILE__) + '/support/data.rb'

require "factory_girl"
# Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }
load File.dirname(__FILE__) + "/support/factories.rb"
require "contexts.rb"
# Dir[File.dirname(__FILE__) + "/sets/*.rb"].each{ |file| require file }

class ActiveSupport::TestCase
  include Contexts
end

require "fileutils"
require "logger"

FileUtils.mkdir_p 'log'
ActiveRecord::Base.logger = Logger.new("log/test.log")
ActiveRecord::Base.logger.level = Logger::DEBUG

RSpec.configure do |config|

end
