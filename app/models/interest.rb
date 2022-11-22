class Interest < ApplicationRecord
  validates :name_interest, presence: true, length: { within: 5..50 }
  
  has_many :account_interest
  has_many :account, through: :account_interest

  has_many :group_interest
  has_many :groups, through: :group_interest 
end
