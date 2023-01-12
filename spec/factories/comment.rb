# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    author_comment { Account.take || create(:account) }
    body { 'Comment\'s body' }
    association :commentable, factory: :post
  end
end
