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

  def sign_in(password)
    # Only generate token if the user isn't signed in
    if authenticate(password)
      generate_token unless signed_in?
      save!
      return true
    end
    false
  end

  def sign_out
    if signed_in?
      erase_token
      save!
    else
      false
    end
  end

  def signed_in?
    not token.nil?
  end

  private

  def customer_cant_be_agent
    return unless customer? and agent?
    errors.add(:customer, :cant_be_agent)
    errors.add(:agent, :cant_be_customer)
  end

  def customer_cant_be_admin
    return unless customer? and admin?
    errors.add(:customer, :cant_be_admin)
    errors.add(:admin, :cant_be_customer)
  end

  def generate_token
    # pseudo random numbers with 16 bits has almost zero chance of have collisions
    self.token = SecureRandom.urlsafe_base64(16)
  end

  def erase_token
    self.token = nil
  end
end
