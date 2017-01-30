require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  before { sign_in_as_admin }

  mutation = <<EOF
    mutation registerAdmin($input: RegisterAdminInput!) {
      registerAdmin(input: $input) {
        agent { id, name, email, customer, agent, admin }
      }
    }
EOF
  input = { name: 'test', email: 'test@test.com', password: '123456',
            password_confirmation: '123456' }

  expected = {
    registerAdmin: {
      agent: {
        id: '1',
        name: input[:name],
        email: input[:email],
        customer: false,
        agent: true,
        admin: true
      }
    }
  }

  it_behaves_like 'a creatable mutation', User, mutation, input, expected
end
