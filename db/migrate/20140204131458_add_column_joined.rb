class AddColumnJoined < ActiveRecord::Migration
  def change
    add_column :channels, :joined, :boolean, :null => false, :default => true
  end
end
