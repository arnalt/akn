class WorksController < ApplicationController
  before_filter :filled_clients, only: [:new, :edit, :create, :tasks]

   def index
   @works = current_user.works.order('date DESC')
   @username = current_user.user_name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
    end
  end


  def show
    @work = Work.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
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
    @work.project_id = Task.find(@work.task_id).project.id
    @work.client_id = Project.find(@work.project_id).client.id
    respond_to do |format|
      if @work.save
        format.html { redirect_to works_path, notice:  t('messages.work_successfully_created') }
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

        format.html { redirect_to works_path, notice: t('messages.work_successfully_updated') }
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

  def finalize
    @work = current_user.works.find(params[:id])
    Work.works_finalize(current_user.id,@work.date)
    redirect_to works_path
  end
end
