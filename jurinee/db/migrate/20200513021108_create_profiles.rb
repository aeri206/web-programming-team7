class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|      
<<<<<<< HEAD
      # t.belongs_to :user, index: true
      t.integer :user_id
      t.string :name

=======
      t.string :nickname
      t.text :info
    
>>>>>>> my page entry
      # 찜한 기업 company model, zzim model
      # 좋아요한 아티클 article model, like model

      t.timestamps
    end
  end
end
