class Cart < ActiveRecord::Base
  has_many :orders
  validates_presence_of :email
  validates_uniqueness_of :email
end
