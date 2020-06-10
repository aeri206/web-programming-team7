class ArticlesController < ApplicationController
    def show
        if params[:type] == "wiki"
            @titles = Article.where(if_sub:false, if_wiki:true).select(:title, :chapter)
            @sub_titles = Article.where(if_sub:true, if_wiki:true).select(:chapter, :sub_title, :sub_chapter)
            if params.has_key?(:sub_chapter)
                if Article.where(chapter: params[:chapter], sub_chapter: params[:sub_chapter], if_wiki:true).exists?
                    @title_url = '/wiki/'+params[:chapter]
                    @sub_url = '/wiki/'+params[:chapter]+'/'+params[:sub_chapter]
                    @article = Article.where(chapter: params[:chapter], sub_chapter: params[:sub_chapter], if_wiki:true).first
                    if Article.where(chapter: params[:chapter], sub_chapter: (params[:sub_chapter].to_i+1).to_s, if_wiki:true).exists?
                       @next_url = '/wiki/' + params[:chapter].to_s + '/' + (params[:sub_chapter].to_i+1).to_s
                    else
                        if Article.where(chapter: params[:chapter].to_i+1 ,if_wiki:true).exists?
                            @next_url = '/wiki/' + (params[:chapter].to_i+1).to_s
                        else
                            @next_url = nil
                        end
                    end
                else
                    if Article.where(chapter: params[:chapter], if_wiki:true).exists?
                        redirect_to '/wiki/' + params[:chapter]
                    else
                        redirect_to '/home'
                    end
                end
            else
                if Article.where(chapter: params[:chapter], if_sub: false, if_wiki:true).exists?
                    @title_url = '/wiki/'+params[:chapter]
                    if Article.where(chapter: params[:chapter], if_sub: true, if_wiki:true).exists?
                        next_article = Article.where(chapter: params[:chapter], if_sub: true, if_wiki:true).first
                        @next_url = '/wiki/' + params[:chapter].to_s + '/' + next_article.sub_chapter.to_s
                    else
                        @next_url = '/wiki/' + (params[:chapter].to_i + 1).to_s
                    end
                    @article = Article.where(chapter: params[:chapter], if_sub: false, if_wiki:true).first
                else
                    redirect_to '/home'
                end
            end
        else
            if params[:type] == "expert"
                @titles = Article.where(if_sub:false, if_wiki:false).select(:title, :chapter)
                @sub_titles = Article.where(if_sub:true, if_wiki:false).select(:chapter, :sub_title, :sub_chapter)
                if params.has_key?(:sub_chapter)
                    if Article.where(chapter: params[:chapter], sub_chapter: params[:sub_chapter], if_wiki:false).exists?
                        @title_url = '/expert/'+params[:chapter]
                        @sub_url = '/expert/'+params[:chapter]+'/'+params[:sub_chapter]
                        @article = Article.where(chapter: params[:chapter], sub_chapter: params[:sub_chapter], if_wiki:false).first
                        if Article.where(chapter: params[:chapter], sub_chapter: (params[:sub_chapter].to_i+1).to_s, if_wiki:false).exists?
                            @next_url = '/expert/' + params[:chapter].to_s + '/' + (params[:sub_chapter].to_i+1).to_s
                        else
                            if Article.where(chapter: params[:chapter].to_i+1 ,if_wiki:false).exists?
                                @next_url = '/expert/' + (params[:chapter].to_i+1).to_s
                            else
                                @next_url = nil
                            end
                        end
                    else
                        if Article.where(chapter: params[:chapter], if_wiki:false).exists?
                            redirect_to '/expert/' + params[:chapter]
                        else
                            redirect_to '/home'
                        end
                    end
                else
                    if Article.where(chapter: params[:chapter], if_sub: false, if_wiki:false).exists?
                        @title_url = '/expert/'+params[:chapter]
                        if Article.where(chapter: params[:chapter], if_sub: true, if_wiki:false).exists?
                            next_article = Article.where(chapter: params[:chapter], if_sub: true, if_wiki:false).first
                            @next_url = '/expert/' + params[:chapter].to_s + '/' + next_article.sub_chapter.to_s
                        else
                            @next_url = '/expert/' + (params[:chapter].to_i + 1).to_s
                        end
                        @article = Article.where(chapter: params[:chapter], if_sub: false, if_wiki:false).first
                    else
                        redirect_to '/home'
                    end
                end
            else
                redirect_to '/home'
            end
        end
    end
    
    def index
        if params[:type] == "wiki"
            if Article.where(if_wiki: true).exists?
                @articles = Article.where(if_wiki: true)
            else
                redirect_to '/home'
            end
        else
            if params[:type] == "expert"
                if Article.where(if_wiki: false).exists?
                    @articles = Article.where(if_wiki: false)
                else
                    redirect_to '/home'
                end
            end
        end

        
    end

    def new
    end

    def create
        @article = Article.new(article_params)
        if !@article.if_sub
            @article.sub_title = nil
            @article.sub_chapter = nil
        end
        @article.save
        print(@articles)
        redirect_to '/home'
    end

    def search
        @query = params[:query]
        @search_result = (Article.where('title LIKE ?', '%'+params[:query]+'%')).or(Article.where('sub_title LIKE ?', '%'+params[:query]+'%')).or(Article.where('content LIKE ?', '%'+params[:query]+'%'))
        @wiki_t = Article.where(if_sub:false, if_wiki:true).select(:title, :chapter)
        @wiki_st = Article.where(if_sub:true, if_wiki:true).select(:chapter, :sub_title, :sub_chapter)
        @expert_t = Article.where(if_sub:false, if_wiki:false).select(:title, :chapter)
        @expert_st = Article.where(if_sub:true, if_wiki:false).select(:chapter, :sub_title, :sub_chapter)
    end

    def like
        @article_id = params[:article_id]
        @article = Article.find(id=@article_id)
        @profile_id = params[:profile_id]
        @profile = Profile.find(id=@profile_id)

        if @article.liking_users.where(id: @profile_id).exists?
            ArticleLike.where(profile_id: @profile_id, article_id: @article_id).destroy_all 
        else
            ArticleLike.create(profile_id: @profile_id, article_id: @article_id)   
        end

        respond_to do |format|
            format.js 
            # format.html
        end

        # redirect_to request.referrer
    end


    # def unlike
    #     @article_id = params[:article_id]
    #     @article = Article.find(id=@article_id)
    #     @profile_id = current_user.profile.id
    #     @profile = Profile.find(id=@profile_id)

    #     if @article.liking_users.where(id: @profile_id).exists? 
    #         if ArticleLike.where(profile_id: @profile_id, article_id: @article_id).destroy_all
    #             respond_to do |format|
    #                 format.js
    #             end
    #         end
    #     end

    #     # redirect_to request.referrer
    # end

private
    def article_params
        params.require(:article).permit(:title, :sub_title, :content, :if_wiki, :if_sub, :chapter, :sub_chapter)
    end
end