# frozen_string_literal: true
class AddIndexToMessagesChannelId < ActiveRecord::Migration
  def change
    add_index :messages, :channel_id
  end
end
