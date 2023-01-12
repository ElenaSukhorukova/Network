# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    group_creator { Account.take || create(:account) }
    name_group { 'Group\'s name' }
    description { Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4) }
    visibility { Group::VALID_VISIBILITY.sample }
  end
end
