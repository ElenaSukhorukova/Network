# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  let(:message) { create(:conversation_with_messages).messages.take }

  it 'returns message\'s body' do
    expect(message.body).to eq('Message\'s body')
    expect(message.body).to be_an_instance_of(String)
  end

  describe 'validation' do
    it 'returns true for the message\'s body' do
      expect(message.body.present?).to be true
    end
  end

  describe 'association' do
    it 'belongs an account' do
      expect(message.sender_message).to be_an_instance_of(Account)
    end

    it 'belongs an account' do
      expect(message.recipient_message).to be_an_instance_of(Account)
    end

    it 'belongs a conversation' do
      expect(message.conversation).to be_an_instance_of(Conversation)
    end
  end
end
