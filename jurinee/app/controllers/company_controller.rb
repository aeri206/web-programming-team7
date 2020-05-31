class CompanyController < ApplicationController
    def index
        @article = Article.where(if_wiki:true).first
        @diy = true
        @titles = Article.where(if_sub:false, if_wiki:false).select(:title, :chapter)
        @sub_titles = Article.where(if_sub:true, if_wiki:false).select(:chapter, :sub_title, :sub_chapter)        
    end
end
