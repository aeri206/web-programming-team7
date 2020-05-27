class RemovePageFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :page, :integer
  end
end
