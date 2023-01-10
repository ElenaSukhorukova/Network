# frozen_string_literal: true

class Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :conversation
  belongs_to :sender_message
  belongs_to :recipient_message
end
