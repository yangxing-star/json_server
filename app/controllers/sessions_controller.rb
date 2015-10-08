class SessionsController < ApplicationController
  layout 'session'
  
  def new
    redirect_to controller: :apis, action: :index if logined?
  end

  def create
    begin
      user = User.find_with_login(params[:email], params[:password])
      set_current_user(user)
      UserMailer.welcome_email(user).deliver_now
      redirect_to controller: :apis, action: :index
    rescue => e
      flash[:error] = e.message
      render 'sessions/new'
    end
  end

  def destroy
    logout
    redirect_to action: :new
  end

end