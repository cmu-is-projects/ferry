dumper = Ferry::Filler.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe "filler" do
  # TODO
  # given some sql file
  # make sure that we successfully load (fill) that database with the sql file's content
  # but how to measure that it was a success or not?
  # number of records?
  # content?
  # queries to see if things match

  describe "sqlite3" do
    before(:all) do
      connect("sqlite3")
      Contexts.setup
    end

    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if the specified db does not exist" do
      pending("waiting on the world to change")
      raise
    end

    it "should correctly import the sql file" do
      pending("waiting on the world to change")
      raise
    end

    it "should return the expected query results given some query" do
      pending("waiting on the world to change")
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

    it "should error if the specified db does not exist" do
      pending("waiting on the world to change")
      raise
    end

    it "should correctly import the sql file" do
      pending("waiting on the world to change")
      raise
    end

    it "should return the expected query results given some query" do
      pending("waiting on the world to change")
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

    it "should error if the specified db does not exist" do
      pending("waiting on the world to change")
      raise
    end

    it "should correctly import the sql file" do
      pending("waiting on the world to change")
      raise
    end

    it "should return the expected query results given some query" do
      pending("waiting on the world to change")
      raise
    end
  end
end
