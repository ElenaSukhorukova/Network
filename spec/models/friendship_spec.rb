# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship do
  let(:friendship) { create(:invite_with_friendship).friendship }

  describe 'association' do
    it 'belongs an account' do
      expect(friendship.f_partner_friendship).to be_an_instance_of(Account)
    end

    it 'belongs an account' do
      expect(friendship.s_partner_friendship).to be_an_instance_of(Account)
    end

    it 'belongs a conversation' do
      expect(friendship.invite).to be_an_instance_of(Invite)
    end
  end
end
