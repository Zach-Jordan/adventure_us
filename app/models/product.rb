class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_one_attached :image
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def category_names
    categories.pluck(:name).join(', ')
  end

end
