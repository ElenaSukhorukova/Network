class Conversation < ApplicationRecord
  has_many :messages

  has_many :f_partner_conversation, class_name: "Account", through: :message
  has_many :f_partner_conversation, class_name: "Account", through: :message
end
