# frozen_string_literal: true

class Group < ApplicationRecord
  VALID_VISIBILITY = %w[everybody participants].freeze

  validates :name_group, presence: true, length: { within: 2..50 }
  validates :description, presence: true, length: { minimum: 2 }

  validates :visibility, inclusion: { in: VALID_VISIBILITY }

  has_many :group_participants, dependent: :destroy
  has_many :accounts, through: :group_participants

  has_many :group_hobbies, dependent: :destroy
  has_many :hobbies, through: :group_hobbies
  accepts_nested_attributes_for :hobbies, allow_destroy: true, update_only: true

  belongs_to :group_creator, class_name: 'Account', optional: true
  has_many :group_contents, dependent: :destroy

  has_many :contents, dependent: :destroy
end
