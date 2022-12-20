class Post < ApplicationRecord
  # validates :body, presence: true, if: :custom_validation

  belongs_to :author_post, class_name: "Account", optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :order_desc, -> { order_desc }, class_name: 'Comment'

  # def custom_validation
  #   !images.attached?
  # end 
end
