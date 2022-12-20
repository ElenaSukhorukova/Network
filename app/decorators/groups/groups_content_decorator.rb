class Groups::GroupsContentDecorator < Draper::Decorator
  delegate_all
  decorates_finders
end
