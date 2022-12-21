# frozen_string_literal: true

class CreateGroupParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :group_participants do |t|
      t.belongs_to :group
      t.belongs_to :account

      t.timestamps
    end
  end
end
