# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content do
  let(:content) { create(:content) }

  it 'returns content\'s body' do
    expect(content.body).to eq('Content\'s body')
    expect(content.body).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the content\'s body' do
      expect(content.body.present?).to be true
    end

    it 'returns true for the invalid content' do
      content.body = Faker::Alphanumeric.alpha(number: 1)
      expect(content.invalid?).to be true
    end
  end

  describe 'association' do
    it 'belongs an account' do
      expect(content.account).to be_an_instance_of(Account)
    end

    it 'belongs a group' do
      expect(content.group).to be_an_instance_of(Group)
    end

    it { is_expected.to have_many_attached(:images) }
  end
end
