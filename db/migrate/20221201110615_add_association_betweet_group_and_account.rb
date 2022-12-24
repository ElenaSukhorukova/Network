# frozen_string_literal: true

class AddAssociationBetweetGroupAndAccount < ActiveRecord::Migration[7.0]
  # rubocop:disable Metrics/MethodLength

  def change
    reversible do |dir|
      change_table :groups do |t|
        dir.up do
          t.column :name_grou, :string
          t.string :name_group
          t.reference :group_creator, foreign_key: { to_table: :accounts }
        end
        dir.down do
          t.remove :name_grou
        end
      end
    end
  end

  # rubocop:enable Metrics/MethodLength
end
