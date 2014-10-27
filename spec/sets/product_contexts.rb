module Contexts
  module ProductContexts
    def create_products
      # assumes create_curriculums prior
      @product1 = FactoryGirl.create(:product)
      @product2 = FactoryGirl.create(:product)
      @product3 = FactoryGirl.create(:product)
      @product4 = FactoryGirl.create(:product)
    end

    def delete_products
      @product1.delete
      @product2.delete
      @product3.delete
      @product4.delete
      delete_categories
    end
    
  end
end