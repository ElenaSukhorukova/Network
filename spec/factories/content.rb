# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    account { Account.take || create(:account) }
    body { 'Content\'s body' }
    group { Group.take || create(:group) }
  end
end
