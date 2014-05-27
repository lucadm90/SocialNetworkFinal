class UsersController < ApplicationController

  before_action :authorize, only: [:show]
  before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to(@user)
    else
      render "edit"
    end
  end

  def edit_password
    @user = User.find(current_user.id)
  end

  def update_password
    @user = User.find(current_user.id)
    if user.update_with_password(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to (@user)
    else
      render "edit_password"
    end
  end




  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    flash[:info] = 'Destroy complete!'
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome in Social Network 2014! #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end

    end


  private
  def user_params
    params.require(:user).permit(:name, :email, :surname, :birth, :password,
                                 :password_confirmation) # aggiunto surname
  end

end