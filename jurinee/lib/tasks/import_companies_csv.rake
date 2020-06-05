require 'csv'
namespace :import_companies_csv do
  task :create_companies => :environment do
    CSV.foreach("public/company_data.csv", :headers => true) do |row|
      Company.create!(row.to_hash)
    end
    
    CSV.foreach("public/naver_stock.csv", :headers => true) do |row|
      comp = Company.find_by code: row[4]
      comp.BPS = row[0]
      comp.PBR = row[1]
      comp.PER = row[2]
      comp.ROE = row[3]
      comp.price = row[5]
      comp.save()
    end
  end
  task :update_companies => :environment do
    CSV.foreach("public/naver_stock.csv", :headers => true) do |row|
      comp = Company.find_by code: row[4]
      comp.BPS = row[0]
      comp.PBR = row[1]
      comp.PER = row[2]
      comp.ROE = row[3]
      comp.price = row[5]
      comp.save()
    end
  end
end