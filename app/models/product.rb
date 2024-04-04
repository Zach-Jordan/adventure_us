class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_one_attached :image

  def category_names
    categories.pluck(:name).join(', ')
  end
end