# frozen_string_literal: true

# Viewing IRC logs
class LogsController < ApplicationController
  # GET /logs
  # GET /logs.json
  def index
    @channels = policy_scope(Channel).all.order(:name)

    @channel = if params[:id].present?
                 @channels.get_channel("##{params[:id]}")
               else
                 @channels.first
               end

    unless @channel
      render :no_channel
      return
    end

    stats = @channel.log_stats
    raise ActiveRecord::RecordNotFound if stats.count.zero?

    # find latest recorded date
    @date = stats.last_in_date(
      params[:year]&.to_i,
      params[:month]&.to_i,
      params[:day]&.to_i
    )
    @dates = stats.pluck(:date)
    @messages = Message.daily_log(@channel, @date)
  end
end
