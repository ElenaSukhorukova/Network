class Friendship < ApplicationRecord 
  belongs_to :invite
  belongs_to :f_partner_friendship, class_name: "Account", optional: true
  belongs_to :s_partner_friendship, class_name: "Account", optional: true


  def self.user_friends(account)
    where(f_partner_friendship: account).or(Friendship.where(s_partner_friendship: account))
  end
end