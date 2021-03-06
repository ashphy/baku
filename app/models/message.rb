# frozen_string_literal: true

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

# IRC Messages
class Message < ApplicationRecord
  belongs_to :channel

  validates :text, presence: true
  validates :text, length: { maximum: 512 }

  validates :user, presence: true
  validates :user, length: { maximum: 20 }

  validates :command, presence: true
  validates :command, inclusion: %w[PRIVMSG NOTICE TOPIC]

  scope :daily_log, ->(channel, date) {
    where(created_at: date.beginning_of_day..date.end_of_day)
      .where(channel_id: channel.id)
  }
  scope :search_with, ->(query, order = :created_at, direction = :desc) {
    keywords, conditions = parse_query(query)
    order_condition = {}
    order_condition[order] = direction
    where(['match(text) against(? in boolean mode)', search_query(keywords.join(' '))])
      .where(conditions)
      .order(order_condition)
  }

  after_create do |message|
    LogStat.find_or_create_by(
      channel_id: message.channel.id,
      date: message.created_at.to_date
    )
  end

  def self.search_query(query)
    q = query.gsub(/[[:cntrl:]]/, '')
    "*D+ #{q}" # Define AND search
  end

  def self.parse_query(query)
    keywords = []
    channels = []

    queries = query.split(' ')
    queries.each do |query|
      if query.match?(/^#/)
        if Channel.all.pluck(:name).include?(query)
          channels << Channel.find_by(name: query)
        end
      else
        keywords << query
      end
    end

    conditions = {}
    conditions['channel'] = channels if channels.present?

    [keywords, conditions]
  end

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
