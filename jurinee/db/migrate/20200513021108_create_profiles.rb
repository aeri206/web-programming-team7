class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|      
      t.string :nickname
      t.text :info
    
      # 찜한 기업 company model, zzim model
      # 좋아요한 아티클 article model, like model

      t.timestamps
    end
  end
end
