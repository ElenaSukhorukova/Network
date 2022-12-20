class GroupDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    I18n.l(created_at, format: '%d %B %Y')
  end
end
