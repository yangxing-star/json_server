class UsersController < ApplicationController
  layout 'session'

  def new; end

  def create
    user = User.new(email: params[:email], nickname: params[:nickname], password: params[:password])
    if user.save
      set_current_user(user)
      UserMailer.welcome_email(user).deliver_now
      redirect_to controller: :apis, action: :index
    else
      flash[:error] = user.errors.full_messages.to_s
      render 'users/new'
    end
  end

end