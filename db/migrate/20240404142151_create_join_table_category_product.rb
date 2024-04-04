class CreateJoinTableCategoryProduct < ActiveRecord::Migration[6.0]
  def change
    create_join_table :categories, :products do |t|
      # Add any additional columns or options here
      t.index [:category_id, :product_id]
      t.index [:product_id, :category_id]
    end
  end
end

