class Message < ActiveRecord::Base
  belongs_to :channel

  validates :text, presence: true
  validates_length_of :text, maximum: 512

  validates :user, presence: true
  validates_length_of :user, maximum: 20

  validates :command, presence: true
  validates :command, inclusion: %w(PRIVMSG NOTICE)

  scope :daily_log, -> (channel, date) { where(created_at: date.beginning_of_day..date.end_of_day).where(channel_id: channel.id) }

  def surrounding_log_link_param
    {
      controller: 'channels',
      action:     'index',
      id:         channel.name_without_sign,
      year:       created_at.year,
      month:      created_at.month,
      day:        created_at.day
    }
  end
end
