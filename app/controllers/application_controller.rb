class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :set_locale
  before_filter :current_locale

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  def set_locale
    I18n.locale = params[:locale]
  end

  def current_locale
    I18n.locale.to_s
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end

    def locale_path(locale)
    locale_regexp = %r{/(en|de) /?}
    if request.env['PATH_INFO'] =~ locale_regexp
      "#{request.env['PATH_INFO']} "
    else
      if ['en', 'de'].include?(I18n.locale.to_s)
        "#{request.env['PATH_INFO']}".gsub("/#{ current_locale }", "/#{locale}")
      end
    end
  end

  helper_method :locale_path
end
