class CreateHobbies < ActiveRecord::Migration[7.0]
  def change
    create_table :hobbies do |t|
      t.string :hobby_name
      
      t.timestamps
    end
  end
end
