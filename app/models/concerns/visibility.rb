module Visibility
  extend ActiveSupport::Concern

  VALID_VISIBILITY = ['everybody', 'friends', 'nobody']

  included do 
    validates :visibility, inclusion: { in: VALID_STATUES }
  end
end