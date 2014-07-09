class TopicsController < ApplicationController
  # GET /topics/:id
  # GET /logs/:id.json
  def show
    @channel = Channel.get_channel("##{params[:id]}")
    @messages = @channel.topics
  end
end
