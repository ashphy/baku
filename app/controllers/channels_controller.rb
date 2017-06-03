# frozen_string_literal: true

# IRC Channels
class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, only: %i[show edit update destroy]

  # GET /channels
  # GET /channels.json
  def index
    authorize Channel
    @channels = policy_scope(Channel).all.includes(:server).order(:name)
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    authorize @channel
  end

  # GET /channels/new
  def new
    @channel = Channel.new
    authorize @channel
  end

  # GET /channels/1/edit
  def edit
    authorize @channel
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)
    authorize @channel

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @channel }
      else
        format.html { render action: 'new' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    authorize @channel
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: 'Channel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    authorize @channel
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def channel_params
    params.require(:channel).permit(:name, :key, :server_id, :active)
  end
end
