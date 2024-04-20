ActiveAdmin.register Order do
  scope :all, default: true

  index do
    selectable_column
    column :id
    column :user
    column :created_at
    column :products do |order|
      ul do
        order.products.each do |product|
          li product.name
        end
      end
    end
    column :tax_amount
    column :total_amount
    actions
  end
end
