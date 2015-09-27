class UsersController < ApplicationController
  layout 'session'

  def new; end

  def create
    user = User.new(mobile: params[:mobile], nickname: params[:nickname], password: params[:password])
    if user.save
      set_current_user(user)
      redirect_to controller: :apis, action: :index
    else
      flash[:error] = user.errors.full_messages.to_s
      render 'users/new'
    end
  end

end