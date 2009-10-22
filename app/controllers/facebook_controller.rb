class FacebookController < ApplicationController
  skip_before_filter :authenticate_facebook
  
  def authenticate
    @facebook_session = Facebooker::Session.create(Facebooker.api_key, Facebooker.secret_key)
    session[:facebook_session] = @facebook_session
    redirect_to @facebook_session.login_url
  end
  
  def sign_in
    @facebook_session = session[:facebook_session] = secure_with_token!
    raise "no facebook session" unless @facebook_session
    @facebook_user = @facebook_session.user
    redirect_to "/users/list"
  end
  
  def proxy
    @facebook_session = Facebooker::Session.create(Facebooker.api_key, Facebooker.secret_key)
    @facebook_session.auth_token = params['auth_token']
    secure = @facebook_session.secure_with_session_secret!
    render :xml => auth_session_xml(@facebook_session, "Rails says hello.")
  end
  
  protected
  def auth_session_xml(facebook_session, meta_data = nil)
    xm = Builder::XmlMarkup.new(:indent => 2)
    xm << '<auth_getSession_response xmlns="http://api.facebook.com/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://api.facebook.com/1.0/ http://api.facebook.com/1.0/facebook.xsd">'
    xm.session_key facebook_session.session_key
    xm.expires "0"
    xm.uid facebook_session.user.id
    xm.secret facebook_session.secret_from_session
    xm.meta_data meta_data if meta_data
    xm << '</auth_getSession_response>'
    xml = xm.target!
  end
end
