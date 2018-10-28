class AdminsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end
 
  def show
  	@user = User.find(params[:id])
  end
 
  def new
    @user = User.new
  end
 
  def edit
  	@user = User.find(params[:id])
  end
 
  def create
    @user = User.new(user_params)
 
    if @user.save
      redirect_to admin_path(@user), notice: "User succesfully created!"
    else
      render 'new'
    end
  end
 
  def update
    @user = User.find(params[:id])
    if @user.update_without_password(user_params)
      redirect_to admin_url(@user)
    else
      render 'edit'
    end
  end
 
  def destroy
  	@user = User.find(params[:id])
    @user.destroy
    redirect_to admins_path
  end
 

  private
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, attachment_attributes: [:id, :avatar])
  end

end
