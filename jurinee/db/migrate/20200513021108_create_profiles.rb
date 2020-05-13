class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user # devise로 만든 user model과 1:1 Relation
      
      t.string :nickname
      t.text :info

      t.timestamps
    end
  end
end
