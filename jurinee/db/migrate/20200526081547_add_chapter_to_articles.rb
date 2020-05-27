class AddChapterToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :chapter, :integer
  end
end
