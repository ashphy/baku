class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :server

  scope :actives, -> { where(active: true) }

  def self.get_channel(name)
    Channel.where(name: name).first
  end

  def name_without_sign
    name.delete('#')
  end

  def years
    Message.where(channel_id: id).uniq.pluck('EXTRACT(YEAR FROM created_at)')
  end

  def months(year)
    date = Date.new(year.to_i, 1, 1)
    range = date.beginning_of_year..date.end_of_year
    Message.where(channel_id: id).where(created_at: range).uniq.pluck('EXTRACT(MONTH FROM created_at)')
  end

  def days(year, month)
    date = Date.new(year.to_i, month.to_i, 1)
    range = date.beginning_of_month..date.end_of_month
    Message.where(channel_id: id).where(created_at: range).uniq.pluck('EXTRACT(DAY FROM created_at)')
  end
end
