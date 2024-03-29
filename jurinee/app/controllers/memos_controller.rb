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

        respond_to do |format|
            format.js
        end
        # render 'new'
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
        
        if @type == 'wiki'
            redirect_to wiki_show_path(chapter: @chapter, sub_chapter: @sub_chapter)
        else
            redirect_to expert_show_path(chapter: @chapter, sub_chapter: @sub_chapter)
        end
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
        
        respond_to do |format|
            format.js
        end
        # render 'show'

    end

    def edit
        @type = params[:type]
        @chapter = params[:chapter]
        @sub_chapter = params[:sub_chapter]
        @memo = Memo.find(params[:memo_id])
        respond_to do |format|
            format.js
        end
        # render 'edit'
    end

    def update
        @memo_id = params[:memo_id]
        @memo = Memo.find(@memo_id)
        @memo.update_attribute(:text, params[:memo][:text])

        redirect_to request.referrer
     
    end

    def destroy
        @memo_id = params[:memo_id]
        @type = params[:type]
        Memo.destroy(@memo_id)
        if @type == 'wiki'
            redirect_to wiki_show_path
        else
            redirect_to expert_show_path
        end    
    end

    private
        def memo_params
            params.require(:memo).permit(:text) 
        end
end
