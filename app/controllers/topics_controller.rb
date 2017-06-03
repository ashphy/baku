# frozen_string_literal: true

# Topic histories
class TopicsController < ApplicationController
  # GET /topics/:id
  # GET /logs/:id.json
  def show
    authorize Channel
    @channel = Channel.get_channel("##{params[:id]}")
    @messages = @channel.topics
  end
end
