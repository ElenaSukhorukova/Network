# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Conversation do
  let(:conversation) { create(:conversation) }

  describe 'association' do
    it 'belongs an account' do
      expect(conversation.f_partner_conversation).to be_an_instance_of(Account)
    end

    it 'belongs an account' do
      expect(conversation.s_partner_conversation).to be_an_instance_of(Account)
    end

    it { is_expected.to have_many(:messages).class_name('Message') }
  end
end
