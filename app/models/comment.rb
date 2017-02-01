class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  belongs_to :user

  validates :title, presence: true
  validates :comment, presence: true
  validates :user_id, presence: true
  validates :commentable_id, presence: true
end
