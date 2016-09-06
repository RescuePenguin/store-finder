class MoveNameFromCompanyToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :name, :string
    Company.all.each do |c|
      c.locations.each do |l|
        l.name = c.name
        l.save
      end
    end
    remove_column :companies, :name
  end
end
