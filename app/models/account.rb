class Account < ApplicationRecord
  include Visibility
  include Country

  VALID_GENDERS = ['Female', 'Male', 'Other']
  STATE = ['online', 'ofline']

  validates :user_name, presence: true, length: { within: 2..50 }
  validates :country, :gender, :date_birthday, presence: true
  validate :validate_age

  def validate_age
    if date_birthday.present? && date_birthday > 18.years.ago
      errors.add(date_birthday, 'You should be over 18 years old.')
    end
  end

  has_many :f_partner_conversation, class_name: 'Conversation', foreign_key: :f_partner_conversation_id, through: :sender_message, dependent: :destroy
  has_many :s_partner_conversation, class_name: 'Conversation', foreign_key: :s_partner_conversation_id, through: :reciepient_message, dependent: :destroy
  
  has_many :sender_message, class_name: 'Message', foreign_key: :sender_message_id, dependent: :destroy
  has_many :recipient_message, class_name: 'Message', foreign_key: :recipient_message_id, dependent: :destroy

  belongs_to :user
  
  has_many :account_interest
  has_many :interests, through: :account_interest
  accepts_nested_attributes_for :interests, allow_destroy: true

  has_many :group_participant
  has_many :groups, through: :group_participant 
  has_many :group_creator, class_name: 'Group', foreign_key: :group_creator_id, dependent: :destroy

  has_many :comments, class_name: 'Comment', foreign_key: :author_comment_id, dependent: :destroy
  has_many :posts, class_name: 'Post', foreign_key: :author_post_id, dependent: :destroy

  has_many :sender_invite, class_name: 'Invite', foreign_key: :sender_invite_id, dependent: :destroy
  has_many :receiver_invite, class_name: 'Invite', foreign_key: :receiver_invite_id, dependent: :destroy

  has_many :f_partner_friendship, class_name: 'Friendship', foreign_key: :f_partner_friendship_id, dependent: :destroy
  has_many :s_partner_friendship, class_name: 'Friendship', foreign_key: :s_partner_friendship_id, dependent: :destroy
 
  # to show account except current
  scope :except_current_account, ->(account) { where.not(id: account) }
end