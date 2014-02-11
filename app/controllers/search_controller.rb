class SearchController < ApplicationController
  # GET /search
  # GET /search.json
  def index
    if params[:q].present?
      @q = params[:q]
      @search = Message.search(text_cont: @q)
      @messages = @search.result(distinct: true)
      @channels = Channel.all
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end
end
