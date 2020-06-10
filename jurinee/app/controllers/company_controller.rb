class CompanyController < ApplicationController
    def index
        @article = Article.where(if_wiki:true).first
        @diy = true
        @titles = Article.where(if_sub:false, if_wiki:false).select(:title, :chapter)
        @sub_titles = Article.where(if_sub:true, if_wiki:false).select(:chapter, :sub_title, :sub_chapter)
    end

    def list
        @company = Company.order(:PER)
    end

    def result
        number = Company.count
        company = Company.all
        if params.has_key?(:filter_pbr)
            company = company.where("PBR < ?", params[:pbr_value])
        end

        if params.has_key?(:filter_per)
            company = company.where("PER < ?", params[:per_value])
        end

        if params.has_key?(:filter_capital)
            value = params[:capital_value].to_i
            if value <= 100 and value >= 0
                value = number * value / 100
                value = Company.order('capital desc').limit(value).last.capital
                company = company.where("capital > ?", value)
                company = company.order('capital desc')
            end 
        end

        if params.has_key?(:filter_roe)
            value = params[:roe_value].to_i
            if value <= 100 and value >= 0
                value = number * value / 100
                value = Company.order('ROE desc').limit(value).last.ROE
                company = company.where("ROE > ?", value)
                company = company.order('ROE desc')
            end 
        end


        # { "filter_liabilities"=>"1", "liabilities_value"=>"", "filter_coverage"=>"1", "coverage_value"=>"", "filter_roe"=>"1", "roe_value"=>"", "button"=>""}
        print(params)
        @company = company
        respond_to do |f|
            f.js
        end
    end

    def like
        @company_id = params[:company_id]
        @company = Company.find(id=@company_id)
        @profile_id = current_user.profile.id
        # @profile = Profile.find(id=@profile_id)

        if @company.liking_users.where(id: @profile_id).exists?
            CompanyLike.where(profile_id: @profile_id, company_id: @company_id).destroy_all
        else
            CompanyLike.create(profile_id: @profile_id, company_id: @company_id)
        end

        respond_to do |format|
            format.js 
        end

        # redirect_to request.referrer
    end
end
