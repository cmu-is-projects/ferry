def create_categories
  # assumes create_curriculums prior
  @food = FactoryGirl.create(:category)
  @cleaning = FactoryGirl.create(:category, name: "Cleaning Supplies", description: "Household cleaning products.")
  @antiques = FactoryGirl.create(:category, name: "Antiques", active: false, description:"No longer carried.")
  @toilet = FactoryGirl.create(:category, name: "Toiletries", description: "Things for the bathroom.")
  @toys = FactoryGirl.create(:category, name: "Toys", description: "Anything that is meant to be played with.")
  @furniture = FactoryGirl.create(:category, name: "Furniture", float_score: 42.12097593749, description: "Furniture.")
end

def delete_categories
  @food.delete
  @cleaning.delete
  @antiques.delete
  @toilet.delete
  @toys.delete
  @furniture.delete
end
