class AddCompanyIdToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :company_id, :integer, required: true
  end
end
