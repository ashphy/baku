class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :server

  scope :joins, -> { where(joined: true) }

  def self.get_channel(name)
    Channel.where(name: name).first
  end

  def name_without_sign
    self.name.delete('#')
  end

  def years
    Message.where(channel_id: id).uniq.pluck("EXTRACT(YEAR FROM created_at)")
  end

  def months
    Message.where(channel_id: id).uniq.pluck("EXTRACT(MONTH FROM created_at)")
  end

  def days
    Message.where(channel_id: id).uniq.pluck("EXTRACT(DAY FROM created_at)")
  end
end
