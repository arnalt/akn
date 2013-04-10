class ReportsController < ApplicationController


  def input
  end

  def excel
  end

   def output
    @clientname =params[:Clientname]
    start_at = (params[:period_begin].to_s).to_date
    end_at = (params[:period_end].to_s).to_date
    @works = current_user.works.build_report(start_at, end_at, @clientname).order("date")
    @total_std = current_user.works.build_report(start_at, end_at, @clientname).sum(:working_hours).to_f
    @username = current_user.user_name
    @total_tage = @total_std / 8.0
    @akt_monat = I18n.t("date.month_names")[start_at.to_s[6, 2].to_i]
    respond_to do |format|
      format.html # show.html.erb
      format.xls
      format.json { render json: @work }
    end
  end


end


