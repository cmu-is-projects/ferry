utils = Ferry::Utilities.new

Dir.chdir("spec") unless Dir.pwd.split('/').last == "spec"

describe("utility functions") do
	describe "#db_connect" do

  		it "#sqlite3" do
  			expect{utils.db_connect("sqlite3")}.not_to raise_error
        expect(ActiveRecord::Base.connection.adapter_name).to eql('SQLite')
    	end

      it "#postgresql" do
        expect{utils.db_connect("postgresql")}.not_to raise_error
        expect(ActiveRecord::Base.connection.adapter_name).to eql('PostgreSQL')
      end

      it "#postgresql fails if system user name is not role in PostgreSQL" do
        expect{utils.db_connect("postgresql_system_user_name")}.not_to raise_error
        expect{ActiveRecord::Base.connection.adapter_name}.to raise_error
      end

      it "#mysql2" do
        expect{utils.db_connect("mysql2")}.not_to raise_error
        expect(ActiveRecord::Base.connection.adapter_name).to eql('Mysql2')
      end

      it "#no environment with given name" do
        expect{utils.db_connect("invalid_env")}.to raise_error
      end

      it "#unsupported DB type" do
        expect{utils.db_connect("oracle")}.to raise_error
      end

  end
end
