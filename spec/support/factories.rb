FactoryGirl.define do
  factory :product do
    name  "Candy Bar"
    price  1.29
    sales_start_date  Date.new(2013,7,14)
    sales_end_date  nil
    flash_sale_time  Time.new(2016, 10, 31, 16, 20, 0)
    on_sale  false
    stock  120
  end

  factory :category do
  	name  "Food"
    description  "Any item that can be consumed. Can't be included in both \"Food\" and \"Decorations\" categories."
    float_score  3.14159236579
    active  true
  end

  factory :cart do
  	email  "ted@example.com"
  end

  factory :order do
    quantity  1
    date  Date.new(2014,10,14)
  end
end