# model account
class Account < ApplicationRecord
  belongs_to :user

  scope :get_account_amount, ->(user_id, currency) {
    where(user_id: user_id, currency: currency)
  }
end
