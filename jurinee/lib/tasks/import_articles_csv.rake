require 'csv'
namespace :import_articles_csv do
  task :create_articles => :environment do
    Article.destroy_all
    CSV.foreach("public/article_data.csv", :headers => true) do |row|
      data = row.to_hash
      content = data['content']
      if data.key?("content") && !content.nil?
        Article.create!(data)
      end
      
    end
  end
end