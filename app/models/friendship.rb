class Friendship < ApplicationRecord
  belongs_to :invite
  belongs_to :f_partner_friendship, class_name: "Account", optional: true
  belongs_to :s_partner_friendship, class_name: "Account", optional: true
end
