exporter = Ferry::Exporter.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

# TODO: test db func expo
describe "exporting" do
  describe "sqlite3 db" do
    before(:all) do
      connect("sqlite3")
      Contexts.setup
    end
    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if specified table does not exist" do
      expect{exporter.to_csv('sqlite3', 'thistabledoesnotexist')}.to raise_error
    end

    describe "to_csv" do
      it "call should create a populated csv file" do
        exporter.to_csv('sqlite3', 'carts')
        file_path = File.expand_path("..",Dir.pwd) + "/spec/db/csv/sqlite3/carts.csv"
        expect(File).to exist(file_path)
        lines = CSV.read(file_path)
        expect(lines.length).to eql(27)
        expect(lines[0]).to eql(["id", "email"])
        expect(lines[1]).to eql(["1", "abby@example.com"])
        expect(lines[26]).to eql(["26", "zach@example.com"])
      end
    end

    describe "to_yaml" do
      it "call should create a populated yaml file" do
        exporter.to_yaml('sqlite3', 'carts')
        file_path = File.expand_path("..", Dir.pwd) + "/spec/db/yaml/sqlite3/carts.yml"
        expect(File).to exist(file_path)
        output = YAML.load_file(file_path)
        expect(output["carts"].length).to eql(2)
        expect(output["carts"].keys).to eql(["columns","records"])
        expect(output["carts"]["columns"]).to eql(["id","email"])
        expect(output["carts"]["records"][0]).to eql([1,"abby@example.com"])
        expect(output["carts"]["records"][25]).to eql([26,"zach@example.com"])
      end
    end

    describe "to_json" do
      it "should create a correctly formatted json file" do
        exporter.to_json('sqlite3', 'carts')
        file_path = File.expand_path("..", Dir.pwd) + "/spec/db/json/sqlite3/carts.json"
        file_content = File.read(file_path)
        expect(File).to exist(file_path)
        output = JSON.parse(file_content)
        expect(output.length).to eql(26)
        expect(output[0]["email"]).to eql("abby@example.com")
        expect(output[25]["email"]).to eql("zach@example.com")
      end
    end

    # describe "export db dumps" do
    #   it "should be able to export a full sql dump to a file" do
    #     pending("waiting to be written")
    #     raise "so were failing for now"
    #   end
    # end
  end

  describe "postgresql db" do
    before(:all) do
      connect("postgresql")
      Contexts.setup
    end
    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if specified table does not exist" do
      expect{exporter.to_csv('postgresql', 'thistabledoesnotexist')}.to raise_error
    end

    describe "to_csv" do
      it "call should create a populated csv file" do
        exporter.to_csv('postgresql', 'carts')
        file_path = File.expand_path("..",Dir.pwd) + "/spec/db/csv/postgresql/carts.csv"
        expect(File).to exist(file_path)
        lines = CSV.read(file_path)
        expect(lines.length).to eql(27)
        expect(lines[0]).to eql(["id", "email"])
        expect(lines[1]).to eql(["1", "abby@example.com"])
        expect(lines[26]).to eql(["26", "zach@example.com"])
      end
    end

    describe "to_yaml" do
      it "call should create a populated yaml file" do
        exporter.to_yaml('postgresql', 'carts')
        file_path = File.expand_path("..",Dir.pwd) + "/spec/db/yaml/postgresql/carts.yml"
        expect(File).to exist(file_path)
        output = YAML.load_file(file_path)
        expect(output["carts"].length).to eql(2)
        expect(output["carts"].keys).to eql(["columns","records"])
        expect(output["carts"]["columns"]).to eql(["id","email"])
        expect(output["carts"]["records"][0]).to eql(["1","abby@example.com"])
        expect(output["carts"]["records"][25]).to eql(["26","zach@example.com"])
      end
    end

    describe "to_json" do
      it "should create a correctly formatted json file" do
        exporter.to_json('postgresql', 'carts')
        file_path = File.expand_path("..", Dir.pwd) + "/spec/db/json/postgresql/carts.json"
        file_content = File.read(file_path)
        expect(File).to exist(file_path)
        output = JSON.parse(file_content)
        expect(output.length).to eql(26)
        expect(output[0]["email"]).to eql("abby@example.com")
        expect(output[25]["email"]).to eql("zach@example.com")
      end
    end

    # describe "export db dumps" do
    #   it "should be able to export a full sql dump to a file" do
    #     pending("waiting to be written")
    #     raise "so were failing for now"
    #   end
    # end
  end

  describe "mysql2 db" do
    before(:all) do
      connect("mysql2")
      Contexts.setup
    end
    after(:all) do
      Contexts.teardown
      FileUtils.rm_rf('db')
    end

    it "should error if specified table does not exist" do
      expect{exporter.to_csv('mysql2', 'thistabledoesnotexist')}.to raise_error
    end

    describe "to_csv" do
      it "call should create a populated csv file" do
        exporter.to_csv('mysql2', 'carts')
        file_path = File.expand_path("..",Dir.pwd) + "/spec/db/csv/mysql2/carts.csv"
        expect(File).to exist(file_path)
        lines = CSV.read(file_path)
        expect(lines.length).to eql(27)
        expect(lines[0]).to eql(["id", "email"])
        expect(lines[1]).to eql(["1", "abby@example.com"])
        expect(lines[26]).to eql(["26", "zach@example.com"])
      end
    end

    describe "to_yaml" do
      it "call should create a populated yaml file" do
        exporter.to_yaml('mysql2', 'carts')
        file_path = File.expand_path("..",Dir.pwd) + "/spec/db/yaml/mysql2/carts.yml"
        expect(File).to exist(file_path)
        output = YAML.load_file(file_path)
        expect(output["carts"].length).to eql(2)
        expect(output["carts"].keys).to eql(["columns","records"])
        expect(output["carts"]["columns"]).to eql(["id","email"])
        expect(output["carts"]["records"][0]).to eql([1,"abby@example.com"])
        expect(output["carts"]["records"][25]).to eql([26,"zach@example.com"])
      end
    end

    describe "to_json" do
      it "should create a correctly formatted json file" do
        exporter.to_json('mysql2', 'carts')
        file_path = File.expand_path("..", Dir.pwd) + "/spec/db/json/mysql2/carts.json"
        file_content = File.read(file_path)
        expect(File).to exist(file_path)
        output = JSON.parse(file_content)
        expect(output.length).to eql(26)
        expect(output[0]["email"]).to eql("abby@example.com")
        expect(output[25]["email"]).to eql("zach@example.com")
      end
    end

    # describe "export db dumps" do
    #   it "should be able to export a full sql dump to a file" do
    #     pending("waiting to be written")
    #     raise "so were failing for now"
    #   end
    # end
  end
end
