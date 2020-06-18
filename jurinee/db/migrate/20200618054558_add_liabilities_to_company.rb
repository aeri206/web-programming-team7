class AddLiabilitiesToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :liabilities, :float
  end
end
