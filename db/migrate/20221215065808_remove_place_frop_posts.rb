# frozen_string_literal: true

class RemovePlaceFropPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :place, :string
  end
end
