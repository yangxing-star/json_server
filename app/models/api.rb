class Api < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :url, :method, :data

  after_save do
    Rails.application.reload_routes!
  end
end