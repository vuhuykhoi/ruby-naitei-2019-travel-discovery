class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :load_user,
    only: %i(show edit update following followers)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "flash.success.welcome_message"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @posts = @user.posts.create_desc.page(
      params[:page]
    ).per Settings.num_feeds_per_page
    redirect_to(root_url) && return unless @user
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.success.profile_updated_message"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.admin?
      flash[:danger] = t"flash.danger.cannot_delete_admin"
    elsif @user.destroy
      flash[:success] = t "flash.success.user_deleted_message"
    else
      flash[:danger] = t"flash.danger.cannot_deleted"
    end
    redirect_to users_url
  end

  def following
    @title = t "label.following"
    @users = @user.following.page params[:page]
    render :show_follow
  end

  def followers
    @title = t "label.followers"
    @users = @user.followers.page params[:page]
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :username, :email, :date_of_birth, :gender,
      :password, :password_confirmation
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t "flash.danger.not_correct_user"
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t "flash.danger.not_admin"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.danger.user_not_found"
    redirect_to root_path
  end
end
