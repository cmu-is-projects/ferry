importer = Ferry::Importer.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

# TODO: import json tests - will need sample json file
# TODO: import db things - will need sample db file
describe "import" do
	describe "sqlite3 db" do

		before(:all) do
			connect("sqlite3")
			Contexts.setup
		end

		after(:all) do
			Contexts.teardown
			Category.delete_all
		end

		it "should import a valid csv into ActiveRecord" do
			import_path = File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv"
			importer.import_csv("sqlite3", "categories", import_path)
			expect(Category.all.length).to eql(146)
			expect(Category.find_by(id: 42).name).to eql("outdoor decor")
			expect(Category.find_by(id: 42).description).to eql("Pellentesque magna odio, blandit in nisi fringilla, commodo.")
			expect(Category.find_by(id: 42).float_score).to eql(42.42)
			expect(Category.find_by(id: 42).active).to eql(true)
      expect(Category.find_by(id: 9).name).to eql("boys' clothing")
  	end

    it "should error if given a non-csv file" do
      expect{importer.import_csv("sqlite3", "categories", File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.xml")}.to raise_error
    end

    it "should error if file does not exist" do
      expect{importer.import_csv("sqlite3", "categories", File.expand_path("..",Dir.pwd) + "/spec/support/invalid.csv")}.to raise_error
    end

    it "should error if invalid table name" do
      expect{importer.import_csv("sqlite3", "category", File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv")}.to raise_error
    end

    it "should error if columns are invalid" do
      expect{importer.import_csv("sqlite3", "categories", File.expand_path("..",Dir.pwd) + "/spec/support/categories_invalid_col.csv")}.to raise_error
    end

    it "should error if values do not meet db constraints" do
      expect{importer.import_csv("sqlite3", "categories", File.expand_path("..",Dir.pwd) + "/spec/support/categories_null_name.csv")}.to raise_error
      expect{importer.import_csv("sqlite3", "categories", File.expand_path("..",Dir.pwd) + "/spec/support/categories_repeat_id.csv")}.to raise_error
    end

    it "should be able to import a json file correctly" do
      pending("waiting to be written")
      raise "so were failing for now"
    end

    it "should be able to import a full sql dump" do
      pending("waiting to be written")
      raise "so were failing for now"
    end
	end

  describe "mass insert tests (sqlite)" do

    before(:each) do
      connect("sqlite3")
      Contexts.setup
    end

    after(:each) do
      Contexts.teardown
      Cart.delete_all
    end

    it "should be able to import > 500 records" do
      import_path = File.expand_path("..",Dir.pwd) + "/spec/support/emails_import.csv"
      importer.import_csv("sqlite3", "carts", import_path)
      expect(Cart.find_by(id: 42).email).to eql("Albert@example.com")
      expect(Cart.find_by(id: 542).email).to eql("Agustu@example.com")
      expect(Cart.find_by(id: 1042).email).to eql("Smith@example.com")
      expect(Cart.find_by(id: 1542).email).to eql("Kare@example.com")
      expect(Cart.find_by(id: 2042).email).to eql("Yolanda@example.com")
    end

    it "should not commit import if any record errors" do
      import_path = File.expand_path("..",Dir.pwd) + "/spec/support/emails_invalid.csv"
      expect{importer.import_csv("sqlite3", "carts", import_path)}.to raise_error
      expect(Cart.find_by(id: 42)).to eql(nil)
      expect(Cart.find_by(id: 542)).to eql(nil)
      expect(Cart.find_by(id: 1042)).to eql(nil)
      expect(Cart.find_by(id: 1542)).to eql(nil)
      expect(Cart.find_by(id: 2042)).to eql(nil)
    end
  end

	describe "postgresql db" do

		before(:all) do
			connect("postgresql")
			Contexts.setup
		end

		after(:all) do
			Contexts.teardown
			Category.delete_all
		end

		it "should import a valid csv into ActiveRecord" do
			import_path = File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv"
			importer.import_csv("postgresql", "categories", import_path)
			expect(Category.all.length).to eql(146)
			expect(Category.find_by(id: 42).name).to eql("outdoor decor")
			expect(Category.find_by(id: 42).description).to eql("Pellentesque magna odio, blandit in nisi fringilla, commodo.")
			expect(Category.find_by(id: 42).float_score).to eql(42.42)
			expect(Category.find_by(id: 42).active).to eql(true)
      expect(Category.find_by(id: 9).name).to eql("boys' clothing")
  	end

    it "should be able to import a json file correctly" do
      pending("waiting to be written")
      raise "so were failing for now"
    end

    it "should be able to import a full sql dump" do
      pending("waiting to be written")
      raise "so were failing for now"
    end
	end

  describe "mass insert tests (postgresql)" do
    before(:each) do
      connect("postgresql")
      Contexts.setup
    end

    after(:each) do
      Contexts.teardown
      Cart.delete_all
    end

    it "should be able to import >500 records" do
      import_path = File.expand_path("..",Dir.pwd) + "/spec/support/emails_import.csv"
      importer.import_csv("sqlite3", "carts", import_path)
      expect(Cart.find_by(id: 42).email).to eql("Albert@example.com")
      expect(Cart.find_by(id: 542).email).to eql("Agustu@example.com")
      expect(Cart.find_by(id: 1042).email).to eql("Smith@example.com")
      expect(Cart.find_by(id: 1542).email).to eql("Kare@example.com")
      expect(Cart.find_by(id: 2042).email).to eql("Yolanda@example.com")
    end

    it "should not commit import if any record errors" do
      import_path = File.expand_path("..",Dir.pwd) + "/spec/support/emails_invalid.csv"
      expect{importer.import_csv("sqlite3", "carts", import_path)}.to raise_error
      expect(Cart.find_by(id: 42)).to eql(nil)
      expect(Cart.find_by(id: 542)).to eql(nil)
      expect(Cart.find_by(id: 1042)).to eql(nil)
      expect(Cart.find_by(id: 1542)).to eql(nil)
      expect(Cart.find_by(id: 2042)).to eql(nil)
    end
  end

	describe "mysql2 db" do
		before(:all) do
			connect("mysql2")
			Contexts.setup
		end

		after(:all) do
			Contexts.teardown
			Category.delete_all
		end

		it "should import a valid csv values into ActiveRecord" do
			import_path = File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv"
			importer.import_csv("mysql2", "categories", import_path)
			expect(Category.all.length).to eql(146)
			expect(Category.find_by(id: 42).name).to eql("outdoor decor")
			expect(Category.find_by(id: 42).description).to eql("Pellentesque magna odio, blandit in nisi fringilla, commodo.")
			expect(Category.find_by(id: 42).float_score).to eql(42.42)
			expect(Category.find_by(id: 42).active).to eql(true)
      expect(Category.find_by(id: 9).name).to eql("boys' clothing")
  	end

    it "should be able to import a json file correctly" do
      pending("waiting to be written")
      raise "so were failing for now"
    end

    it "should be able to import a full sql dump" do
      pending("waiting to be written")
      raise "so were failing for now"
    end
	end

  describe "mass insert tests (mysql2)" do
    before(:each) do
      connect("mysql2")
      Contexts.setup
    end

    after(:each) do
      Contexts.teardown
      Cart.delete_all
    end

    it "should be able to import >500 records" do
      import_path = File.expand_path("..",Dir.pwd) + "/spec/support/emails_import.csv"
      importer.import_csv("sqlite3", "carts", import_path)
      expect(Cart.find_by(id: 42).email).to eql("Albert@example.com")
      expect(Cart.find_by(id: 542).email).to eql("Agustu@example.com")
      expect(Cart.find_by(id: 1042).email).to eql("Smith@example.com")
      expect(Cart.find_by(id: 1542).email).to eql("Kare@example.com")
      expect(Cart.find_by(id: 2042).email).to eql("Yolanda@example.com")
    end

    it "should not commit import if any record errors" do
      import_path = File.expand_path("..",Dir.pwd) + "/spec/support/emails_invalid.csv"
      expect{importer.import_csv("sqlite3", "carts", import_path)}.to raise_error
      expect(Cart.find_by(id: 42)).to eql(nil)
      expect(Cart.find_by(id: 542)).to eql(nil)
      expect(Cart.find_by(id: 1042)).to eql(nil)
      expect(Cart.find_by(id: 1542)).to eql(nil)
      expect(Cart.find_by(id: 2042)).to eql(nil)
    end
  end
end
