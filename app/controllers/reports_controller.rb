class ReportsController < ApplicationController
  before_filter :check_period, only: :output
  before_filter :check_work, only: [:output, :output_pdf]

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
    @format = 'pdf'
    respond_to do |format|
      format.html { render "output.html.erb", :layout => false }
    end
  end

  def check_period
    if params[:format] == "xls" and
        ((params[:period_begin].to_s).to_date.month != (params[:period_end].to_s).to_date.month)
      flash[:error] = I18n.t("messages.excel_period")
      redirect_to works_path
    end
  end

  def check_work
    @start_at = (params[:period_begin].to_s).to_date
    @end_at = (params[:period_end].to_s).to_date
    if   Client.get_client_id(params[:clientname]).empty?
      flash[:error] = I18n.t("messages.empty_work")
      redirect_to input_path
    else
      @client_id = Client.get_client_id(params[:clientname]).at(0).id
      @works = current_user.works.build_report(@start_at, @end_at, @client_id).order("date")
      if @works.empty?
        flash[:error] = I18n.t("messages.empty_work")
        redirect_to input_path
      else
        @total_std = current_user.works.build_report(@start_at, @end_at, @client_id).sum(:working_hours).to_f
        @username = current_user.user_name
        @total_tage = @total_std / 8.0
        @akt_monat = I18n.t("date.month_names")[@start_at.to_s[6, 2].to_i]
        @bar_chart= (@works.first.date..@works.last.date).map { |date| Work.total_on(date, @works).to_f }
        @xdata = (@works.first.date..@works.last.date).each.map { |d| d.to_s[8, 2] }
        @w_avg = current_user.works.get_avg(@start_at, @end_at, @client_id)
        @w_min = current_user.works.get_min(@start_at, @end_at, @client_id)
        @w_max = current_user.works.get_max(@start_at, @end_at, @client_id)
        @w_days = current_user.works.get_days(@start_at, @end_at, @client_id)
      end
    end
   end
end


