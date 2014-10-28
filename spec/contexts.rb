# require needed files
require '/sets/category_contexts'
require '/sets/product_contexts'
require '/sets/cart_contexts'
require '/sets/order_contexts'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::CategoryContext
  include Contexts::ProductContext
  include Contexts::CartContext
  include Contexts::OrderContext
end