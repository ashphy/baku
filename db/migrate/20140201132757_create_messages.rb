class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, options: 'ENGINE=mroonga DEFAULT CHARSET=utf8' do |t|
      t.string :text, :limit => 512
      t.string :user, :limit => 10
      t.string :command

      t.timestamps

      t.index :created_at
    end
  end
end
