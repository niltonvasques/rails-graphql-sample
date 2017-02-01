require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { Comment.new }

  subject { comment }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:comment) }
  it { is_expected.to respond_to(:commentable) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }

  # Validations
  %w(title comment user_id commentable_id).each do |field|
    describe "when #{field} is not present" do
      before { comment[field] = nil }
      it { is_expected.to have_at_least(1).error_on(field.to_sym) }
    end
  end
end
