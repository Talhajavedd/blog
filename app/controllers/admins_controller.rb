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
    @user = User.new(a)
 
    if @user.save
      flash[:notice] = "Successfully created product."
      redirect_to @user
    else
      render 'new'
    end
  end
 
  def update

    if @user.update(configure_permitted_parameters)
      redirect_to @user
    else
      render 'edit'
    end
  end
 
  def destroy
  	@user = User.find(params[:id])
    @user.destroy
    redirect_to admins_path
  end
 

  def a
    {
    |u| u.permit(:username, :remember_me, :email, :password, :password_confirmation, attachment_attributes: [:id, :avatar], roles_attributes: [:id, :name])
    }
  end


  private
    def article_params
    end

end
