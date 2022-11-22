class Comment < ApplicationRecord
  belongs_to :author_comment, class_name: "Account", optional: true
  belongs_to :commentable, polymorphic: true
end
