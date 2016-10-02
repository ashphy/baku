# frozen_string_literal: true
class LogsController < ApplicationController
  # GET /logs
  # GET /logs.json
  def index
    @channels = policy_scope(Channel).all.order(:name)

    @channel = if params[:id].present?
                 @channels.get_channel("##{params[:id]}")
               else
                 @channels.first!
               end

    stats = @channel.log_stats
    raise ActiveRecord::RecordNotFound if stats.count.zero?

    # find latest recorded date
    if params[:day].present?
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    elsif params[:month].present?
      base = Time.zone.local(params[:year].to_i)
      range = base.beginning_of_year..base.end_of_year
      @date = stats.where(date: range).last
    elsif params[:year].present?
      @date = stats.last.date
    else
      @date = stats.last.date
    end

    @dates = stats.pluck(:date)
    @messages = Message.daily_log(@channel, @date)
  end
end
