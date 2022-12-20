class Group < ApplicationRecord
  VALID_VISIBILITY = ['everybody', 'participants']

  validates :name_group, presence: true, uniqueness: true, length: { within: 2..50 }
  validates :description, presence: true, length: { minimum: 2 }

  validates :visibility, inclusion: { in: VALID_VISIBILITY }
 
  has_many :group_participants
  has_many :accounts, through: :group_participants

  has_many :group_hobbies
  has_many :hobbies, through: :group_hobbies
  accepts_nested_attributes_for :hobbies, allow_destroy: true, update_only: true

  belongs_to :group_creator, class_name: 'Account', optional: true
  has_many :group_contents, dependent: :destroy

  has_many :contents
end