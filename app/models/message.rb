class Message < ActiveRecord::Base
  belongs_to :channel

  validates_presence_of :text
  validates_length_of :text, maximum: 512

  validates_presence_of :user
  validates_length_of :user, maximum: 20

  validates_presence_of :command
  validates :command, :inclusion => ['PRIVMSG', 'NOTICE']

  def surrounding_log_link_param
    {
      controller: 'channels',
      action: 'index',
      id: channel.name_without_sign,
      year: channel.created_at.year,
      month: channel.created_at.month,
      day: channel.created_at.day
    }
  end
end
