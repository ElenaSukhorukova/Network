class Account < ApplicationRecord
  include Visibility
  VALID_GENDERS = ['Female', 'Male', 'Other']
  STATE = ['online', 'ofline']

  validates :user_name, presence: true, length: { within: 5..50 }
  validates :gender, inclusion: { in: VALID_GENDERS }
  validates :date_birthday, format: { with: /\d{4}\-\d{2}\-\d{2}/,
    message: "a format of date is allowed only xx.xx.xxxx" }
  validates :date_birthday, comparison: { greater_than: Date.parse('1900-01-01'), less_than: Date.current, 
    message: 'You should be little elder then a current date and younger then 1900-01-01.'
  }

  belongs_to :user
  
  has_many :account_interest
  has_many :interests, through: :account_interest

  has_many :group_participant
  has_many :groups, through: :group_participant 

  has_many :comments, class_name: 'Comment', foreign_key: :author_comment_id, dependent: :destroy
  has_many :posts, class_name: 'Post', foreign_key: :author_post_id, dependent: :destroy

  has_many :sender_invite, class_name: 'Invite', foreign_key: :sender_invite_id, dependent: :destroy
  has_many :receiver_invite, class_name: 'Invite', foreign_key: :receiver_invite_id, dependent: :destroy

  has_many :f_partner_friendship, class_name: 'Friendship', foreign_key: :f_partner_friendship_id, dependent: :destroy
  has_many :s_partner_friendship, class_name: 'Friendship', foreign_key: :s_partner_friendship_id, dependent: :destroy

  has_many :sender_message, class_name: 'Message', foreign_key: :sender_message_id, dependent: :destroy
  has_many :reciepient_message, class_name: 'Message', foreign_key: :reciepient_message_id, dependent: :destroy

  has_many :f_partner_conversation, class_name: 'Conversation', foreign_key: :f_partner_conversation_id, through: :sender_message, dependent: :destroy
  has_many :s_partner_conversation, class_name: 'Conversation', foreign_key: :s_partner_conversation_id, through: :reciepient_message, dependent: :destroy
end