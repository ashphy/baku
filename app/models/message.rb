# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  channel_id :integer
#  text       :string(512)
#  user       :string(20)       not null
#  command    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Message < ActiveRecord::Base
  belongs_to :channel

  validates :text, presence: true
  validates_length_of :text, maximum: 512

  validates :user, presence: true
  validates_length_of :user, maximum: 20

  validates :command, presence: true
  validates :command, inclusion: %w(PRIVMSG NOTICE TOPIC)

  scope :daily_log, -> (channel, date) { where(created_at: date.beginning_of_day..date.end_of_day).where(channel_id: channel.id) }
  scope :search_with, -> (query) { where("match(text) against(\"#{query}\")") }

  def surrounding_log_link_param
    {
      controller: 'logs',
      action:     'index',
      id:         channel.name_without_sign,
      year:       created_at.year,
      month:      created_at.month,
      day:        created_at.day,
      anchor:     id
    }
  end
end
