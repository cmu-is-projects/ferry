require 'ferry'
require 'fileutils'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                        :database => File.dirname(__FILE__) + "/ferry.sqlite3")

load File.dirname(__FILE__) + '/support/schema.rb'
Dir[File.dirname(__FILE__) + "/models/*.rb"].each{ |file| require file }
# load File.dirname(__FILE__) + '/support/data.rb'

require "factory_girl"
# Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }
load File.dirname(__FILE__) + "/support/factories.rb"


RSpec.configure do |config|

end
