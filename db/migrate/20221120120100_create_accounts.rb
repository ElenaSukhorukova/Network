class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :user_name
      t.string :gender
      t.date :date_birthday
      t.text :about_oneself
      t.string :nationality
      t.string :location
      t.string :visibility
      t.string :state

      t.timestamps
    end
  end
end
