# frozen_string_literal: true

class AddAssociationBetweetGroupAndAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :groups, :group_creator, foreign_key: { to_table: :accounts }
    remove_column :groups, :name_grou, :string
    add_column :groups, :name_group, :string
  end
end
