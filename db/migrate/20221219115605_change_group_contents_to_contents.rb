# frozen_string_literal: true

class ChangeGroupContentsToContents < ActiveRecord::Migration[7.0]
  def change
    rename_table :group_contents, :contents
  end
end
