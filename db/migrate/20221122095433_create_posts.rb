# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.references :author_post, foreign_key: { to_table: :accounts }
      t.string :place

      t.timestamps
    end
  end
end
