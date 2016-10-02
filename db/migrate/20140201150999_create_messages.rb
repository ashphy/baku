# frozen_string_literal: true
class CreateMessages < ActiveRecord::Migration
  def change
    engine = Rails.env == 'test' ? 'MYISAM' : 'mroonga'
    create_table :messages, options: "ENGINE=#{engine} DEFAULT CHARSET=utf8" do |t|
      t.belongs_to :channel
      t.string :text, limit: 512
      t.string :user, limit: 10
      t.string :command

      t.timestamps

      t.index :created_at
    end
  end
end
