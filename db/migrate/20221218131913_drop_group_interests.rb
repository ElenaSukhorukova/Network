# frozen_string_literal: true

class DropGroupInterests < ActiveRecord::Migration[7.0]
  def change
    drop_table :group_interests do |t|
      t.belongs_to :group
      t.belongs_to :interest

      t.timestamps
    end
  end
end
