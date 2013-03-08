class SessionsController < ApplicationController
  def new

  end

  def create
  #  if (cookies[:user_id] == nil)
       user = User.find_by_email(params[:email])
       if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          cookies[:user_id] = user.id
          redirect_to works_path,
                  notice: "Sie haben sich angemeldet!"
       else
           flash.now.alert = "Fehlerhafte E-Mail-Adresse oder Passwort"
           render "new"
       end
  #  else
  #    session[:user_id] = cookies[:user_id]
  #    redirect_to works_path
  #  end
  end

  def destroy
    session[:user_id]= nil
    redirect_to root_path,
                notice: "Sie haben sich abgmeldet!"
  end
end
