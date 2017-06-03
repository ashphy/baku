# frozen_string_literal: true

# Log Search
class SearchController < ApplicationController
  # GET /search
  # GET /search.json
  def index
    return if params[:q].present?

    @keywords = params[:q]
    @search = policy_scope(Message).search_with(params[:q])
    @messages = @search.page(params[:page]).per(100)
    @channels = Channel.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end
end
