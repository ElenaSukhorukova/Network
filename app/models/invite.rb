class Invite < ApplicationRecord
  VALID_CONFIRMED = ['not', 'yes', 'canceled']
  validates :confirmed, inclusion: { in: VALID_CONFIRMED }

  has_one :friendship
  belongs_to :sender_invite, class_name: "Account", optional: true
  belongs_to :receiver_invite, class_name: "Account", optional: true

  def self.find_invites_sender(account_id)
    invites = []
    self.all.collect do |invite|
      invites << invite if invite.sender_invite_id == account_id && invite.confirmed != 'yes'
    end
    invites
  end

  def self.find_invites_receiver(account_id)
    invites = []
    self.all.collect do |invite|
      invites << invite if invite.receiver_invite_id == account_id && invite.confirmed != 'yes'
    end
    invites
  end
end
