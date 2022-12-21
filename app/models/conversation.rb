class Conversation < ApplicationRecord
  has_many :messages

  belongs_to :f_partner_conversation, class_name: 'Account', optional: true
  belongs_to :s_partner_conversation, class_name: 'Account', optional: true

  # chose a current account conversations
  scope :account_conversations, lambda { |account|
    where(f_partner_conversation: account).or(Conversation.where(s_partner_conversation: account))
  }

  # find a existed conversation or create new one
  def self.new_conv(sender, recipient)
    conversation = find_by(f_partner_conversation: sender, s_partner_conversation: recipient) ||
                   find_by(s_partner_conversation: sender, f_partner_conversation: recipient)

    conversation ||= new(f_partner_conversation: sender, s_partner_conversation: recipient)
  end
end
