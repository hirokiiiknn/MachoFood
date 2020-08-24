class TweetsController < ApplicationController
  before_action :hoge_tweet, except: [:index, :new, :create, :search]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new 
    @tweet = Tweet.new
  end
  
  def create
    tweet = Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.where("title LIKE ?", "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json 
    end
  end

  
  private
  def tweet_params
    params.require(:tweet).permit(:id, :protein,:carb,:fat,:detail, :image, :title, :likes_count).merge(user_id: current_user.id)
  end

  def hoge_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
end
