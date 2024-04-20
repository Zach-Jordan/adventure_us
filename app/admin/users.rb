ActiveAdmin.register User do
  permit_params :email, :created_at, :updated_at

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :created_at
  filter :updated_at

  show do
    attributes_table do
      row :email
      row :created_at
      row :updated_at
    end

    panel "Orders" do
      table_for user.orders do
        column :id
        column :created_at
        column("Subtotal") { |order| number_to_currency(order.subtotal, precision: 2) }
        column("Tax Amount") { |order| number_to_currency(order.tax_amount, precision: 2) }
        column("Total") { |order| number_to_currency(order.total, precision: 2) }
      end
    end
  end
end
