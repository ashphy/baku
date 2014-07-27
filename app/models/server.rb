# == Schema Information
#
# Table name: servers
#
#  id         :integer          not null, primary key
#  host       :string(255)
#  encoding   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Server < ActiveRecord::Base
  has_many :channels
end
