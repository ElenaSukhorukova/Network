module FriendshipsHelper
  def find_friendship(sender, recipient)
    friendship = Friendship.find_by(f_partner_friendship: sender, s_partner_friendship: recipient) ||
                Friendship.find_by(s_partner_friendship: sender, f_partner_friendship: recipient)
  end

  def check_friendship?(sender, recipient)
    return  true if find_friendship(sender, recipient)
  end

  def find_friend(friendship)
    account = friendship.f_partner_friendship == current_user.account ? friendship.s_partner_friendship :
                                                                        friendship.f_partner_friendship
    account = account.decorate
  end
end
