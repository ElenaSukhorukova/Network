class Invite < ApplicationRecord
  VALID_CONFIRMED = %w[not yes canceled]
  validates :confirmed, inclusion: { in: VALID_CONFIRMED }

  has_one :friendship

  belongs_to :sender_invite, class_name: 'Account', optional: true
  belongs_to :receiver_invite, class_name: 'Account', optional: true

  def self.account_sender_invites(account)
    where(sender_invite: account).where.not(confirmed: 'yes')
  end

  def self.account_receiver_invites(account)
    where(receiver_invite: account).where.not(confirmed: 'yes')
  end
end
