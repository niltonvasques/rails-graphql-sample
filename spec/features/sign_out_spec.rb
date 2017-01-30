require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:credentials) do
      { email: @user.email, password: @password }
    end

    let(:sign_out) do
      mutation = <<EOF
        mutation signOut($input: SignOutInput!) {
          signOut(input: $input) {
            result
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
              signOut: {
                result: true
              }
            }
          }
          sign_out
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end

      describe 'with bad credentials' do
        before do
          @expected = {
            error: 'Bad credentials'
          }
          @password = 'wrong'
          sign_out
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
