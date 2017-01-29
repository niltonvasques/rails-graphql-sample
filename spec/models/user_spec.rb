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

  describe 'with an user' do
    before do
      @user = build_stubbed(:user)
      allow(@user).to receive(:save!)
    end

    describe 'and try authenticate' do
      describe 'with valid password' do
        before { @user.sign_in('foobar') }

        it { expect(@user.token).to_not be_nil }
        it { expect(@user).to be_signed_in }

        describe 'and try authenticate again' do
          before do
            @old_token = @user.token
            @user.sign_in('foobar')
          end
          it { expect(@user.token).to be_eql(@old_token) }
          it { expect(@user.sign_in('wrong')).to be_falsey }
        end
      end

      describe 'with invalid password' do
        before { @user.sign_in('wrong') }

        it { expect(@user.token).to be_nil }
        it { expect(@user).to_not be_signed_in }
      end
    end

    describe 'when try sign_out' do
      describe 'and is signed in' do
        before do
          @user.sign_in('foobar')
          @user.sign_out
        end

        it { expect(@user.token).to be_nil }
        it { expect(@user).to_not be_signed_in }
      end
      describe 'and is not signed in' do
        it { expect(@user.sign_out).to be_falsey }
      end
    end
  end
end
