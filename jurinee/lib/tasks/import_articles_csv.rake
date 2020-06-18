require 'csv'
namespace :import_articles_csv do
  task :create_articles => :environment do
    CSV.foreach("public/article_data.csv", :headers => true) do |row|
      Article.create!(row.to_hash)
    end
  end
  task :update_articles => :environment do
    CSV.foreach("public/article_data.csv", :headers => true) do |row|
      data = row.to_hash
      id = data['id']
      content = data['content']
      title = data['title']
      sub_title = data['sub_title']
      article = Article.find(id)
      article.title = title
      article.sub_title = sub_title
      article.content = content
      article.save()
    end
  end
end