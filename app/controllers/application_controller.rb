class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end




  private
  def monat_akt
   @a = current_user.works.order("datum DESC")
     m = @a[0].datum.to_s[5,2].to_i
    @monat = I18n.t("date.month_names")[1..m]
  end

end
