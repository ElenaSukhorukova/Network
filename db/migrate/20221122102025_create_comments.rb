# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :author_comment, foreign_key: { to_table: :accounts }
      t.references :commentabable, polymorphic: true

      t.timestamps
    end
  end
end
