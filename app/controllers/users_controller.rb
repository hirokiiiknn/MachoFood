class UsersController < ApplicationController

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
    user = User.find(params[:id])
    @id = user.id
    @nickname = user.nickname
    @tweets = user.tweets
    @introduce = user.introduce
    @image = user.image
    @profile = user.profile
  end

  private
  def user_params
    params.require(:user).permit(:id,:nickname, :introduce, :tweets, :image, :profile)
  end

end
