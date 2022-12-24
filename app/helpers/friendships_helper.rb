# frozen_string_literal: true

module FriendshipsHelper
  def find_friendship(sender, recipient)
    Friendship.find_by(f_partner_friendship: sender, s_partner_friendship: recipient) ||
      Friendship.find_by(s_partner_friendship: sender, f_partner_friendship: recipient)
  end

  def check_friendship?(sender, recipient)
    return true if find_friendship(sender, recipient)
  end

  def find_friend(friendship)
    return friendship.s_partner_friendship.decorate if friendship.f_partner_friendship == current_user.account

    friendship.f_partner_friendship.decorate
  end
end
