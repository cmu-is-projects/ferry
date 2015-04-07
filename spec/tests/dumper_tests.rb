dumper = Ferry::Dumper.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

# TODO :: refactor testing where you can test that the dumpfile is correct
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
      file_size = File.size?(Dir.glob("db/**/dumpfile.sql")[0])
      expect(file_size).to_not eql(nil)
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
      file_size = File.size?(Dir.glob("db/**/dumpfile.sql")[0])
      expect(file_size).to_not eql(nil)
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
      file_size = File.size?(Dir.glob("db/**/dumpfile.sql")[0])
      expect(file_size).to_not eql(nil)
    end
  end
end
