require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { Request.new }

  subject { request }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:open) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }
  it { is_expected.to respond_to(:comments) }

  # Validations
  %w(title content user_id).each do |field|
    describe "when #{field} is not present" do
      before { request[field] = nil }
      it { is_expected.to have_at_least(1).error_on(field.to_sym) }
    end
  end

  describe 'when the user is a non customer' do
    before { request.user = build_stubbed(:user, customer: false, agent: true) }
    it { is_expected.to have_at_least(1).error_on(:user) }
  end
end
