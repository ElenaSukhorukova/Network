class CreateGroupContents < ActiveRecord::Migration[7.0]
  def change
    create_table :group_contents do |t|
      t.references :groups, foreign_key: true
      t.references :accounts, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
