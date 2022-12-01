class Conversation < ApplicationRecord
  has_many :messages

  has_many :f_partner_conversation, class_name: "Account", through: :message
  has_many :s_partner_conversation, class_name: "Account", through: :message

  # chose a current account conversations

  scope :account_conversations, ->(account_id) {
    where(f_partner_conversation_id: account_id).or(Conversation.where(s_partner_conversation_id: account_id))
  }

  # find a existed conversation or create new one

  def self.new_conv(sender_id, recipient_id)
    conversation = self.find_by(f_partner_conversation_id: sender_id, s_partner_conversation_id: recipient_id) ||
      self.find_by(s_partner_conversation_id: sender_id, f_partner_conversation_id: recipient_id)
    
    conversation ||= new(f_partner_conversation_id: sender_id, s_partner_conversation_id: recipient_id)
  end
end
