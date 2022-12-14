# frozen_string_literal: true

class ContentDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def formatted_created_at
    I18n.l(created_at, format: '%d %B %Y')
  end
end
