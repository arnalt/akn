class ReportsController < ApplicationController

 def input

 end

  def excel

  end

  def output
    @clientname =params[:Clientname]
    @von = params[:zeitraum_von].to_a
    @bis = params[:zeitraum_bis].to_a
    von = (@von[0][1] +"."+ @von[1][1]+"."+@von[2][1]).to_date
    bis = (@bis[0][1] +"."+ @bis[1][1]+"."+@bis[2][1]).to_date

    @works = current_user.works.where("datum >= ? AND datum <= ? and client_id = ?", von, bis, Client.find_all_by_name(@clientname)).order("datum")
    @total_std =   current_user.works.where("datum >= ? AND datum <= ? and client_id = ?", von, bis, Client.find_all_by_name(@clientname)).sum(:std).to_f
    @username = current_user.user_name
    @total_tage = @total_std / 8.0
    @akt_monat =  I18n.t("date.month_names")[von.to_s[3,2].to_i]
    respond_to do |format|
      format.html # show.html.erb
      format.xls
      format.json { render json: @work }
    end

  end
  end


