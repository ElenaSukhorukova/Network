# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    association :f_partner_friendship, factory: :account
    association :s_partner_friendship, factory: :account
    invite
  end

  factory :invite do
    sender_invite { Account.take || create(:account) }
    receiver_invite { create(:account) }

    factory :invite_with_friendship do
      transient do
        friendship_count { 1 }
      end

      after(:create) do |invite, evaluator|
        create_list(:friendship, evaluator.friendship_count,
                    invite: invite,
                    f_partner_friendship: invite.sender_invite,
                    s_partner_friendship: invite.receiver_invite)
        invite.confirmed = 'yes'
        invite.reload
      end
    end
  end
end
