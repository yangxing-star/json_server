class ApplicationController < ActionController::Base
  skip_before_filter  :verify_authenticity_token
  before_action :store_location, :set_locale
 
  protected

  def set_current_user(user)
    session[:user_id] = user.id
    @current_user = user
    response.set_cookie( :user_id,
                         :value   => user.id,
                         :path    => "/",
                         :expires => 5.days.from_now )
  end

  def current_user
    @current_user ||= login_from_session
  end

  def require_user
    unless current_user
      respond_to do |format|
        format.html { redirect_to sessions_new_path }
        format.json { render :json => { biz_action: 1, biz_msg: 'please login', return_status: 1005 } }
      end
    else
      I18n.locale = @current_user.locale
      logger.info("current_user_id: #{@current_user.id}")
    end
  end

  def login_from_session
    if session[:user_id].present?
      begin
        User.find session[:user_id]
      rescue
        session[:user_id] = nil
      end
    end
  end

  def logined?
    !!current_user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    response.delete_cookie(:user_id, :path => '/')
  end

  def store_location(path = nil)
    session[:return_to] = path || request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def redirect_referrer_or_default(default)
    redirect_to(request.referrer || default)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
