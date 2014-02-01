class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :server
end
