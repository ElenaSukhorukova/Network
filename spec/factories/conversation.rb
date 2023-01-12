# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    body { 'Message\'s body' }
    conversation
    association :sender_message, factory: :account
    association :recipient_message, factory: :account
  end

  factory :conversation do
    f_partner_conversation { Account.take || create(:account) }
    s_partner_conversation { create(:account) }

    factory :conversation_with_messages do
      transient do
        message_count { 5 }
      end

      after(:create) do |conversation, evaluator|
        create_list(:message, evaluator.message_count,
                    conversation: conversation,
                    sender_message: conversation.f_partner_conversation,
                    recipient_message: conversation.s_partner_conversation)
        conversation.reload
      end
    end
  end
end
