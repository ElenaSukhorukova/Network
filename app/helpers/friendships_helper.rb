module FriendshipsHelper
  def check_friendship?(sender_id, recipient_id)
   friendship = Friendship.find_by(f_partner_friendship_id: sender_id, s_partner_friendship_id: recipient_id) ||
   Friendship.find_by(s_partner_friendship_id: sender_id, f_partner_friendship_id: recipient_id)
    
    true if friendship
  end

  def find_friend(friendship)
    account_id = friendship.f_partner_friendship_id == current_user.account.id ? friendship.s_partner_friendship_id :
    friendship.f_partner_friendship_id
    Account.find_by(id: account_id)
  end
end
