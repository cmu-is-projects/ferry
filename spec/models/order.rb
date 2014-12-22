class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
end
