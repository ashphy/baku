# frozen_string_literal: true

# Log Search
class SearchController < ApplicationController
  # GET /search
  # GET /search.json
  def index
    return if params[:q].blank?

    @keywords = params[:q]

    @order = case params[:order]
             when 'created_at', 'channel_id', 'user', 'text'
               params[:order].to_sym
             else
               :created_at
             end
    @direction = case params[:direction]
                 when 'desc', 'asc'
                   params[:direction].to_sym
                 else
                   :desc
                 end

    logger.info("@@@ #{@order}, #{@direction}")
    @search = policy_scope(Message)
              .search_with(params[:q], @order, @direction)
    @messages = @search.page(params[:page]).per(10)
    Rails.logger.info "@@@@@ Pages #{@messages.length}"
    Rails.logger.info "@@@@@ Pages #{@search.page(params[:page]).per(10).to_sql}"
    @channels = Channel.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end
end
