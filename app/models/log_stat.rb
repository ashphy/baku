# frozen_string_literal: true

# == Schema Information
#
# Table name: log_stats
#
#  channel_id :integer          not null, primary key
#  date       :date             not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

# Log Statistics
class LogStat < ApplicationRecord
  self.primary_keys = :channel_id, :date
  belongs_to :channel

  def self.last_in_date(year = nil, month = nil, day = nil)
    if day.present?
      Date.new(year, month, day)
    elsif month.present?
      base = Time.zone.local(year)
      range = base.beginning_of_year..base.end_of_year
      where(date: range).last.date
    elsif year.present?
      last.date
    else
      last.date
    end
  end
end
