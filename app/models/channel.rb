# frozen_string_literal: true

# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  server_id  :integer
#  name       :string(255)
#  active     :boolean          default(TRUE), not null
#  boolean    :boolean          default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#  key        :string(255)
#

# IRC Channel
class Channel < ApplicationRecord
  has_many :messages
  has_many :log_stats
  belongs_to :server

  scope :actives, -> { where(active: true) }

  def self.get_channel(name)
    Channel.find_by!(name: name)
  end

  def name_without_sign
    name.delete('#')
  end

  def topics
    Message.where(channel_id: id).where(command: 'TOPIC')
  end

  def no_messages?
    messages.count.zero?
  end
end
