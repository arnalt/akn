class WorksController < ApplicationController
  # GET /works
  # GET /works.json
  def index
    @works = current_user.works
    @username = user_name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
    end
  end

  # GET /works/1
  # GET /works/1.json
  def show
    @work = current_user.works.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work }
    end
  end

  # GET /works/new
  # GET /works/new.json
  def new
    @work = current_user.works.build
    @work.von = "07:30"
    @work.bis = "16:00"
    @work.mm = "00:30"
    @work.pbez = "Intern"
    @work.kunde = "Testkunde"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = current_user.works.find(params[:id])
  end

  # POST /works
  # POST /works.json
  def create
    @work = current_user.works.build(params[:work])
    @work.kw = kalw(@work.datum)
    @work.tag = wtag(@work.datum)
    @work.std = pstd(@work.von, @work.bis, @work.mm)

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render json: @work, status: :created, location: @work }
      else
        format.html { render action: "new" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.json
  def update
    @work = current_user.works.find(params[:id])
    @work.kw = kalw(@work.datum)
    @work.tag = wtag(@work.datum)
    @work.std = pstd(@work.von, @work.bis, @work.mm)

    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work = current_user.works.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to works_url }
      format.json { head :no_content }
    end
  end
end
