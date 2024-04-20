class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  attribute :subtotal, :decimal
  attribute :tax_amount, :decimal
  attribute :total, :decimal
end
