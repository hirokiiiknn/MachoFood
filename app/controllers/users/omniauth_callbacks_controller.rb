# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

#   def facebook
#     callback_for(:facebook)
#   end

#   def google_oauth2
#     callback_for(:google)
#   end


#   def callback_for(provider)
#     @omniauth = request.env['omniauth.auth']
#     info = User.find_oauth(@omniauth)
#     @user = info[:user]
#     if @user.persisted? 
#       sign_in_and_redirect @user, event: :authentication
#       set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
#     else 
#       @sns = info[:sns]
#       render template: "devise/registrations/new" 
#     end
#   end

#   def failure
#     redirect_to root_path and return
#   end
# end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # callback for facebook
  def facebook
    callback_from :facebook
  end

  # callback for twitter
  # def twitter
  #   callback_for(:twitter)
  # end

  # callback for google
  def google_oauth2
    callback_from :google
  end

  def twitter
    callback_from :twitter
  end

  def failure
    redirect_to new_user_registration_url
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'].except('extra'))

    if @user.persisted? # DBに保存済みかどうかを判定
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_session_url
    end
  end
end