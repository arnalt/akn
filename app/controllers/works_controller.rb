class WorksController < ApplicationController
  before_filter :filled_clients, only: [:new, :edit, :create]


  def home

  end

  def index
    @works = current_user.works.order("date DESC")
    @username = current_user.user_name
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
    end
  end


  def show
  @work = Work.find(params[:id])
  @works = []
#  @works = current_user.works.build_works_by_client(@task.client.id)
#  @total_hours = current_user.works.build_works_by_client(@task.client.id).sum(:working_hours).to_f
  respond_to do |format|
    format.html
    format.json { render json: @work }
  end
  end


  def new
    @work = current_user.works.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work }
    end
  end


  def edit
    @work = current_user.works.find(params[:id])
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

  def sel_task
    @tasks = Task.all
    respond_to do |format|
      format.html
    end
  end

  def filled_clients
    @clients=Client.all
  end

end
