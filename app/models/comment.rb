class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :author_comment, class_name: "Account", optional: true
  belongs_to :commentable, polymorphic: true
end
