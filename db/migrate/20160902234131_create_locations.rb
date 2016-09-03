class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :address_1
      t.string :address_2
      t.string :phone_number
      t.integer :postal_code
      t.integer :postal_code_suffix
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
