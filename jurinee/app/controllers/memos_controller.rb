class MemosController < ApplicationController
    before_action :authenticate_user! 

    def index # in my page
        @memos = current_user.profile.memos.all
        render 'profile/index'
    end

    def new
        # @memo = Memo.new
        @type = params[:type]
        @chapter = params[:chapter]
        @sub_chapter = params[:sub_chapter]
        @article
        if(@type == "wiki")
            @article = Article.where(if_wiki: true, chapter: @chapter, sub_chapter: @sub_chapter)
        else
            @article = Article.where(if_wiki: false, chapter: @chapter, sub_chapter: @sub_chapter)
        end

        render 'new'
    end

    def create 
        @text = params[:text]
        
        @memo = Memo.new(memo_params)
        @type = params[:type]
        @chapter = params[:chapter]
        @sub_chapter = params[:sub_chapter]
        @article 

        if @type == "wiki"
            @article = Article.where(if_wiki: true, chapter: @chapter, sub_chapter: @sub_chapter).first
        else 
            @article = Article.where(if_wiki: false, chapter: @chapter, sub_chapter: @sub_chapter).first
        end

        @memo.profile = current_user.profile
        @memo.article = @article
        @memo.save
        
        redirect_to controller: 'articles', action: 'show', type: @type, chapter: @chapter, sub_chapter: @ㅡsub_chapter
    end

    def show
        # get '/:type/:chapter/:sub_chapter/memo/show' => 'memos#show', as: 'memo_show' # added
        @type = params[:type]
        @chapter = params[:chapter]
        @sub_chapter = params[:sub_chapter]
        @article

        if @type == "wiki"
            @article = Article.where(if_wiki: true, chapter: @chapter, sub_chapter: @sub_chapter)
        else
            @article = Article.where(if_wiki: false, chapter: @chapter, sub_chapter: @sub_chapter)
        end

        @memo = Memo.where(profile: current_user.profile, article: @article).first
        render 'show'
    end

    def edit
        @memo = Memo.find(params[:id])
        render 'edit'
    end

    def update
        @memo = Memo.find(memo_params)
        
        @memo.text = params[:text]
        if @memo.save
            redirect_to controller: 'articles', action: 'show', type: @type, chapter: @article.chapter, sub_chapter: @article.sub_chapter
        else
            render 'update'
        end
    end

    def destroy
        @memo_id = params[:id]
        Memo.destroy(@memo_id)
        redirect_to controller: 'articles', action: 'show', type: @type, chapter: @article.chapter, sub_chapter: @article.sub_chapter     
    end

    private
        def memo_params
            params.require(:memo).permit(:text) 
        end
end
