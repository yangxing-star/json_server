class ProfilesController < ApplicationController
  before_action :require_user

  def change_locale
    @current_user.update(locale: params[:locale])
    redirect_referrer_or_default root_path
  end

end