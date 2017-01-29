require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

  subject { user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:created_at) }
  it { is_expected.to respond_to(:updated_at) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:token) }
  it { is_expected.to respond_to(:customer?) }
  it { is_expected.to respond_to(:agent?) }

  # Validations
  describe 'when email is not present' do
    before { user.email = ' ' }
    it { is_expected.to have_at_least(1).error_on(:email) }
  end

  describe 'when email is invalid' do
    before { user.email = 'ze' }
    it { is_expected.to have_at_least(1).error_on(:email) }
  end

  # Validations
  describe 'when password_digest is not present' do
    before { user.password_digest = nil }
    it { is_expected.to have_at_least(1).error_on(:password_digest) }
  end

  describe 'when a customer is an agent' do
    before { user.customer = user.agent = true }
    it { is_expected.to have_at_least(1).error_on(:customer) }
    it { is_expected.to have_at_least(1).error_on(:agent) }
  end

  describe 'when a customer is an admin' do
    before { user.customer = user.admin = true }
    it { is_expected.to have_at_least(1).error_on(:admin) }
    it { is_expected.to have_at_least(1).error_on(:customer) }
  end
end
