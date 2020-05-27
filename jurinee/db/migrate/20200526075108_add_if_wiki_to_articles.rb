class AddIfWikiToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :if_wiki, :boolean
    add_column :articles, :if_sub, :boolean
    add_column :articles, :sub_title, :string
  end
end
