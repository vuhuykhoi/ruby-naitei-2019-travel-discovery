class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def destroy
    @post_id = @post.id
    respond_to do |format|
      format.html{redirect_to current_user}
      if @post.destroy
        format.js{flash[:success] = t "flash.success.micropost_deleted"}
      else
        format.js{flash[:danger] = t "flash.danger.delete_micropost_fail"}
      end
    end
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
