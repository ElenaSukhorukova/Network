class Invite < ApplicationRecord
  has_one :friendship
  belongs_to :sender_invite, class_name: "Account", optional: true
  belongs_to :receiver_invite, class_name: "Account", optional: true
end
