# frozen_string_literal: true

class ChangeColumnsContents < ActiveRecord::Migration[7.0]
  def change
    remove_reference :contents, :groups, foreign_key: true
    add_reference :contents, :group, foreign_key: true
    remove_reference :contents, :accounts, foreign_key: true
    add_reference :contents, :account, foreign_key: true
  end
end
