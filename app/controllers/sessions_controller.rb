class SessionsController < ApplicationController
  include SessionsHelper
  before_action :check_login, only: [:new, :create]

  def new
  end

  def create
  	@user = User.find_by(username: params[:user][:username], password: params[:user][:password])
  	
    if @user
      flash[:notice] = "You have successfully logged in."
      set_session @user, true
      redirect_to articles_path
  	else
      flash[:error] = "error."
      render 'new'
  	end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
  def check_login
    if logged_in?
      redirect_to articles_path
    end
  end
end
