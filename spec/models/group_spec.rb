# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  let(:group) { create(:group) }

  it 'returns group\'s name' do
    expect(group.name_group).to eq('Group\'s name')
  end

  it 'returns true for group\'s description' do
    expect(group.description).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the group\'s name' do
      expect(group.name_group.present?).to be true
    end

    it 'returns true for the group\'s description' do
      expect(group.description.present?).to be true
    end

    it 'returns true for the visibility' do
      expect(Group::VALID_VISIBILITY).to include(group.visibility)
    end
  end

  describe 'association' do
    it 'belongs an account' do
      expect(group.group_creator).to be_an_instance_of(Account)
    end

    it { is_expected.to have_many :contents }
    it { is_expected.to have_one_attached(:group_image) }
  end
end
