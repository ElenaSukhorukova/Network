# frozen_string_literal: true

class MessageDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def formatted_created_at
    I18n.l(created_at, format: '%d.%m.%Y %H:%M')
  end
end
