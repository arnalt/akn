class WorksController < ApplicationController
  # GET /works
  # GET /works.json
  def index
    @works = current_user.works.order("datum")
    @username = current_user.user_name
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
    end
  end

  # GET /works/1
  # GET /works/1.json
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
    respond_to do |format|
      format.html # show.html.erb
      format.csv { send_data @products.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
      format.json { render json: @work }
    end
  end

  # GET /works/new
  # GET /works/new.json
  def new
    @work = current_user.works.build
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
      respond_to do |format|
      if @work.save
        format.html { redirect_to works_path, notice: 'Datensatz wurde angelegt.' }
        format.json { render json: works_path, status: :created, location: @work }
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

    respond_to do |format|

     if @work.update_attributes(params[:work] )

        format.html { redirect_to works_path, notice: 'Daten wurden geaendert.' }
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
