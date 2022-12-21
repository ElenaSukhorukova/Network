# frozen_string_literal: true

module Groups
  class GroupsContentDecorator < Draper::Decorator
    delegate_all
    decorates_finders
  end
end
