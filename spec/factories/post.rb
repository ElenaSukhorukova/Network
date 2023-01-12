# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    author_post { Account.take || create(:account) }
    body { 'Post\'s body' }
  end
end
