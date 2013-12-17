class SessionsController < ApplicationController
  def new

  end

  def create
    if params[:session][:email].rindex('@')
      user = User.find_by_email(params[:session][:email].downcase)
    else
      user = User.find_by_login(params[:session][:email])
    end
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
