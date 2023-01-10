# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account do
  let(:account) { create(:account) }

  it 'returns article\'s name' do
    expect(account.user_name).to eq('Walter White')
  end

  it 'returns article\'s title' do
    expect(account.gender).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the user\'s name' do
      expect(account.user_name.present?).to be true
    end \

    it 'returns true for the user\'s name' do
      expect(account.country.present?).to be true
    end

    it 'returns true for the user\'s name' do
      expect(account.date_birthday.present?).to be true
    end

    it 'returns true for the user\'s name' do
      expect(account.gender.present?).to be true
    end

    it 'returns true for the invalid user' do
      account.user_name = Faker::Alphanumeric.alpha(number: 1)
      expect(account.invalid?).to be true
    end

    it 'returns true for the invalid user' do
      account.user_name = Faker::Alphanumeric.alpha(number: 51)
      expect(account.invalid?).to be true
    end

    it 'returns true for the gender' do
      expect(Account::VALID_GENDERS).to include(account.gender)
    end

    it 'returns true for the state' do
      expect(Account::STATES).to include(account.state)
    end

    it 'returns true for the state' do
      expect(Account::VALID_VISIBILITY).to include(account.visibility)
    end

    it 'returns true for date of the birthday' do
      expect(account.date_birthday.year).to be_between(Date.today.year - 120, Date.today.year - 18)
    end
  end

  describe 'association' do
    it 'belongs a user' do
      expect(account.user).to be_an_instance_of(User)
    end

    it { is_expected.to have_many(:sender_messages).class_name('Message') }
    it { is_expected.to have_many(:recipient_messages).class_name('Message') }
    it { is_expected.to have_many(:f_partner_conversations).class_name('Conversation')
                                                           .through(:sender_messages)
                                                           .source(:sender_message) }
    it { is_expected.to have_many(:s_partner_conversations).class_name('Conversation')
                                                            .through(:recipient_messages)
                                                            .source(:recipient_message) }
    it { is_expected.to have_many :hobbies }
    it { is_expected.to have_many(:group_creator).class_name('Group') }
    it { is_expected.to have_many(:author_comment).class_name('Comment') }
    it { is_expected.to have_many(:author_posts).class_name('Post') }
    it { is_expected.to have_many :contents }
    it { is_expected.to have_many(:sender_invites).class_name('Invite') }
    it { is_expected.to have_many(:receiver_invites).class_name('Invite') }
    it { is_expected.to have_many(:f_partner_friendships).class_name('Friendship') }
    it { is_expected.to have_many(:s_partner_friendships).class_name('Friendship') }
  end
end
