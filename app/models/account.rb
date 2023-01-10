# frozen_string_literal: true

class Account < ApplicationRecord
  include Country

  VALID_GENDERS = %w[Female Male Other].freeze
  STATES = %w[online ofline].freeze
  VALID_VISIBILITY = %w[everybody friends nobody].freeze

  validates :user_name, presence: true, length: { within: 2..50 }
  validates :country, :gender, :date_birthday, presence: true
  validates :visibility, inclusion: { in: VALID_VISIBILITY }
  validates :state, inclusion: { in: STATES }
  validates :gender, inclusion: { in: VALID_GENDERS }
  validate :validate_age

  def validate_age
    return unless date_birthday.present? && date_birthday > 18.years.ago

    errors.add(:date_birthday, 'should be earlier then 18 years.')
  end

  # to show account except current
  scope :except_current_account, ->(account) { where.not(id: account).order(:user_name) }

  has_many :sender_messages, class_name: 'Message',
                             foreign_key: :sender_message_id,
                             inverse_of: :sender_message, dependent: :destroy

  has_many :recipient_messages, class_name: 'Message',
                                foreign_key: :recipient_message_id,
                                inverse_of: :recipient_message, dependent: :destroy

  has_many :f_partner_conversations, class_name: 'Conversation',
                                     foreign_key: :f_partner_conversation_id,
                                     through: :sender_messages, source: :sender_message,
                                     dependent: :destroy

  has_many :s_partner_conversations, class_name: 'Conversation',
                                     foreign_key: :s_partner_conversation_id,
                                     through: :recipient_messages, source: :recipient_message,
                                     dependent: :destroy
  belongs_to :user
  has_many :account_hobbies, dependent: :destroy
  has_many :hobbies, through: :account_hobbies
  accepts_nested_attributes_for :account_hobbies, allow_destroy: true

  has_many :group_participants, dependent: :destroy
  has_many :group_creator, class_name: 'Group', foreign_key: :group_creator_id,
                          inverse_of: :group_creator, dependent: :destroy

  has_many :author_comment, class_name: 'Comment',
                           foreign_key: :author_comment_id,
                           inverse_of: :author_comment, dependent: :destroy

  has_many :author_posts, class_name: 'Post', foreign_key: :author_post_id,
                   inverse_of: :author_post, dependent: :destroy

  has_many :contents, dependent: :destroy

  has_many :sender_invites, class_name: 'Invite',
                            foreign_key: :sender_invite_id,
                            inverse_of: :sender_invite, dependent: :destroy

  has_many :receiver_invites, class_name: 'Invite',
                              foreign_key: :receiver_invite_id,
                              inverse_of: :receiver_invite, dependent: :destroy

  has_many :f_partner_friendships, class_name: 'Friendship',
                                   foreign_key: :f_partner_friendship_id,
                                   inverse_of: :f_partner_friendship, dependent: :destroy

  has_many :s_partner_friendships, class_name: 'Friendship',
                                   foreign_key: :s_partner_friendship_id,
                                   inverse_of: :s_partner_friendship, dependent: :destroy
end
