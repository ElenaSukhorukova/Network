# frozen_string_literal: true

class Message < ApplicationRecord
  validates :body, presence: true
  has_many_attached :images
  
  belongs_to :conversation
  belongs_to :sender_message
  belongs_to :recipient_message
end
