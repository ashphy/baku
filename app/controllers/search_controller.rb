class SearchController < ApplicationController
  # GET /search
  # GET /search.json
  def index
    if params[:q].present?
      @search = Message.search_with(params[:q])
      @messages = @search.page(params[:page]).per(100)
      @channels = Channel.all
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end
end
