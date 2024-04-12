class Order < ApplicationRecord
  attribute :subtotal, :decimal
  attribute :tax_amount, :decimal
  attribute :total, :decimal
end
