class Api < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :url, :method, :data
end