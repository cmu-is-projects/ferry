class Product < ActiveRecord::Base
  has_many :orders
  belongs_to :category
  validates_presence_of :name
end
