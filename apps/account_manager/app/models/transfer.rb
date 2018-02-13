class Transfer < ApplicationRecord
  has_many :received_transfers, class_name: "Transfer", foreign_key: 'receiver_account_id'
  has_many :sent_transfers, class_name: "Transfer", foreign_key: 'sender_account_id'
end
