class AddAssociationBetweetGroupAndAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :groups, :group_creator, foreign_key: { to_table: :accounts }
  end
end
