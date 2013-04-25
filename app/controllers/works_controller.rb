class WorksController < ApplicationController
  before_filter :filled_clients, only: [:new, :edit, :create, :tasks]


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
    @work.client_id = Task.find(@work.task_id).client.id
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

  def tasks

  end

  def filled_clients
    @clients=Client.all
    @tasks=Task.all
  end

end
