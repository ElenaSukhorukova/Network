class CreateGroupHobbies < ActiveRecord::Migration[7.0]
  def change
    create_table :group_hobbies do |t|
      t.belongs_to :group
      t.belongs_to :hobby

      t.timestamps
    end
  end
end
