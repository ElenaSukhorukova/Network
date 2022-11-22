class AccountInterest < ApplicationRecord
  belongs_to :account
  belongs_to :interest
end
