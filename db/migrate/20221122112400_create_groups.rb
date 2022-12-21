# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name_grou
      t.text :description
      t.string :visibility

      t.timestamps
    end
  end
end
