class LogsController < ApplicationController

  # GET /logs
  # GET /logs.json
  def index
    @channels = Channel.all.order(:name)

    if params[:id].present?
      @channel = @channels.get_channel("##{params[:id]}")
    else
      @channel = @channels.first
    end

    if params[:year].present?
      @year = params[:year]
    else
      @year = @channel.years.last.to_s
    end

    if params[:month].present?
      @month = params[:month]
    else
      @month = @channel.months(@year).last.to_s
    end

    if params[:day].present?
      @day = params[:day]
    else
      @day = @channel.days(@year, @month).last.to_s
    end

    @date = Date.new(@year.to_i, @month.to_i, @day.to_i)
    @messages = Message.daily_log(@channel, @date)
  end
end
