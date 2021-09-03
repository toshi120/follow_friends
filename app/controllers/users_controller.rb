class UsersController < ApplicationController


  def index
  end

  def show
    @user = User.find(params[:id])
    user = {id: @user.id, name: @user.name}
    # render json: @user
  end

end
