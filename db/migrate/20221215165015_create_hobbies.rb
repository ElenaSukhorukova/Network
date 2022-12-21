# frozen_string_literal: true

class CreateHobbies < ActiveRecord::Migration[7.0]
  def change
    create_table :hobbies do |t|
      t.string :hobby_name

      t.timestamps
    end
  end
end
