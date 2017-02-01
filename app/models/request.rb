class Request < ApplicationRecord
  acts_as_commentable

  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validate :only_customer_can_create

  private

  def only_customer_can_create
    return if user and user.customer?
    errors.add(:user, :allowed_only_for_customer)
  end
end
