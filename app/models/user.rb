class User < ActiveRecord::Base
  include BCrypt

  has_many :apis

  validates_presence_of :email, :nickname
  validates :email, format: { with: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }, uniqueness: true

  before_create do
    self.token = secure_token.downcase
  end

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
    def find_with_login(email, password)
      raise 'Please enter email' if email.blank?
      raise 'Please enter password' if password.blank?

      user = User.find_by(email: email)
      raise 'Email or password is wrong' if user.nil? || user.password != password
      user
    end
  end

  private
  def secure_token(length = 16)
    SecureRandom.hex(length / 2)
  end

end
