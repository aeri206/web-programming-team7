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
        company = Company.all # TODO - fixed
        if(params.has_key?(:filter_pbr) || params.has_key?(:filter_per) || 
            params.has_key?(:filter_capital) || params.has_key?(:filter_liabilities) || 
            params.has_key?(:'filter_current-liabilities') || params.has_key?(:'filter_fixed-liabilities') || 
            params.has_key?(:filter_ebit) || params.has_key?(:filter_roe))
            @query = true
        else
            @query = false
        end
        @likes = CompanyLike.where(profile_id:current_user.profile.id)
        if params.has_key?(:filter_pbr)
            company = company.where("PBR < ?", params[:pbr_value])
        end

        if params.has_key?(:filter_per)
            company = company.where("PER < ?", params[:per_value])
        end

        if params.has_key?(:filter_capital)
            value = params[:capital_value].to_i
            if value >= 100
                value = 100
            else
                if value <= 0
                    value = 0
                end
            end
            value = number * value / 100
            value = Company.order('capital desc').limit(value).last.capital
            company = company.where("capital > ?", value)
            company = company.order('capital desc') 
        end

        if params.has_key?(:filter_liabilities)
            value = params[:liabilities_value].to_i
            if value >= 100
                value = 100
            else
                if value <= 0
                    value = 0
                end
            end
            value = number * value / 100
            value = Company.order('liabilities').limit(value).last.liabilities
            company = company.where("liabilities < ?", value)
            company = company.where("liabilities > ?", 0)
            company = company.order('liabilities')
        end

        if params.has_key?(:'filter_current-liabilities')
            company = company.select{|r| r.current_liabilities * 2 - r.current_asset < 0}
        end

        if params.has_key?(:'filter_fixed-liabilities')
            company = company.select{|r| r.fixed_liabilities - r.current_asset + r.current_liabilities < 0}
        end

        if params.has_key?(:filter_ebit)
            company = company.where("ebit > ?", 0)
        end
        
        

        if params.has_key?(:filter_roe)
            value = params[:roe_value].to_i
            if value >= 100
                value = 100
            else
                if value <= 0
                    value = 0
                end
            end
            value = number * value / 100
            value = Company.order('ROE desc').limit(value).last.ROE
            company = company.where("ROE > ?", value)
            company = company.order('ROE desc')
        end

        @company = company
        respond_to do |f|
            f.js
        end
    end

    def like
        @company_id = params[:company_id]
        @company = Company.find(id=@company_id)
        @profile_id = current_user.profile.id

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
