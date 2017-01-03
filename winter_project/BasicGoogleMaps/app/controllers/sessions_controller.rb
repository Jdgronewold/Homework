class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login(@user)
      redirect_to users_url(@user)
    else
      flash[:errors] = "Invalid Username or Password"
      redirect_to :new
    end

  end

  def destroy
    logout
    redirect_to :new
  end

  def new
    # @user = User.find(params[:id])
    render :new
  end
end
