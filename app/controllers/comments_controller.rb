class CommentsController < ApplicationController
  before_action :logged_in_user

  def show
    @post_id = params[:id]
    @list_post_comments = Comment.create_desc.where "post_id = ?", params[:id]
    respond_to do |format|
        format.html
        format.js
    end
  end

  def create
    @post_id = comment_params[:post_id]
    @comment = current_user.comments.build comment_params
    @comment.save
    @list_post_comments = Comment.create_desc.where "post_id = ?", @post_id
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @post_id = @comment.post_id
    @list_post_comments = Comment.create_desc.where "post_id = ?", @post_id
    @comment.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
