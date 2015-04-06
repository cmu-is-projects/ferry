dumper = Ferry::Dumper.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe "dumper" do
  describe "sqlite3" do
    before(:all) do
      connect("sqlite3")
      Contexts.setup
    end

    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should create a .sql file" do
      dumper.dump('sqlite3')
      expect{Dir.glob("db/**/dumpfile.sql")}.to_not raise_error
    end

    it "should have output the correct sql into the file" do
      pending("how do we test this?")
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

    it "should create a .sql file" do
      dumper.dump('postgresql')
      expect{Dir.glob("db/**/dumpfile.sql")}.to_not raise_error
    end

    it "should have output the correct sql into the file" do
      pending("how do we test this?")
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

    it "should create a .sql file" do
      dumper.dump('mysql2')
      expect{Dir.glob("db/**/dumpfile.sql")}.to_not raise_error
    end

    it "should have output the correct sql into the file" do
      pending("how do we test this?")
      raise
    end
  end
end
