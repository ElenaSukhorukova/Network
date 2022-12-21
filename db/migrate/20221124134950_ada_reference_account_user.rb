# frozen_string_literal: true

class AdaReferenceAccountUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :user, foreighn_key: true
  end
end
