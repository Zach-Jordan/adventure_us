class Product < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :image, category_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column "Image" do |product|
      if product.image.attached?
        image_tag(url_for(product.image), height: '100')
      else
        content_tag(:span, "No Image")
      end
    end
    column "Categories" do |product|
      product.category_names
    end
    actions
  end

  filter :name
  filter :price

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :image, as: :file
      f.input :categories, as: :check_boxes, collection: Category.all
    end
    f.actions
  end
end