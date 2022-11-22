class Account < ApplicationRecord
  include Visibility
  VALID_GENDERS = ['Female', 'Male', 'Other']
  STATE = ['online', 'ofline']

  validates :user_name, presence: true, length: { within: 5..50 }
  validates :gender, inclusion: { in: VALID_GENDERS }
  validates :date_birthday, format: { with: /\d{4}\-\d{2}\-\d{2}/,
    message: "a format of date is allowed only xx.xx.xxxx" }
  validates :date_birthday, comparison: { greater_than: Date.parse('1900-01-01'), less_than: Date.current, 
    message: 'You should be little elder then a current date and younger then 1900-01-01.'
  }

  belongs_to :user
  has_many :account_interest
  has_many :interest, through: :account_interest
end
