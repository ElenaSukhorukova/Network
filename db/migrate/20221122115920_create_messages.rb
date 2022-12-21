# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.boolean :readed, default: false
      t.belongs_to :sender_message, index: true, foreign_key: { to_table: :accounts }
      t.belongs_to :recipient_message, index: true, foreign_key: { to_table: :accounts }
      t.belongs_to :conversation

      t.timestamps
    end
  end
end
