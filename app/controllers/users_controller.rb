class UsersController < ApplicationController
  
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @slots) }
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice => "New User Added!"
    else
      render "new"
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

end