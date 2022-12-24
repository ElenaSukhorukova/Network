# frozen_string_literal: true

class AccountHobby < ApplicationRecord
  belongs_to :account
  belongs_to :hobby
  # accepts_nested_attributes_for :hobby, allow_destroy: true
end
