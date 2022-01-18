class UsersController < ApplicationController
  before_action :authorized
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 8).order("created_at DESC")
  end

  # search user list
  def search
    @query = params[:query]
    @users = User.where("users.name LIKE ?",["%#{@query}%"]).paginate(page: params[:page], per_page: 8).order("created_at DESC")
    render :index
  end

  def show
  end

  def profile
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user[:create_user_id] = current_user.id
    if @user.save
      # session[:user_id] = @user.id
      redirect_to users_path
    else 
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    if !logged_in? || !@user
      redirect_to root_path
    end
  end

  def update
    # Rails.logger.debug("sulaemon#{user_params}")
    @user = User.find_by(id: params[:id])
    if(@user.update(user_params))
      redirect_to users_path, :notice => "Your user has been updated!"
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private
  
  # user parameters
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :profile, :role, :phone, :address, :dob, :create_user_id, :updated_user_id, :deleted_user_id, :created_at, :updated_at)
  end

  def set_user
    @user = User.find_by_id(params[:id])
  end

end
