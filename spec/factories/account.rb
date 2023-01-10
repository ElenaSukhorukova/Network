# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    user { User.take || create(:user) }
    user_name { 'Walter White' }
    date_birthday { Faker::Date.birthday(min_age: 18, max_age: 120) }
    gender { Account::VALID_GENDERS.sample }
    about_oneself { Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4) }
    country { Account::VALID_COUNTRY.sample }
    visibility { Account::VALID_VISIBILITY.sample }
    state { Account::STATES.sample }
  end
end
