class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy


  def index
    @users = User.order('lastname')

  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the AKN App!"
      redirect_to @user
    else
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    begin
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
    rescue ActiveRecord::DeleteRestrictionError => e
       flash[:error] = "#{e}"
      redirect_to users_path
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_path, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

 def report
   @user = User.find(params[:id])
   @works = User.find(params[:id]).works.paginate page: params[:page], order: 'date desc', per_page: 10

   respond_to do |format|
     format.html { render 'show.html.erb' }
   end
 end
end
