class Group < ApplicationRecord
  VALID_VISIBILITY = ['everybody', 'participants']

  has_many :group_participant
  has_many :accounts, through: :group_participants

  has_many :group_interests
  has_many :interests, through: :group_interest
end
