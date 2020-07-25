class CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    redirect_to "/tweets/#{comment.tweet.id}"
  end

  privaate
  def comment_params
    params.reuire(;comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
