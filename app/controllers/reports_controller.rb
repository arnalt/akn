class ReportsController < ApplicationController

  def index

  @reports = current_user.works.where("monat").group("monat", "client_id").order("monat DESC")
 # @monat = monat_akt
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
   end
  end

  def show


    @w = current_user.works.find(params[:id])
    @works = current_user.works.where("monat = ? AND client_id = ?", @w.monat, @w.client_id)
    @total_std = 0.0
    @works.each do |w|
      @total_std += w.std.to_f
    end
    @akt_monat = I18n.t("date.month_names")[@w.monat]
    @username = current_user.user_name
    @total_tage = @total_std / 8.0
    respond_to do |format|
      format.html # show.html.erb
      format.xls
      format.json { render json: @work }
    end
  end

end


