require 'ferry'
require 'fileutils'
require 'factory_girl'

Dir[File.dirname(__FILE__) + "/models/*.rb"].each{ |file| require file }
load File.dirname(__FILE__) + "/support/factories.rb"

require "logger"
require "contexts.rb"

FileUtils.mkdir_p 'log'
ActiveRecord::Base.logger = Logger.new("log/test.log")
ActiveRecord::Base.logger.level = Logger::DEBUG

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  include Contexts
end

def connect(adapter)
  test_dir = Pathname.new File.dirname(__FILE__)
  ENV["RAILS_ENV"] = adapter || "test"
  db = YAML.load_file(test_dir.join("config/database.yml"))[adapter]
  ActiveRecord::Base.establish_connection(:adapter => adapter, :database => db["database"])
  load File.dirname(__FILE__) + '/support/schema.rb'
end
