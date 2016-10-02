# frozen_string_literal: true
class CreateChannelPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_permissions do |t|
      t.belongs_to :user
      t.belongs_to :channel
      t.timestamps
    end
  end
end
