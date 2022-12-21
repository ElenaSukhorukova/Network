# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :gender
      t.date :date_birthday
      t.text :about_oneself
      t.string :country
      t.string :visibility
      t.string :state

      t.timestamps
    end
  end
end
