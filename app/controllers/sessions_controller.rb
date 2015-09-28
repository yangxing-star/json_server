class SessionsController < ApplicationController
  layout 'session'
  
  def new; end

  def create
    begin
      user = User.find_with_login(params[:mobile], params[:password])
      set_current_user(user)
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