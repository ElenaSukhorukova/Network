module DateTimeShow
  extend ActiveSupport::Concern

  def formatted_created_at
    created_at.strftime('%Y-%m-%d')
  end
end