# frozen_string_literal: true

module InvitesHelper
  def find_account_name(invite)
    return invite.receiver_invite if invite.sender_invite == current_user.account

    invite.sender_invite
  end

  def check_invite?(sender_invite, receiver_invite)
    return true if Invite.find_by(sender_invite: sender_invite, receiver_invite: receiver_invite, confirmed: 'not') ||
                   Invite.find_by(sender_invite: receiver_invite, receiver_invite: sender_invite, confirmed: 'not')
  end
end
