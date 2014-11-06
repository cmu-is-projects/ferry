require 'sets/category_context'
require 'sets/product_context'
require 'sets/cart_context'
require 'sets/order_context'

module Contexts
	def self.setup
	  create_categories
		create_products
		create_carts
		create_orders
	end

	def self.teardown
		delete_orders
		delete_carts
		delete_products
	  delete_categories
	end
end
