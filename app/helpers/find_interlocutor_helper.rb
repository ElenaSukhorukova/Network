module FindInterlocutorHelper
  def find_interlocutor(account_id, conv)
    if conv.f_partner_conversation_id == account_id
      Account.find_by(id: conv.s_partner_conversation_id)
    else
      Account.find_by(id: conv.f_partner_conversation_id)
    end
  end
end