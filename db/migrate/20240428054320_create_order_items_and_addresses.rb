class CreateOrderItemsAndAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :price

      t.timestamps
    end

    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :province
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, default: -1, foreign_key: true

      t.timestamps
    end
  end
end
