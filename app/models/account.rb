class Account < ApplicationRecord
  include Country

  VALID_GENDERS = %w[Female Male Other]
  STATES = %w[online ofline]
  VALID_VISIBILITY = ['everybody', 'friends', 'nobody']

  validates :user_name, presence: true, length: { within: 2..50 }
  validates :country, :gender, :date_birthday, presence: true
  validates :visibility, inclusion: { in: VALID_VISIBILITY }
  validates :state, inclusion: { in: STATES }
  validates :gender, inclusion: { in: VALID_GENDERS }
  validate :validate_age

  def validate_age
    if date_birthday.present? && date_birthday > 18.years.ago
      errors.add(:date_birthday, 'should be earlier then 18 years.')
    end
  end

  # to show account except current
  scope :except_current_account, ->(account) { where.not(id: account).order(:user_name) }
  
  has_many :sender_messages, class_name: 'Message', 
            foreign_key: :sender_message_id, dependent: :destroy

  has_many  :recipient_messages, class_name: 'Message', 
            foreign_key: :recipient_message_id, dependent: :destroy

  has_many :f_partner_conversations, class_name: 'Conversation', 
            foreign_key: :f_partner_conversation_id, 
            through: :sender_message, dependent: :destroy

  has_many :s_partner_conversations, class_name: 'Conversation', 
            foreign_key: :s_partner_conversation_id, 
            through: :reciepient_message, dependent: :destroy

  belongs_to :user
  
  has_many :account_hobbies
  has_many :hobbies, through: :account_hobbies
  accepts_nested_attributes_for :hobbies, allow_destroy: true, update_only: true

  has_many :group_participants
  has_many :groups, through: :group_participants
  has_many :groups, class_name: 'Group', foreign_key: :group_creator_id, dependent: :destroy

  has_many :comments, class_name: 'Comment', 
            foreign_key: :author_comment_id, dependent: :destroy

  has_many :posts, class_name: 'Post', foreign_key: :author_post_id, 
            dependent: :destroy

  has_many :group_contents, dependent: :destroy

  has_many :sender_invites, class_name: 'Invite', 
            foreign_key: :sender_invite_id, dependent: :destroy

  has_many :receiver_invites, class_name: 'Invite', 
            foreign_key: :receiver_invite_id, dependent: :destroy

  has_many :f_partner_friendships, class_name: 'Friendship', 
            foreign_key: :f_partner_friendship_id, dependent: :destroy
            
  has_many :s_partner_friendships, class_name: 'Friendship', 
            foreign_key: :s_partner_friendship_id, dependent: :destroy
end