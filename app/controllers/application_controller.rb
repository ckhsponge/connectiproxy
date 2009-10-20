# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :authenticate_facebook
  
  protected
  def authenticate_facebook
    begin
      @facebook_session = session[:facebook_session]
      @facebook_user = @facebook_session.user if @facebook_session
      @facebook_user.first_name if @facebook_user #test connection for reals
    rescue Facebooker::Session::SessionExpired
      flash[:note] = "Session expired"
      reset_session
      redirect_to "/"
      return false
    rescue Facebooker::Session::MissingOrInvalidParameter
      flash[:note] = "Facebook error"
      reset_session
      redirect_to "/"
      return false
    end
    return true
  end
end
