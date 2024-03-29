class Product < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end

ActiveAdmin.register Product do
  permit_params :name, :description, :price

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    actions
  end

  filter :name
  filter :price

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
    end
    f.actions
  end
end
