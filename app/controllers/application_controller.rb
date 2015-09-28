class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  skip_before_filter  :verify_authenticity_token

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
        format.html { redirect_to new_session_path }
        format.json { render :json => { biz_action: 1, biz_msg: 'please login', return_status: 1005 } }
      end
    else
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

  def logout
    session.delete(:user_id)
    @current_user = nil
    response.delete_cookie(:user_id, :path => '/')
  end
end