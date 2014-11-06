exporter = Ferry::Exporter.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe("export functionality") do
	describe "#export" do
		describe "sqlite3 db" do
			before(:all) do
				connect("sqlite3")
				Contexts.setup
			end
			after(:all) do
				Contexts.teardown
				FileUtils.rm_rf('db')
			end
  		it "to_csv should create a populated csv file" do
  			exporter.to_csv('sqlite3', 'carts')
  			file_path = File.expand_path("..",Dir.pwd) + "/spec/db/csv/sqlite3/carts.csv"
  			expect(File).to exist(file_path)
  			lines = CSV.read(file_path)
  			expect(lines.length).to eql(27)
  			expect(lines[0]).to eql(["id", "email"])
  			expect(lines[1]).to eql(["1", "abby@example.com"])
  			expect(lines[26]).to eql(["26", "zach@example.com"])
    	end
    	it "to_yaml should create a populated yaml file" do
  			exporter.to_yaml('sqlite3', 'carts')
  			file_path = File.expand_path("..",Dir.pwd) + "/spec/db/yaml/sqlite3/carts.yml"
  			expect(File).to exist(file_path)
  			output = YAML.load_file(file_path)
  			expect(output["carts"].length).to eql(2)
  			expect(output["carts"].keys).to eql(["columns","records"])
  			expect(output["carts"]["columns"]).to eql(["id","email"])
  			expect(output["carts"]["records"][0]).to eql([1,"abby@example.com"])
  			expect(output["carts"]["records"][25]).to eql([26,"zach@example.com"])
    	end
		end

	  describe "postgresql db" do
			before(:all) do
				connect("postgresql")
				# requires you to have a ferry_test db in pg
				Contexts.setup
			end
			after(:all) do
				Contexts.teardown
				FileUtils.rm_rf('db')
			end
  		it "to_csv should create a populated csv file" do
  			exporter.to_csv('postgresql', 'carts')
  			file_path = File.expand_path("..",Dir.pwd) + "/spec/db/csv/postgresql/carts.csv"
  			expect(File).to exist(file_path)
  			lines = CSV.read(file_path)
  			expect(lines.length).to eql(27)
  			expect(lines[0]).to eql(["id", "email"])
  			expect(lines[1]).to eql(["1", "abby@example.com"])
  			expect(lines[26]).to eql(["26", "zach@example.com"])
    	end
    	it "to_yaml should create a populated yaml file" do
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

	  describe "mysql2 db" do
			before(:all) do
				connect("mysql2")
				# requires you to have a ferry_test db in mysql
				Contexts.setup
			end
			after(:all) do
				Contexts.teardown
				FileUtils.rm_rf('db')
			end
  		it "to_csv should create a populated csv file" do
  			exporter.to_csv('mysql2', 'carts')
  			file_path = File.expand_path("..",Dir.pwd) + "/spec/db/csv/mysql2/carts.csv"
  			expect(File).to exist(file_path)
  			lines = CSV.read(file_path)
  			expect(lines.length).to eql(27)
  			expect(lines[0]).to eql(["id", "email"])
  			expect(lines[1]).to eql(["1", "abby@example.com"])
  			expect(lines[26]).to eql(["26", "zach@example.com"])
    	end
    	it "to_yaml should create a populated yaml file" do
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
  end
end
