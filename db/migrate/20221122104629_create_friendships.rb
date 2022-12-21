# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.boolean :confirmed, default: false
      t.belongs_to :f_partner_friendship, index: true, foreign_key: { to_table: :accounts }
      t.belongs_to :s_partner_friendship, index: true, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
