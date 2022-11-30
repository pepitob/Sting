class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to root_path
  #   # check if root_path is right
  # end


end
