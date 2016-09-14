class AddMultipleIndexToMessages < ActiveRecord::Migration
  def change
    add_index :messages, [:channel_id, :created_at]
    # remove_index :messages, column: :channel_id
    # remove_index :messages, column: :created_at
  end
end
