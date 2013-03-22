class ReportsController < ApplicationController

  def index

  @monat = monat_akt
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
   end
  end

  def show
    #  @work = current_user.works.find(params[:id])
    @arr = I18n.t("date.month_names")
    mo = (@arr.index params[:name]).to_s
    if (mo.length < 2)
      mo = "0" + mo
    end

    @works = current_user.works.where("substr(datum,6,2) = ?", mo )
    @total_std = 0.0
    @works.each do |w|
      @total_std += w.std.to_f
    end
    @akt_monat = params[:name]
    @username = current_user.user_name
    @total_tage = @total_std / 8.0
    respond_to do |format|
      format.html # show.html.erb
      format.xls
      format.json { render json: @work }
    end
  end

end


