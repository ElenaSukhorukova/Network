class Post < ApplicationRecord
  belongs_to :author_post, class_name: "Account", optional: true
  has_many :comments, as: :commentable, dependent: :destroy
end
