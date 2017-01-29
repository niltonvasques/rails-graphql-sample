require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:credentials) do
      { email: @user.email, password: 'foobar' }
    end

    let(:sign_in) do
      mutation = <<EOF
        mutation signIn($input: SignInInput!) {
          signIn(input: $input) {
            token
          }
        }
EOF
      variables = { input: credentials }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try sign in' do
      before do
        @user = create(:user)
        @user.sign_in('foobar')

        @expected = {
          data: {
            signIn: {
              token: @user.token
            }
          }
        }
        sign_in
      end
      it { expect(response.body).to be_eql @expected.to_json }
    end
  end
end
