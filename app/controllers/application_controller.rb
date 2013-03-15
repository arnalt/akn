class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end




  def monat_akt
    @a = current_user.works.where("user_id = ?", current_user)
    @a = @a.order("datum DESC")
    m = @a[0].datum.to_s[5,2].to_i
    @monat = I18n.t("date.month_names")[1..m]
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method  :user_signed_in?

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to root_path, notice: "Melden Sie sich an"
    end
  end

end
