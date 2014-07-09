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
    logged_years = Message.group_by_year(:created_at).count.select { |date, count| count > 0 }
    logged_years.map do |date, count|
      date.year
    end
  end

  def months(year)
    date = Date.new(year.to_i, 1, 1)
    range = date.beginning_of_year..date.end_of_year
    logged_months = Message.group_by_month(:created_at, range: range).count.select { |date, count| count > 0 }
    logged_months.map do |date, count|
      date.month
    end
  end

  def days(year, month)
    date = Date.new(year.to_i, month.to_i, 1)
    range = date.beginning_of_month..date.end_of_month
    logged_days = Message.group_by_day(:created_at, range: range).count.select { |date, count| count > 0 }
    logged_days.map do |date, count|
      date.day
    end
  end
end
