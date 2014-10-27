module Contexts
  module CategoryContexts
    def create_categorys
      # assumes create_curriculums prior
      @category1 = FactoryGirl.create(:category)
      @category2 = FactoryGirl.create(:category)
      @category3 = FactoryGirl.create(:category)
      @category4 = FactoryGirl.create(:category)
    end

    def delete_categorys
      @category1.delete
      @category2.delete
      @category3.delete
      @category4.delete
    end
    
  end
end