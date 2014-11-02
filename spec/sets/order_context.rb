module Contexts
  module OrderContext
    def create_orders
      # assumes create_products and create_carts prior
      @order1 = FactoryGirl.create(:order, product: @toy1, cart: @cart1, quantity: 1, date: Date.new(2014, 1, 23))
      @order2 = FactoryGirl.create(:order, product: @toy2, cart: @cart2, quantity: 22, date: Date.new(2014, 4, 5))
      @order3 = FactoryGirl.create(:order, product: @toy3, cart: @cart3, quantity: 1, date: Date.new(2014, 6, 7))
      @order4 = FactoryGirl.create(:order, product: @food1, cart: @cart3, quantity: 123, date: Date.new(2014, 8, 9))
      @order5 = FactoryGirl.create(:order, product: @food2, cart: @cart7, quantity: 1, date: Date.new(2014, 10, 11))
      @order6 = FactoryGirl.create(:order, product: @food3, cart: @cart6, quantity: 41, date: Date.new(2014, 12, 13))
      @order7 = FactoryGirl.create(:order, product: @food4, cart: @cart8, quantity: 1, date: Date.new(2014, 1, 4))
      @order8 = FactoryGirl.create(:order, product: @antique1, cart: @cart1, quantity: 501, date: Date.new(2015, 1, 6))
      @order9 = FactoryGirl.create(:order, product: @antique2, cart: @cart9, quantity: 1, date: Date.new(2014, 7, 89))
      @order10 = FactoryGirl.create(:order, product: @furniture1, cart: @cart3, quantity: 100, date: Date.new(2014, 10, 1))
      @order11 = FactoryGirl.create(:order, product: @furniture2, cart: @cart11, quantity: 1, date: Date.new(2002, 3, 2))
      @order12 = FactoryGirl.create(:order, product: @furniture3, cart: @cart12, quantity: 10, date: Date.new(2012, 1, 4))
      @order13 = FactoryGirl.create(:order, product: @furnite4, cart: @cart14, quantity: 314, date: Date.new(2008, 5, 5))
      @order14 = FactoryGirl.create(:order, product: @cleaning2, cart: @cart10, quantity: 22, date: Date.new(2012, 1, 1))
      @order15 = FactoryGirl.create(:order, product: @cleaning3, cart: @cart11, quantity: 64, date: Date.new(2011, 2, 14))
      @order16 = FactoryGirl.create(:order, product: @cleaning4, cart: @cart9, quantity: 42, date: Date.new(2013, 3, 14))
      @order17 = FactoryGirl.create(:order, product: @toy3, cart: @cart21, quantity: 1, date: Date.new(2014, 4, 15))
      @order18 = FactoryGirl.create(:order, product: @food1, cart: @cart22, quantity: 42, date: Date.new(2011, 4, 20))
      @order19 = FactoryGirl.create(:order, product: @food1, cart: @cart23, quantity: 1, date: Date.new(2006, 5, 5))
      @order20 = FactoryGirl.create(:order, product: @food1, cart: @cart24, quantity: 69, date: Date.new(2007, 6, 28))
      @order21 = FactoryGirl.create(:order, product: @food2, cart: @cart25, quantity: 808, date: Date.new(2014, 7, 4))
      @order22 = FactoryGirl.create(:order, product: @food3, cart: @cart25, quantity: 407, date: Date.new(2014, 8, 2))
      @order23 = FactoryGirl.create(:order, product: @food2, cart: @cart21, quantity: 77, date: Date.new(2014, 9, 11))
      @order24 = FactoryGirl.create(:order, product: @toy1, cart: @cart25, quantity: 49, date: Date.new(2014, 10, 31))
      @order25 = FactoryGirl.create(:order, product: @toy1, cart: @cart26, quantity: 666, date: Date.new(2014, 12, 25))
    end

    def delete_orders
      @order1.delete
      @order2.delete
      @order3.delete
      @order4.delete
      @order5.delete
      @order6.delete
      @order7.delete
      @order8.delete
      @order9.delete
      @order10.delete
      @order11.delete
      @order12.delete
      @order13.delete
      @order14.delete
      @order15.delete
      @order16.delete
      @order17.delete
      @order18.delete
      @order19.delete
      @order20.delete
      @order21.delete
      @order22.delete
      @order23.delete
      @order24.delete
      @order25.delete
    end
    
  end
end