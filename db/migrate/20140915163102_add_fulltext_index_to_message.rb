class AddFulltextIndexToMessage < ActiveRecord::Migration
  def change
    add_index :messages, :text, type: :fulltext
  end
end
