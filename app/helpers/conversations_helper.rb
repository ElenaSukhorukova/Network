module ConversationsHelper
  def find_interlocutor(conversation)
    if conversation.f_partner_conversation == current_user.account
      Account.find(conversation.s_partner_conversation_id).decorate
    else
      Account.find(conversation.f_partner_conversation_id).decorate
    end
  end
end
