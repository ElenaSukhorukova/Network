# frozen_string_literal: true

(60 - User.count).times do |index|
  email = "email#{index + User.count + 1}@email.com"
  password = 'test123'
  User.create email: email, password: password
end

User.all.collect do |user|
  next if user.account

  user_id = user.id
  user_name = Faker::FunnyName.two_word_name
  gender = Account::VALID_GENDERS.sample
  date_birthday = Faker::Date.birthday(min_age: 18, max_age: 75)
  about_oneself = Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4)
  country = Account::VALID_COUNTRY.sample
  visibility = Account::VALID_VISIBILITY.sample
  state = Account::STATES.sample

  account = Account.create user_id: user_id, user_name: user_name, gender: gender, date_birthday: date_birthday,
                           about_oneself: about_oneself, country: country, visibility: visibility, state: state
end

Account.all.collect do |account|
  next unless account.hobbies.count < 3

  quantity = 3 - account.hobbies.count
  quantity.times do
    hobby_name = Faker::Hobby.activity

    hobby = Hobby.new_hobby hobby_name: hobby_name
    hobby.save
    account.hobbies << hobby unless account.hobbies.find_by(hobby_name: hobby.hobby_name)
  end
end

Account.all.collect do |account|
  quantity = rand(5...10)

  next if account.posts.try(:any?)

  quantity.times do
    author_post_id = Account.ids.sample
    body = Faker::Lorem.paragraph(sentence_count: 40, supplemental: true, random_sentences_to_add: 10)

    Post.create author_post_id: author_post_id, body: body
  end
end

Post.all.collect do |post|
  quantity = rand(3...15)

  next if post.comments.try(:any?)

  quantity.times do
    author_comment_id = Account.ids.sample
    body = Faker::Lorem.paragraph(sentence_count: 4, supplemental: true, random_sentences_to_add: 10)
    commentable_type = post.class.to_s
    commentable_id = post.id

    Comment.create author_comment_id: author_comment_id, body: body,
                   commentable_type: commentable_type,
                   commentable_id: commentable_id
  end
end

Account.all.collect do |account|
  quantity = rand(5...15)
  sender_invite_id = account.id

  next if account.sender_invites.try(:any?) || account.receiver_invites.try(:any?)

  quantity.times do
    receiver_invite_id = Account.ids.delete_if { |id| id == sender_invite_id }.sample

    next if Invite.find_by(sender_invite_id: sender_invite_id, receiver_invite_id: receiver_invite_id) ||
            Invite.find_by(sender_invite_id: receiver_invite_id, receiver_invite_id: sender_invite_id)

    Invite.create sender_invite_id: sender_invite_id, receiver_invite_id: receiver_invite_id
  end
end

Account.all.collect do |account|
  next if account.f_partner_friendships.try(:any?) || account.s_partner_friendships.try(:any?)

  quantity = rand(5...15)
  invite_id = Invite.where(sender_invite: account, confirmed: 'not').ids.sample
  next unless invite_id && (invite = Invite.find(invite_id))

  quantity.times do
    receiver = invite.receiver_invite
    next unless !(Friendship.find_by(f_partner_friendship: account, s_partner_friendship: receiver) ||
             Friendship.find_by(f_partner_friendship: receiver,
                                s_partner_friendship: account)) && (Friendship.create f_partner_friendship: account, s_partner_friendship: receiver,
                                                                                      invite: invite)

    invite.update(confirmed: 'yes')
  end
end

Account.all.collect do |sender|
  next if sender.sender_messages.try(:any?)

  rand(20...40).times do
    receiver = Account.find(Account.ids.delete_if { |id| id == sender.id }.sample)
    friendship = Friendship.find_by(f_partner_friendship: sender, s_partner_friendship: receiver) ||
                 Friendship.find_by(s_partner_friendship: sender, f_partner_friendship: receiver)

    unless (receiver.visibility == 'everybody' || friendship) && Conversation.account_conversations(sender).count < 20
      next
    end

    conversation = Conversation.new_conv(sender, receiver)
    10.times do
      body = Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4)
      Message.create body: body, sender_message: sender, recipient_message: receiver, conversation: conversation

      body = Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4)
      Message.create body: body, sender_message: receiver, recipient_message: sender, conversation: conversation
    end
  end
end

Account.all.collect do |account|
  next if account.groups.try(:any?)

  rand(1..10).times do
    name_group = Faker::Hobby.activity
    description = Faker::Lorem.paragraph(sentence_count: 10, supplemental: true, random_sentences_to_add: 4)
    visibility = Group::VALID_VISIBILITY.sample
    group_creator_id = account.id

    Group.create name_group: name_group, description: description, visibility: visibility,
                 group_creator_id: group_creator_id
  end
end

Group.all.collect do |group|
  next unless group.hobbies.count < 3

  quantity = 3 - group.hobbies.count
  quantity.times do
    hobby_name = Faker::Hobby.activity

    hobby = Hobby.new_hobby hobby_name: hobby_name
    hobby.save
    group.hobbies << hobby unless group.hobbies.find_by(hobby_name: hobby.hobby_name)
  end
end
