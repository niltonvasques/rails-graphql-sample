require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  before { @user = sign_in_as_customer }

  mutation = <<EOF
    mutation createRequest($input: CreateRequestInput!) {
      createRequest(input: $input) {
        request { id, title, content, user { id } }
      }
    }
EOF
  input = { title: 'title', content: 'content' }
  expected = { 
    createRequest: {
      request: {
        id: '1',
        title: input[:title],
        content: input[:content],
        user: { id: "1002" }
      }
    }
  }

  it_behaves_like 'a creatable mutation', Request, mutation, input, expected
end
