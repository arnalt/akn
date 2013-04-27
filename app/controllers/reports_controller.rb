class ReportsController < ApplicationController
  before_filter :check_period, only: [:output, :output_pdf]

  def input

  end

  def excel
  end

  def pdf

  end

  def output

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def output_pdf

    respond_to do |format|
      format.html { render "output.html.erb", :layout => false }
    end
  end


  def check_period
    if params[:format] == "xls" and
        ((params[:period_begin].to_s).to_date.month != (params[:period_end].to_s).to_date.month)
      flash[:error] = I18n.t("messages.excel_period")
      redirect_to works_path
    else
      @format = params[:format]
      @clientname =params[:Clientname]
      start_at = (params[:period_begin].to_s).to_date
      end_at = (params[:period_end].to_s).to_date
      @works = current_user.works.build_report(start_at, end_at, @clientname).order("date")
      @total_std = current_user.works.build_report(start_at, end_at, @clientname).sum(:working_hours).to_f
      @username = current_user.user_name
      @total_tage = @total_std / 8.0
      @akt_monat = I18n.t("date.month_names")[start_at.to_s[6, 2].to_i]
      @bar_chart= (@works.first.date..@works.last.date).map { |date| Work.total_on(date, @works).to_f }
      @xdata = (@works.first.date..@works.last.date).each.map { |d| d.to_s[8, 2] }
    end
  end

end


