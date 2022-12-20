class AccountDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def capitalize_name
    user_name.split(' ').map(&:capitalize).join(' ')
  end
  
  def decorate_date_birthday
    I18n.l(date_birthday, format: '%d %B %Y')
  end
end
