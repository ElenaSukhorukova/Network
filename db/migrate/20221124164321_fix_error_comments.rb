# frozen_string_literal: true

class FixErrorComments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :comments, :commentabable, polymorphic: true
    add_reference :comments, :commentable, polymorphic: true
  end
end
