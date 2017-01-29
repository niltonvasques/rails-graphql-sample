class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true

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
