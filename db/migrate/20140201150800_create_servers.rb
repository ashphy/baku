# frozen_string_literal: true
class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers, options: 'ENGINE=mroonga DEFAULT CHARSET=utf8' do |t|
      t.string :host
      t.string :encoding

      t.timestamps
    end
  end
end
