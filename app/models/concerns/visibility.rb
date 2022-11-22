module Visibility
  extend ActiveSupport::Concern

  VALID_VISIBILITY = ['all', 'friend', 'nobody']

  included do 
    validates :visibility, inclusion: { in: VALID_STATUES }
  end
end