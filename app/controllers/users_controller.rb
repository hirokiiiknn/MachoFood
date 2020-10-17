class UsersController < ApplicationController

  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def edit
    user = User.find(params[:id])
    @image = user.image
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  def show
    @user = User.find(params[:id])
    @id = @user.id
    @nickname = @user.nickname
    @tweets = @user.tweets
    @image = @user.image
    @profile = @user.profile
  end

  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
    render partial: 'show_follow'
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
    render partial: 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:instagram, :facebook, :twitter, :id,:nickname, :tweets, :image, :profile)
  end

end
