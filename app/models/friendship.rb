class Friendship < ApplicationRecord
  belongs_to :invite
  belongs_to :f_partner_friendship, class_name: "Account", optional: true
  belongs_to :s_partner_friendship, class_name: "Account", optional: true

  def self.account_friends(account_id)
    friends = []
    self.all.collect do |friendship|
      friends << friendship if [ friendship.f_partner_friendship_id, friendship.s_partner_friendship_id].include?(account_id)
    end
    friends
  end
end