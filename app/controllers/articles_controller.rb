class ArticlesController < ApplicationController
  before_action :authenticate_user! , except: [:index, :show]

  def index
    @articles = Article.all
    render "index"
  end

  def show
    @article = Article.find(params[:id])
    render "show"
  end

  def new
    @article = Article.new
    render "new"
  end

  # def create
  #   #render json: params
  #   @article = Article.new
  #   @article.title = params[:title]
  #   @article.body = params[:body]
  #   if @article.save
  #     redirect_to "/articles/#{@article[:id]}" , allow_other_host: true
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article, notice: "Article Created Successfully.", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, notice: "Article Updated Successfully.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other, notice: "Article Deleted Successfully."
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

end
