class CreateInterests < ActiveRecord::Migration[7.0]
  def change
    create_table :interests do |t|
      t.string :name_interest

      t.timestamps
    end
  end
end
