# require needed files
require 'sets/category_context'
require 'sets/product_context'
require 'sets/cart_context'
require 'sets/order_context'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::CategoryContext
  include Contexts::ProductContext
  include Contexts::CartContext
  include Contexts::OrderContext
end