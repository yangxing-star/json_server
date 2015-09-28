class User < ActiveRecord::Base
  include BCrypt

  has_many :apis

  validates_presence_of :mobile, :nickname
  validates :mobile, format: { with: /\A1\d{10}\z/ }

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def auth_password(password)
    self.password == password
  end

  class << self
    def find_with_login(mobile, password)
      raise 'Please enter mobile' if mobile.blank?
      raise 'Please enter password' if password.blank?

      user = User.find_by(mobile: mobile)
      raise 'Mobile or password is wrong' unless user.password == password
      user
    end
  end

end
