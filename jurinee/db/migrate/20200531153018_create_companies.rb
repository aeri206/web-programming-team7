class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name
      t.integer :industry_code
      t.integer :current_asset
      t.integer :total_liabilities
      t.integer :current_liabilities
      t.integer :fixed_liabilities
      t.integer :capital
      t.integer :ebit
      t.integer :financing_cost
      t.integer :ci
      t.integer :ni
      t.integer :price
      t.float :ROE
      t.float :PER
      t.float :BPS
      t.float :PBR

      t.timestamps
    end
  end
end
