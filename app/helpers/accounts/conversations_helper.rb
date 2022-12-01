module Accounts::ConversationsHelper
  def interlocutor(conversation)
    conversation.f_partner_conversation_id == current_user.account.id ? 
      Account.find_by(id: conversation.s_partner_conversation_id) :
      Account.find_by(id: conversation.f_partner_conversation_id)
  end 
end