module DeleteInvite
  extend ActiveSupport::Concern

  included do
    private

    def delete_invite
      invites = Invite.where(confirmed: 'yes')
      invites.each do |invite|
        invite.destroy unless Friendship.find_by(invite_id: invite.id)
      end
    end
  end
end
