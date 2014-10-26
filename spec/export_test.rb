require 'pathname'
test_dir = Pathname.new File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "fileutils"

ENV["RAILS_ENV"] = "test"

require "bundler"
Bundler.setup

require "logger"
require 'test/unit'
require "active_record"
require "active_record/fixtures"
require "active_support/test_case"

require "delorean"
require "ruby-debug" if RUBY_VERSION.to_f < 1.9

adapter = ENV["ARE_DB"] || "sqlite3"

FileUtils.mkdir_p 'log'
ActiveRecord::Base.logger = Logger.new("log/test.log")
ActiveRecord::Base.logger.level = Logger::DEBUG
ActiveRecord::Base.configurations["test"] = YAML.load_file(test_dir.join("database.yml"))[adapter]

require "activerecord-import"
ActiveRecord::Base.establish_connection "test"

ActiveSupport::Notifications.subscribe(/active_record.sql/) do |event, _, _, _, hsh|
  ActiveRecord::Base.logger.info hsh[:sql]
end

#loads factory girl files
require "factory_girl"
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }

# Load base/generic schema aka create tables
require test_dir.join("schema/version")
require test_dir.join("schema/generic_schema")
adapter_schema = test_dir.join("schema/#{adapter}_schema.rb")
require adapter_schema if File.exists?(adapter_schema)

#load active record models
Dir[File.dirname(__FILE__) + "/models/*.rb"].each{ |file| require file }

# Prevent this deprecation warning from breaking the tests.
Rake::FileList.send(:remove_method, :import)





# require File.expand_path(File.dirname(__FILE__) + '/../test_helper')



describe "#supports_imports?" do
  context "and SQLite is 3.7.11 or higher" do
    it "supports import" do
      version = ActiveRecord::ConnectionAdapters::SQLite3Adapter::Version.new("3.7.11")
      assert ActiveRecord::Base.supports_import?(version)

      version = ActiveRecord::ConnectionAdapters::SQLite3Adapter::Version.new("3.7.12")
      assert ActiveRecord::Base.supports_import?(version)
    end
  end

  context "and SQLite less than 3.7.11" do
    it "doesn't support import" do
      version = ActiveRecord::ConnectionAdapters::SQLite3Adapter::Version.new("3.7.10")
      assert !ActiveRecord::Base.supports_import?(version)
    end
  end
end

describe "#import" do
  it "imports with a single insert on SQLite 3.7.11 or higher" do
    assert_difference "Topic.count", +507 do
      result = Topic.import Build(7, :topics)
      assert_equal 1, result.num_inserts, "Failed to issue a single INSERT statement. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
      assert_equal 7, Topic.count, "Failed to insert all records. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"

      result = Topic.import Build(500, :topics)
      assert_equal 1, result.num_inserts, "Failed to issue a single INSERT statement. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
      assert_equal 507, Topic.count, "Failed to insert all records. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
    end
  end

  it "imports with a two inserts on SQLite 3.7.11 or higher" do
    assert_difference "Topic.count", +501 do
      result = Topic.import Build(501, :topics)
      assert_equal 2, result.num_inserts, "Failed to issue a two INSERT statements. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
      assert_equal 501, Topic.count, "Failed to insert all records. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
    end
  end

  it "imports with a five inserts on SQLite 3.7.11 or higher" do
    assert_difference "Topic.count", +2500 do
      result = Topic.import Build(2500, :topics)
      assert_equal 5, result.num_inserts, "Failed to issue a two INSERT statements. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
      assert_equal 2500, Topic.count, "Failed to insert all records. Make sure you have a supported version of SQLite3 (3.7.11 or higher) installed"
    end
  end

end