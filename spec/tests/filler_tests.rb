dumper = Ferry::Filler.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe "filler" do
  describe "sqlite3" do
    # TODO
    # given some sql file
    # make sure that we successfully load (fill) that database with the sql file's content
    # but how to measure that it was a success or not?
    # number of records?
    # content?
    # queries to see if things match
  end
  describe "postgresql" do
  end
  describe "mysql2" do
  end
end
