class CreateLogStats < ActiveRecord::Migration
  def change
    create_table :log_stats, id: false do |t|
      t.integer     :channel_id, null: false
      t.date        :date,       null: false
      t.timestamps
    end

    add_index :log_stats, [ :channel_id, :date ], unique: true
  end
end
