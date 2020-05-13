class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      
      t.string :nickname
      t.text :info

      t.timestamps
    end
  end
end
