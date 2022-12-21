class CreateAccountHobbies < ActiveRecord::Migration[7.0]
  def change
    create_table :account_hobbies do |t|
      t.belongs_to :account
      t.belongs_to :hobby

      t.timestamps
    end
  end
end
