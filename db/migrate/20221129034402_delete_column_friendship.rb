class DeleteColumnFriendship < ActiveRecord::Migration[7.0]
  def change
    remove_column :friendships, :confirmed, :boolean, default: false
    add_column :invites, :confirmed, :string, default: 'not'
  end
end
