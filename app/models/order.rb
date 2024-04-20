class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  attribute :subtotal, :decimal, default: 0
  attribute :tax_amount, :decimal, default: 0
  attribute :total, :decimal, default: 0

  validates :subtotal, :tax_amount, :total, presence: true
  validates :subtotal, :tax_amount, :total, numericality: { greater_than_or_equal_to: 0 }
  validate :calculate_total_correctly

  private

  def calculate_total_correctly
    unless total == subtotal + tax_amount
      errors.add(:total, "must equal the sum of subtotal and tax_amount")
    end
  end
end
