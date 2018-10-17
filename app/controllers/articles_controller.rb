class ArticlesController < ApplicationController
  include SessionsHelper
  before_action :require_login
  def index
  	@articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def new
  	@article = Article.new
  end

  def edit
  	@article = Article.find(params[:id])
    unless @article.user_id == current_user.id
      redirect_to articles_path
    end
  end

  def create
  	@article = Article.new(article_params)
    @article.user = current_user
  	if @article.save
  		redirect_to @article
  	else
  		render 'new'
  	end
  end

  def update
  	@article = Article.find(params[:id])
    if @article.user_id == current_user.id
  	 if @article.update(article_params)
  	 	 redirect_to @article
  	 else
  		  render 'edit'
  	 end
    else
      redirect_to articles_path
    end
  end

  def destroy
  	@article = Article.find(params[:id])
    if @article.user_id == current_user.id
  	 @article.destroy
    end
  	redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url
    end
  end
end
