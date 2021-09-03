class UsersController < ApplicationController


  def index
  end

  def show
    @user = User.find(params[:id])
    @follows = Relationship.where(follower_id: @user.id)
    friends_id =[]
    @follows.each do |follow|
      friends_id << follow.followed_id
    end
    # binding.pry
    user = {id: @user.id, name: @user.name, friends: friends_id}
    render json: user
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end

end
