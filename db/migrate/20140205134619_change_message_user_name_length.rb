# frozen_string_literal: true
class ChangeMessageUserNameLength < ActiveRecord::Migration
  def change
    change_column :messages, :user, :string, limit: 20, null: false
  end
end
