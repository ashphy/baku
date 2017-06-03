# frozen_string_literal: true

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

# IRC Server
class Server < ApplicationRecord
  has_many :channels
end
