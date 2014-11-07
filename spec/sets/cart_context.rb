def create_carts
  @cart1 = FactoryGirl.create(:cart, email: "abby@example.com")
  @cart2 = FactoryGirl.create(:cart, email: "bob@example.com")
  @cart3 = FactoryGirl.create(:cart, email: "chris@example.com")
  @cart4 = FactoryGirl.create(:cart, email: "david@example.com")
  @cart5 = FactoryGirl.create(:cart, email: "eric@example.com")
  @cart6 = FactoryGirl.create(:cart, email: "frank@example.com")
  @cart7 = FactoryGirl.create(:cart, email: "greg@example.com")
  @cart8 = FactoryGirl.create(:cart, email: "henry@example.com")
  @cart9 = FactoryGirl.create(:cart, email: "ian@example.com")
  @cart10 = FactoryGirl.create(:cart, email: "joe@example.com")
  @cart11 = FactoryGirl.create(:cart, email: "kevin@example.com")
  @cart12 = FactoryGirl.create(:cart, email: "logan@example.com")
  @cart13 = FactoryGirl.create(:cart, email: "max@example.com")
  @cart14 = FactoryGirl.create(:cart, email: "nancy@example.com")
  @cart15 = FactoryGirl.create(:cart, email: "oliver@example.com")
  @cart16 = FactoryGirl.create(:cart, email: "pamela@example.com")
  @cart17 = FactoryGirl.create(:cart, email: "quinn@example.com")
  @cart18 = FactoryGirl.create(:cart, email: "ryan@example.com")
  @cart19 = FactoryGirl.create(:cart, email: "steve@example.com")
  @cart20 = FactoryGirl.create(:cart, email: "ted@example.com")
  @cart21 = FactoryGirl.create(:cart, email: "uma@example.com")
  @cart22 = FactoryGirl.create(:cart, email: "victor@example.com")
  @cart23 = FactoryGirl.create(:cart, email: "walter@example.com")
  @cart24 = FactoryGirl.create(:cart, email: "xavier@example.com")
  @cart25 = FactoryGirl.create(:cart, email: "yolo@example.com")
  @cart26 = FactoryGirl.create(:cart, email: "zach@example.com")
end

def delete_carts
  @cart1.delete
  @cart2.delete
  @cart3.delete
  @cart4.delete
  @cart5.delete
  @cart6.delete
  @cart7.delete
  @cart8.delete
  @cart9.delete
  @cart10.delete
  @cart11.delete
  @cart12.delete
  @cart13.delete
  @cart14.delete
  @cart15.delete
  @cart16.delete
  @cart17.delete
  @cart18.delete
  @cart19.delete
  @cart20.delete
  @cart21.delete
  @cart22.delete
  @cart23.delete
  @cart24.delete
  @cart25.delete
  @cart26.delete
end
