class AddSubChapterToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :sub_chapter, :integer
  end
end
