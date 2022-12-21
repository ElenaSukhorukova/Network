# frozen_string_literal: true

class GroupParticipant < ApplicationRecord
  belongs_to :account
  belongs_to :group
end
