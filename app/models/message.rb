class Message < ActiveRecord::Base
  belongs_to :channel

  validates_presence_of :text
  validates_length_of :text, maximum: 512

  validates_presence_of :user
  validates_length_of :user, maximum: 20

  validates_presence_of :command
  validates :command, :inclusion => ['PRIVMSG', 'NOTICE']

end
