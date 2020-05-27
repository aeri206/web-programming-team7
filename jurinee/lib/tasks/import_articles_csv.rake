require 'csv'
namespace :import_articles_csv do
  task :create_articles => :environment do
    CSV.foreach("public/article_data.csv", :headers => true) do |row|
      Article.create!(row.to_hash)
    end
  end
end