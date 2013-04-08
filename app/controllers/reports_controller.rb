class ReportsController < ApplicationController

  def input
  end

  def excel
  end

  def output
    @clientname =params[:Clientname]
    von = (params[:zeitraum_von].to_s).to_date
    bis = (params[:zeitraum_bis].to_s).to_date
    @works = current_user.works.build_report(von, bis, @clientname).order("datum")
    @total_std = current_user.works.build_report(von, bis, @clientname).sum(:std).to_f
    @username = current_user.user_name
    @total_tage = @total_std / 8.0
    @akt_monat = I18n.t("date.month_names")[von.to_s[6, 2].to_i]
    respond_to do |format|
      format.html # show.html.erb
      format.xls
      format.json { render json: @work }
    end
  end
end


