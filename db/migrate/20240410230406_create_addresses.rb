class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :postal_code
      t.string :province
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
