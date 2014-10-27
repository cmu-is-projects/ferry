ActiveRecord::Schema.define do

  # create_table :schema_info, :force=>true do |t|
  #   t.column :version, :integer, :unique=>true
  # end
  # SchemaInfo.create :version=>SchemaInfo::VERSION

  create_table :products, :force=>true do |t|
    t.column :name, :string, :null => false
    t.column :price, :decimal
    t.column :category_id, :integer
    t.column :sales_start_date, :datetime
    t.column :sales_end_date, :datetime
    t.column :flash_sale_time, :time
    t.column :on_sale, :boolean, :default=>false
    t.column :stock, :integer
  end

  create_table :categories, :force=>true do |t|
    t.column :name, :string, :null => false
    t.column :description, :text
    t.column :float_score, :float
    t.column :active, :boolean
    t.column :bin_field, :binary
  end

  create_table :cart, :force=>true do |t|
    t.column :email, :string
  end

  create_table :orders, :force=>true do |t|
    t.column :product_id, :integer
    t.column :cart_id, :integer
    t.column :quantity, :integer
    t.column :date, :date
  end
  add_index :orders, [:cart_id, :product_id], :unique => true, :name => 'cart_product'


end