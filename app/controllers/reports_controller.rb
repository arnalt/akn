class ReportsController < ApplicationController

  def index

  @reports = current_user.works.where("monat").group("monat", "client_id").order("monat DESC")
 # @monat = monat_akt
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
   end
  end

  end


