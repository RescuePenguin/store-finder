class MakeCompanyNameRequired < ActiveRecord::Migration[5.0]
  def change
    change_column :companies, :name, :string, required: true
  end
end
