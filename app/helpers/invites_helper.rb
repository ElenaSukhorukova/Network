module InvitesHelper
  def find_account_name(invite)
    return account = invite.sender_invite == current_user.account ? invite.receiver_invite :
                                                                    invite.sender_invite
  end

  def check_invite?(sender_invite, receiver_invite)
    return  true if Invite.find_by(sender_invite: sender_invite, receiver_invite: receiver_invite, confirmed: 'not') ||
                    Invite.find_by(sender_invite: receiver_invite, receiver_invite: sender_invite, confirmed: 'not')
  end
end
