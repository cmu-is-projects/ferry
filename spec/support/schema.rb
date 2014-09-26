ActiveRecord::Schema.define do
  self.verbose = false

    create_table :designs do |t|
      t.integer :design_id
      t.integer :product_id
      t.integer :account_id
      t.string :account_file
      t.string :save_method
      t.integer :total_units
      t.boolean :has_upload
      t.date :created_at
      t.date :updated_at
      t.integer :postal_code

      t.timestamps
    end
end
