class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_attributes, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.order(:title).page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @articles}
      format.json { render json: @articles}
    end
  end
 
  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.page(params[:page])
  end
 
  def new
    @article = current_user.articles.build
    @article.attachments.build
  end
 
  def edit
  end
 
  def create
    @article = current_user.articles.build(article_params)
 
    if @article.save
    	flash[:notice] = "Successfully created product."
      redirect_to @article
    else
      render 'new'
    end
  end
 
  def update
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
 
  def destroy
    @article.destroy
 
    redirect_to articles_path
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :text, attachments_attributes: [:id, :avatar, :_destroy])
    end

    def find_attributes
    	@article = Article.find(params[:id])
    end

end
