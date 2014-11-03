
importer = Ferry::Importer.new

Dir.chdir("spec")

describe("import functionality") do

	describe "#import" do

		describe "sqlite3 db" do
			before(:all) do
				connect("sqlite3")
				Contexts.setup
			end

			after(:all) do
				Contexts.teardown
				Category.delete_all
			end

	  		it "import should import valid csv values into ActiveRecord and the db" do
	  			import_path = File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv"
	  			importer.import("sqlite3", "categories", import_path)

	  			expect(Category.all.length).to eql(146)
	  			expect(Category.find_by(id: 42).name).to eql("outdoor decor")
	  			expect(Category.find_by(id: 42).description).to eql("Pellentesque magna odio, blandit in nisi fringilla, commodo.")
	  			expect(Category.find_by(id: 42).float_score).to eql(42.42)
	  			expect(Category.find_by(id: 42).active).to eql(true)
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
				Category.delete_all
			end

	  		it "import should import valid csv values into ActiveRecord and the db" do
	  			import_path = File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv"
	  			importer.import("postgresql", "categories", import_path)

	  			expect(Category.all.length).to eql(146)
	  			expect(Category.find_by(id: 42).name).to eql("outdoor decor")
	  			expect(Category.find_by(id: 42).description).to eql("Pellentesque magna odio, blandit in nisi fringilla, commodo.")
	  			expect(Category.find_by(id: 42).float_score).to eql(42.42)
	  			expect(Category.find_by(id: 42).active).to eql(true)
	    	end

	  	end

	  	describe "mysql2 db" do
			before(:all) do
				connect("mysql2")
				# requires you to have a ferry_test db in pg
				Contexts.setup
			end

			after(:all) do
				Contexts.teardown
				Category.delete_all
			end

	  		it "import should import valid csv values into ActiveRecord and the db" do
	  			import_path = File.expand_path("..",Dir.pwd) + "/spec/support/categories_import.csv"
	  			importer.import("mysql2", "categories", import_path)

	  			expect(Category.all.length).to eql(146)
	  			expect(Category.find_by(id: 42).name).to eql("outdoor decor")
	  			expect(Category.find_by(id: 42).description).to eql("Pellentesque magna odio, blandit in nisi fringilla, commodo.")
	  			expect(Category.find_by(id: 42).float_score).to eql(42.42)
	  			expect(Category.find_by(id: 42).active).to eql(true)
	    	end

	  	end



	end
end