class Conversation < ApplicationRecord
  has_many :messages

  has_many :f_partner_conversation, class_name: "Account", through: :message, optional: true
  has_many :f_partner_conversation, class_name: "Account", through: :message, optional: true
end
