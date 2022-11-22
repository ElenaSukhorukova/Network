class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.belongs_to :sender_invite, index: true, foreign_key: { to_table: :accounts }
      t.belongs_to :receiver_invite, index: true, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
