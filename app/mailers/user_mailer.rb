class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = 'http://test.yangxing.me'
    mail(to: @user.email, subject: 'This is a confidential email.')
  end

end