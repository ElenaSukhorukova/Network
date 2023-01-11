# frozen_string_literal: true

class Content < ApplicationRecord
  validates :body, presence: true, length: { minimum: 2 }
  
  belongs_to :group
  belongs_to :account

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :order_desc, -> { order_desc }, class_name: 'Comment',
                                           inverse_of: :comment,
                                           dependent: :destroy
end
