class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      log_in user
      check_remember_box user
      redirect_back_or user
    else
      respond_to do |format|
        format.html{render :new}
        format.js{flash[:danger] = t("flash.danger.invalid_user_infor")}
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  private

  def check_remember_box user
    if params[:session][:remember_me] == Settings.remember_box.is_checked
      remember user
    else
      forget user
    end
  end
end
