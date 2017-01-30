require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:user) do
      { name: 'test', email: 'test@test.com', password: '123456', password_confirmation: '123456' }
    end

    let(:register_admin) do
      mutation = <<EOF
        mutation registerAdmin($input: RegisterAdminInput!) {
          registerAdmin(input: $input) {
            agent { id, name, email, customer, agent, admin }
          }
        }
EOF
      variables = { input: user }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try register a admin' do
      before { sign_in_as_admin }

      it { expect { register_admin }.to change(User, :count).by(1) }

      describe 'and evaluate the result' do
        before do
          @expected = {
            data: {
              registerAdmin: {
                agent: {
                  id: '1',
                  name: user[:name],
                  email: user[:email],
                  customer: false,
                  agent: true,
                  admin: true
                }
              }
            }
          }
          register_admin
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
