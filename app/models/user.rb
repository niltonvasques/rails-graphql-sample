class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include ActiveModel::SecurePassword
  has_secure_password

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true

  validate :customer_cant_be_agent
  validate :customer_cant_be_admin

  private

  def customer_cant_be_agent
    if customer? and agent?
      errors.add(:customer, :cant_be_agent)
      errors.add(:agent, :cant_be_customer)
    end
  end

  def customer_cant_be_admin
    if customer? and admin?
      errors.add(:customer, :cant_be_admin)
      errors.add(:admin, :cant_be_customer)
    end
  end
end
