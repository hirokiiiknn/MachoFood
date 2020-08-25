class ApplicationController < ActionController::Base
  class MyLogger < Logger
    include ActiveSupport::LoggerSilence
    include LoggerSilence
    include ActiveSupport::LoggerThreadSafeLevel
  end

  before_action :mylogger_test
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :image])
  end

  def mylogger_test
    mylogger = MyLogger.new(STDOUT)
    mylogger.silence do
      mylogger.debug("controller = #{controller_name}")
      mylogger.info("action = #{action_name}")
      mylogger.error("controler#action = #{controller_name}##{action_name}")
    end
  end
end






