# frozen_string_literal: true

class AddAssociationsFriendshipsInvite < ActiveRecord::Migration[7.0]
  def change
    add_reference :friendships, :invite, foreign_key: true
  end
end
