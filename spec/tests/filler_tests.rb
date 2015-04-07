filler = Ferry::Filler.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

# TODO
# given some sql file
# make sure that we successfully load (fill) that database with the sql file's content
# but how to measure that it was a success or not?
# number of records?
# content?
# queries to see if things match
# but when we import the data - how do we match that to the schema and application knowledge already in place
describe "filler" do
  describe "sqlite3" do
    before(:all) do
      connect("sqlite3")
      Contexts.setup
    end

    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if the specified file does not exist" do
      expect{filler.fill('sqlite3', 'thisfiledoesnotexist')}.to raise_error
    end

    it "should error if the specified database does not exist" do
      expect{filler.fill('thisdatabasedoesnotexist', 'support/sample_database.sql')}.to raise_error
    end

    it "should correctly import the sql file" do
      pending("still thinking of a way to test this")
      raise
    end

    it "should return the expected query results given some query" do
      pending("still thinking of a way to test this")
      raise
    end
  end

  describe "postgresql" do
    before(:all) do
      connect("postgresql")
      Contexts.setup
    end

    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if the specified file does not exist" do
      expect{filler.fill('postgresql', 'thisfiledoesnotexist')}.to raise_error
    end

    it "should error if the specified database does not exist" do
      expect{filler.fill('thisdatabasedoesnotexist', 'support/sample_database.sql')}.to raise_error
    end

    it "should correctly import the sql file" do
      pending("still thinking of a way to test this")
      raise
    end

    it "should return the expected query results given some query" do
      pending("still thinking of a way to test this")
      raise
    end
  end

  describe "mysql2" do
    before(:all) do
      connect("mysql2")
      Contexts.setup
    end

    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if the specified file does not exist" do
      expect{filler.fill('mysql2', 'thisfiledoesnotexist')}.to raise_error
    end

    it "should error if the specified database does not exist" do
      expect{filler.fill('thisdatabasedoesnotexist', 'support/sample_database.sql')}.to raise_error
    end

    it "should correctly import the sql file" do
      pending("still thinking of a way to test this")
      raise
    end

    it "should return the expected query results given some query" do
      pending("still thinking of a way to test this")
      raise
    end
  end
end
