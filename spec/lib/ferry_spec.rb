require 'spec_helper'

ENV["RAILS_ENV"] = "test"


require "fileutils"
require "logger"

FileUtils.mkdir_p 'log'
ActiveRecord::Base.logger = Logger.new("log/test.log")
ActiveRecord::Base.logger.level = Logger::DEBUG
ActiveRecord::Base.configurations["test"] = YAML.load_file("database.yml")['sqlite3'] #this will need to be refactored, as it can be used to connect to any adapter

ActiveRecord::Base.establish_connection "test"

require "factory_girl"
# Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each{ |file| require file }
require "factories.rb"
require "schema.rb"

# adapter_schema = test_dir.join("schema/#{adapter}_schema.rb")
# require adapter_schema if File.exists?(adapter_schema)

Dir[File.dirname(__FILE__) + "/models/*.rb"].each{ |file| require file }

#require contexts if needed


















describe "#export" do
  it "should return the number of inserts performed" do
    # see ActiveRecord::ConnectionAdapters::AbstractAdapter test for more specifics
    assert_difference "Topic.count", +10 do
      result = Topic.import Build(3, :topics)
      assert result.num_inserts > 0

      result = Topic.import Build(7, :topics)
      assert result.num_inserts > 0
    end
  end

  it "should not produce an error when importing empty arrays" do
    assert_nothing_raised do
      Topic.import []
      Topic.import %w(title author_name), []
    end
  end

  describe "with non-default ActiveRecord models" do  
    context "that have a non-standard primary key (that is no sequence)" do
      it "should import models successfully" do
        assert_difference "Widget.count", +3 do
          Widget.import Build(3, :widgets)
        end
      end
    end
  end

  context "with :validation option" do
    let(:columns) { %w(title author_name) }
    let(:valid_values) { [[ "LDAP", "Jerry Carter"], ["Rails Recipes", "Chad Fowler"]] }
    let(:invalid_values) { [[ "The RSpec Book", ""], ["Agile+UX", ""]] }

    context "with validation checks turned off" do
      it "should import valid data" do
        assert_difference "Topic.count", +2 do
          result = Topic.import columns, valid_values, :validate => false
        end
      end

      it "should import invalid data" do
        assert_difference "Topic.count", +2 do
          result = Topic.import columns, invalid_values, :validate => false
        end
      end

      it 'should raise a specific error if a column does not exist' do
        assert_raises ActiveRecord::Import::MissingColumnError do
          Topic.import ['foo'], [['bar']], :validate => false
        end
      end
    end

    context "with validation checks turned on" do
      it "should import valid data" do
        assert_difference "Topic.count", +2 do
          result = Topic.import columns, valid_values, :validate => true
        end
      end

      it "should not import invalid data" do
        assert_no_difference "Topic.count" do
          result = Topic.import columns, invalid_values, :validate => true
        end
      end

      it "should report the failed instances" do
        results = Topic.import columns, invalid_values, :validate => true
        assert_equal invalid_values.size, results.failed_instances.size
        results.failed_instances.each{ |e| assert_kind_of Topic, e }
      end

      it "should import valid data when mixed with invalid data" do
        assert_difference "Topic.count", +2 do
          result = Topic.import columns, valid_values + invalid_values, :validate => true
        end
        assert_equal 0, Topic.where(title: invalid_values.map(&:first)).count
      end
    end
  end

end
