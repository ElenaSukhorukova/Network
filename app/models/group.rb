class Group < ApplicationRecord
  VALID_VISIBILITY = ['everybody', 'participants']

  validates :name_grou,  length: { within: 2..50 }
  
  has_many :group_participant
  has_many :accounts, through: :group_participants

  has_many :group_interest
  has_many :interests, through: :group_interest
  accepts_nested_attributes_for :interests, allow_destroy: true

  belongs_to :group_creator, class_name: 'Acccount', optional: true
end