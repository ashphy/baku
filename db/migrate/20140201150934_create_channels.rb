class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels, options: 'ENGINE=mroonga DEFAULT CHARSET=utf8' do |t|
      t.belongs_to :server
      t.string :name

      t.timestamps
      t.index :name, unique: true
    end
  end
end
