class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t "flash.success.micropost_created"
    end
      redirect_to current_user
  end

  def destroy
    if @post.destroy
      flash[:success] = t "flash.success.micropost_deleted"
    else
      flash[:danger] = t "flash.danger.delete_micropost_fail"
    end
    redirect_to current_user
  end

  def post_params
    params.require(:post).permit :title, :content, :travel_place_id
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
