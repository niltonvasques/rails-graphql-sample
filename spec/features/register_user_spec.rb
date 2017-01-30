require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  mutation = <<EOF
    mutation registerUser($input: RegisterUserInput!) {
      registerUser(input: $input) {
        user { id, name, email }
      }
    }
EOF
  input = { name: 'test', email: 'test@test.com', password: '123456', 
            password_confirmation: '123456' }
  expected = { 
    registerUser: {
      user: {
        id: '1',
        name: input[:name],
        email: input[:email]
      }
    }
  }

  it_behaves_like 'a creatable mutation', User, mutation, input, expected
end
