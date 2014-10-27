module Contexts
  module CartContexts
    def create_carts
      # assumes create_curriculums prior
      @cart1 = FactoryGirl.create(:cart)
      @cart2 = FactoryGirl.create(:cart)
      @cart3 = FactoryGirl.create(:cart)
      @cart4 = FactoryGirl.create(:cart)
    end

    def delete_carts
      @cart1.delete
      @cart2.delete
      @cart3.delete
      @cart4.delete
      # delete_camps
    end
    
  end
end