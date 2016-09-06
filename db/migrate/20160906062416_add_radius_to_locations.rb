class AddRadiusToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :radius, :integer
  end
end
