class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index

    @articles = Article.where(:visibility => true)

  end
 
  def show
    @article = Article.find(params[:id])

    # @article_all = Article.find(params[:id])

    # if @article_all.visibility == true
      
    #   @article = Article.find(params[:id])
    
    # elsif @article_all.visibility == false
      
    #       if current_user.id == @article_all.user_id
    #           @article = Article.find(params[:id])
    #       else
    #             render 'restricted'
    #       end    
    # else

  end
 
  def new
    @article = Article.new
  end
 
  def edit
    @article = Article.find(params[:id])
  end
 
  def create
    
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article
      flash[:notice] = "Article Created Successfully"
    else
      render 'new'
    end

  end
 
  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
      flash[:notice] = "Article Updated Successfully"
    else
      render 'edit'
    end
  end
 
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
 
    redirect_to request.referrer
    flash[:notice] = "Article Deleted Successfully"
  end

  def update_visibility_of_article_true
      @article = Article.find(params[:id])

      if @article.update_attribute(:visibility, true) 
        redirect_to request.referrer 
        flash[:notice] = "Article Published!!"
        else
        redirect_to request.referrer 
        flash[:notice] = "Failed To Publish Article"
      end

  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :visibility)
    end
end