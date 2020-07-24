class UsersController < ApplicationController
  # def edit
  #   @nickname = current_user.nickname
  #   @tweets = current_user.tweets
  #   @introduce = current_user.introduce
  # end
  
  # def update
  #   user = User.find(params[:id])
  #   user.update(user_params)
  # end
  
  # private
  # def user_params
  #   params.require(:user).permit(:nickname, :introduce)
  # end



  def show
    user = User.find(params[:id])
    @nickname = current_user.nickname
    @tweets = current_user.tweets
    @introduce = current_user.introduce
  end
end
