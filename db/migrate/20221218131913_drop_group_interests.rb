# frozen_string_literal: true

class DropGroupInterests < ActiveRecord::Migration[7.0]
  def change
    drop_table :group_interests
  end
end
