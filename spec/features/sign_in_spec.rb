require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:credentials) do
      { email: @user.email, password: @password }
    end

    let(:sign_in) do
      mutation = <<EOF
        mutation signIn($input: SignInInput!) {
          signIn(input: $input) {
            data { token, user { id } }
          }
        }
EOF
      variables = { input: credentials }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try sign in' do
      before do
        @user = create(:user)
        @password = 'foobar'
      end
      describe 'with good credentials' do
        before do
          @user.sign_in(@password)

          @expected = {
            data: {
              signIn: {
                data: {
                  token: @user.token,
                  user: {
                    id: @user.id.to_s
                  }
                }
              }
            }
          }
          sign_in
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end

      describe 'with bad credentials' do
        before do
          @expected = {
            error: 'Bad credentials'
          }
          @password = 'wrong'
          sign_in
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
