class CalendarsController < ApplicationController

  def index
    @calendars = Calendar.order('datum asc')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end

  def edit
    @calendar = Calendar.find(params[:id])
  end



  def update
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      if @calendar.update_attributes(params[:calendar])
        format.html { redirect_to calendars_path, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end
end
