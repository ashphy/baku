# == Schema Information
#
# Table name: log_stats
#
#  channel_id :integer          not null, primary key
#  date       :date             not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class LogStat < ApplicationRecord
  self.primary_keys = :channel_id, :date
  belongs_to :channel
end
