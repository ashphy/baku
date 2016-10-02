# frozen_string_literal: true
class AddKeyToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :key, :string, null: true
  end
end
