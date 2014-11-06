def create_products
  # assumes create_categories prior
  @food1 = FactoryGirl.create(:product, category: @food)
  @food2 = FactoryGirl.create(:product, category: @food, name: "potato", price: 0.69, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 50)
  @food3 = FactoryGirl.create(:product, category: @food, name: "rice", price: 2.35, sales_start_date: Date.new(2014,7,14), sales_end_date:  Date.new(2014,8,14), flash_sale_time: nil, on_sale: false, stock: 45)
  @food4 = FactoryGirl.create(:product, category: @food, name: "chicken", price: 7.60, sales_start_date: Date.new(2012,1,14), sales_end_date:  Date.new(2012,2,14), flash_sale_time: Time.new(2014, 11, 23, 16, 20, 0), on_sale: true, stock: 35)
  @cleaning1 = FactoryGirl.create(:product, category: @cleaning, name: "soap", price: 1.29, sales_start_date: Date.new(2014,4,20), sales_end_date: Date.new(2014,7,14), flash_sale_time: nil , on_sale: false, stock: 100)
  @cleaning2 = FactoryGirl.create(:product, category: @cleaning, name: "detergent", price: 3.00, sales_start_date: Date.new(2014,10,26), sales_end_date: Date.new(2014,7,14), flash_sale_time: nil, on_sale: false, stock: 120)
  @cleaning3 = FactoryGirl.create(:product, category: @cleaning, name: "bleach", price: 6.00, sales_start_date: Date.new(2013,12,25), sales_end_date: Date.new(2014,1,7), flash_sale_time: Time.new(2014, 12, 23, 0, 0, 0), on_sale: true, stock: 121)
  @antique1 = FactoryGirl.create(:product, category: @antiques, name: "lamp", price: 329.65, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 3)
  @antique2 = FactoryGirl.create(:product, category: @antiques, name: "Elizabethan-era dress", price: 1777888999.99, sales_start_date: Date.new(2002,2,7), sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 1)
  @toy1 = FactoryGirl.create(:product, category: @toys, name: "teddy bear", price: 12.98, sales_start_date: Date.new(2014,12,1), sales_end_date: Date.new(2015,2,15), flash_sale_time: Time.new(2014, 12, 24, 12, 12, 0), on_sale: true, stock: 1000)
  @toy2 = FactoryGirl.create(:product, category: @toys, name: "Monopoly", price: 19.67, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 35)
  @toy3 = FactoryGirl.create(:product, category: @toys, name: "doll", price: 8.00, sales_start_date: Date.new(2013,4,4), sales_end_date: Date.new(2013,5,5), flash_sale_time: nil, on_sale: false, stock: 121)
  @furniture1 = FactoryGirl.create(:product, category: @furniture, name: "chair", price: 75.00, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 222)
  @furniture2 = FactoryGirl.create(:product, category: @furniture, name: "table", price: 1200.99, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 12)
  @furniture3 = FactoryGirl.create(:product, category: @furniture, name: "sofa", price: 1423.80, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 279)
  @furniture4 = FactoryGirl.create(:product, category: @furniture, name: "desk", price: 600.00, sales_start_date: nil, sales_end_date: nil, flash_sale_time: nil, on_sale: false, stock: 300)
end

def delete_products
  @food1.delete
  @food2.delete
  @food3.delete
  @food4.delete
  @cleaning1.delete
  @cleaning2.delete
  @cleaning3.delete
  @antique1.delete
  @antique2.delete
  @toy1.delete
  @toy2.delete
  @toy3.delete
  @furniture1.delete
  @furniture2.delete
  @furniture3.delete
  @furniture4.delete
end
