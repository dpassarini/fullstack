class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :accounts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :document, presence: true
  validate :document_type

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user.try(:valid_password?, password) ? user : nil
  end

  def document_type
    return true if is_company?
    return true if is_person?
    errors.add(:document, "invalid document")
  end

  def is_company?
    CNPJ.valid?(document)
  end

  def is_person?
    CPF.valid?(document)
  end
end
