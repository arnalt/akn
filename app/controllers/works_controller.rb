class WorksController < ApplicationController

  def home

  end

  def index
    @works = current_user.works.order("date")
    @username = current_user.user_name
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
    end
  end


  def show

  end


  def new
    @work = current_user.works.build
    @client = Client.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work }
    end
  end


  def edit
    @work = current_user.works.find(params[:id])
    @client = Client.all
  end


  def create
    @work = current_user.works.build(params[:work])
    respond_to do |format|
      if @work.save
        format.html { redirect_to works_path, notice: 'Work was successfully created.' }
        format.json { render json: works_path, status: :created, location: @work }
      else
        format.html { render action: "new" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @work = current_user.works.find(params[:id])

    respond_to do |format|

      if @work.update_attributes(params[:work])

        format.html { redirect_to works_path, notice: 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @work = current_user.works.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to works_url }
      format.json { head :no_content }
    end
  end


end
