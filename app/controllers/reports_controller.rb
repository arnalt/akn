class ReportsController < ApplicationController
  before_filter :check_period, only: :output
  before_filter :check_work, only: [:output, :output_pdf]

  def input
    @format = 'html'
    @users = User.all
  end

  def excel
    @format = 'xls'
  end

  def pdf
    @format = 'pdf'
  end

  def statistics

  end

  def admperiod
    @users = User.all
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])
    if @report.valid?
      @start_at = @report.period_begin.to_s.to_date
      @end_at = @report.period_end.to_s.to_date
      @project = @report.projectname.to_s
      @clientname = @project.split(' ').at(1)
      @projectname = @project.split(' ').at(0)
      @user_id =@report.username.to_s.split(' ').at(1).to_i

      if Client.get_client_id(@clientname).empty?
        flash[:error] = I18n.t("messages.empty_work")
        redirect_to works_path
      else
        @client_id = Client.get_client_id(@clientname).at(0).id
        @project_id = Project.get_project_id(@projectname,@client_id).at(0).id
        if @report.passed == '1'
          Work.report_passed(@user_id, @start_at, @end_at, @project_id)
        end
        if @report.passed == '2'
          Work.report_unpassed(@user_id, @start_at, @end_at, @project_id)
        end
        flash[:error] = "OK"
        redirect_to works_path
      end
    else
      @users = User.all
      render "reports/admperiod"
    end
  end

  def output
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def output_pdf
    @format = 'pdf'
    if params[:sending_email] == "1"

      if params[:email].to_s.empty?
        flash[:notice] = t("messages.report_email_missing")
        redirect_to pdf_path
      else

        if (params[:email].to_s =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)

          UserMailer.report_email(params[:email], @works, @xdata, @bar_chart,
                                  @w_avg, @w_days, @w_max, @w_min, @format).deliver
          flash[notice] = t("messages.report_email_sent")
          redirect_to works_path
        else
          flash[:notice] = t("messages.report_email_invalid")
          redirect_to pdf_path
        end
      end
    else
      respond_to do |format|
        format.html { render "output.html.erb", :layout => false }
      end
    end
  end

  def yearstats
    if params[:user].present?
      @user = User.find(params[:user].split(' ').at(0).to_i)
    else
      @user = current_user
    end
    @year = params[:year]
    @mons = I18n.t("date.month_names")
    @soll = 160
    @month_array = []
    @task = Task.find_by_name('Gleittag')
    @ta   = Task.find_by_name('Urlaub')
    ind = 1
    12.times do
      @month_array << Work.statistics_build(@user.id, @year, ind, @task.id, @ta.id)
      ind += 1
    end
    @total_hours = @month_array.sum
    @task = Task.find_by_name('Urlaub')
    if @task.present?
      @holiday_array=[]
      ind = 1
      12.times do
        @holiday_array << Work.statistics_holidays(@user.id, @year, ind, @task.id)
        ind += 1
      end
      @total_holidays = @holiday_array.sum
    else
      @holiday_array = []
    end
    @total_soll = @user.annual_hours
  end

  def check_period
    if params[:format] == "xls" and
        ((params[:period_begin].to_s).to_date.month != (params[:period_end].to_s).to_date.month)
      flash[:error] = I18n.t("messages.excel_period")
      redirect_to works_path
    end

  end

  def check_work
    if params[:period_begin] == [""] or
        params[:period_end] == [""]
      flash[:error] = I18n.t("messages.empty_work")
      redirect_to works_path
    else
      @start_at = (params[:period_begin].to_s).to_date
      @end_at = (params[:period_end].to_s).to_date
      @project = params[:projectname].to_s
      @projectname = @project.split(' ').at(0)
      @clientname = @project.split(' ').at(1)

      if Client.get_client_id(@clientname).empty?
        flash[:error] = I18n.t("messages.empty_work")
        redirect_to works_path
      else
        @client_id = Client.get_client_id(@clientname).at(0).id
        @project_id = Project.get_project_id(@projectname,@client_id).at(0).id
        @works = current_user.works.build_report(@start_at, @end_at, @project_id).order("date")
        if @works.empty?
          flash[:error] = I18n.t("messages.empty_work")
          redirect_to works_path
        else
          @total_std = current_user.works.build_report(@start_at, @end_at, @project_id).sum(:working_hours).to_f
          @username = current_user.user_name
          @total_tage = @total_std / 8.0
          @akt_monat = I18n.t("date.month_names")[@start_at.to_s[6, 2].to_i]
          @bar_chart= (@works.first.date..@works.last.date).map { |date| Work.total_on(date, @works).to_f }
          @xdata = (@works.first.date..@works.last.date).each.map { |d| d.to_s[8, 2] }
          @w_avg = current_user.works.get_avg(@start_at, @end_at, @project_id)
          @w_min = current_user.works.get_min(@start_at, @end_at, @project_id)
          @w_max = current_user.works.get_max(@start_at, @end_at, @project_id)
          @w_days = current_user.works.get_days(@start_at, @end_at, @project_id)
        end
      end
    end
  end
end






