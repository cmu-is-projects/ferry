dumper = Ferry::Dumper.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe "dumper" do
  describe "sqlite3" do
  end
  describe "postgresql" do
  end
  describe "mysql2" do
  end
end
