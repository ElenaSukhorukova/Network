# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invite do
  let(:invite) { create(:invite) }

  describe 'validation' do
    it 'return true for confirmed of an invite' do
      expect(Invite::VALID_CONFIRMED).to include(invite.confirmed)
    end
  end

  describe 'association' do
    it 'belongs to an account' do
      expect(invite.sender_invite).to be_an_instance_of(Account)
      expect(invite.receiver_invite).to be_an_instance_of(Account)
    end

    it { is_expected.to have_one :friendship }
  end
end
