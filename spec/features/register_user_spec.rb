require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:user) do
      { name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456' }
    end

    let(:register_user) do
      mutation =<<EOF
        mutation registerUser($input: RegisterUserInput!) {
          registerUser(input: $input) { 
            user { id, name, email }
          }
        }
EOF
      variables = { input: user }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try register a user' do
      it { expect { register_user }.to change(User, :count).by(1) }

      describe 'and evaluate the result' do
        before do
          @expected = {
            data: {
              registerUser: {
                user: {
                  id: "1",
                  name: user[:name],
                  email: user[:email],
                }
              }
            }
          }
          register_user
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
