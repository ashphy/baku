class ChengeColumnFromJoinedToActive < ActiveRecord::Migration
  def change
    rename_column :channels, :joined, :active
  end
end
