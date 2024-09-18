class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def new
    render partial: "form"
  end

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article), notice: "Comment Posted Successfully.", status: :see_other
  end

  def edit
    # @comment is set by before_action :set_comment
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to article_path(@article), notice: "Comment Updated Successfully.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), notice: "Comment Deleted Successfully.", status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
