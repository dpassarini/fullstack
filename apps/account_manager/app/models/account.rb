class Account < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :parent_account, class_name: 'Account', foreign_key: 'parent_account_id'
  has_many :sub_accounts, class_name: 'Account', primary_key: :id, foreign_key: 'parent_account_id'

  validate :has_users?
  validates :status, presence: true
  validate :valid_status


  STATUS = %w[active cancelled blocked].freeze

  def has_users?
    errors.add(:users, 'Account must have at least one user.') if users.blank?
  end

  def is_master?
    parent_account_id.nil?
  end

  def received_values
    Transfer.where(receiver_account_id: id)
  end

  def sent_values
    Transfer.where(sender_account_id: id)
  end

  def valid_status
    errors.add(:status, 'Invalid status.') unless STATUS.include?(status)
  end

  def active?
    status == 'active'
  end

  def can_be_charged?
    status && is_master?
  end

  def can_receive_from_this_account?(sender_account)
    sender_account.sub_accounts.include?(self) && !is_master?
  end
end
