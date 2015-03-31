dumper = Ferry::Dumper.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe "dumper" do

  describe "sqlite3" do
    # TODO
    # given some application with a <db_type> database
    # make sure that we successfully export (dump) that database content to a file
    # but how to measure that it was a success or not?
    # number of records?
    # content?
    before(:all) do
      connect("sqlite3")
      Contexts.setup
    end
    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if the specified database does not exist" do
      pending("waiting on the world to change")
      raise
    end

    it "should create a .sql file" do
      pending("waiting on the world to change")
      raise
    end

    it "should have output the correct sql into the file" do
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

    it "should error if the specified database does not exist" do
      pending("waiting on the world to change")
      raise
    end

    it "should create a .sql file" do
      pending("waiting on the world to change")
      raise
    end

    it "should have output the correct sql into the file" do
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

    it "should error if the specified database does not exist" do
      pending("waiting on the world to change")
      raise
    end

    it "should create a .sql file" do
      pending("waiting on the world to change")
      raise
    end

    it "should have output the correct sql into the file" do
      pending("waiting on the world to change")
      raise
    end
  end

end
