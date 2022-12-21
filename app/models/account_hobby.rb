# frozen_string_literal: true

class AccountHobby < ApplicationRecord
  belongs_to :account
  belongs_to :hobby
end
