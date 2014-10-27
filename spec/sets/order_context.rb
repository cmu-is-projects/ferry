module Contexts
  module OrderContexts
    def create_orders
      # assumes create_curriculums prior
      @order1 = FactoryGirl.create(:order)
      @order2 = FactoryGirl.create(:order)
      @order3 = FactoryGirl.create(:order)
      @order4 = FactoryGirl.create(:order)
    end

    def delete_orders
      @order1.delete
      @order2.delete
      @order3.delete
      @order4.delete
      delete_products
      delete_carts
    end
    
  end
end