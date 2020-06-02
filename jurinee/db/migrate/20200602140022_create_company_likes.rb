class CreateCompanyLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :company_likes do |t|
      t.belongs_to :profile, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
