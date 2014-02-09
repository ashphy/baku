class SearchController < ApplicationController
  # GET /search
  # GET /search.json
  def index
    @q = Message.search(params[:q])
    @messages = @q.result(distinct: true)
    @channels = Channel.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text, :user, :command)
    end
end
