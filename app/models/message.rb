class Message < ApplicationRecord
  belongs_to :conversation

  belongs_to :sender_message, class_name: "Account", optional: true
  belongs_to :reciepient_message, class_name: "Account", optional: true
end
