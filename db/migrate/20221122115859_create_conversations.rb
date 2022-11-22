class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :f_partner_conversation, index: true, foreign_key: { to_table: :accounts }
      t.references :s_partner_conversation, index: true, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
