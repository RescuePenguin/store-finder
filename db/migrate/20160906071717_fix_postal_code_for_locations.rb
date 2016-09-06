class FixPostalCodeForLocations < ActiveRecord::Migration[5.0]
  def change
    rename_column :locations, :postal_code, :postal_code_name
  end
end
