require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:request) do
      { title: 'title', content: 'content' }
    end

    let(:create_request) do
      mutation = <<EOF
        mutation createRequest($input: CreateRequestInput!) {
          createRequest(input: $input) {
            request { id, title, content, user { id } }
          }
        }
EOF
      variables = { input: request }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try register a agent' do
      before { @user = sign_in_as_customer }

      it { expect { create_request }.to change(Request, :count).by(1) }

      describe 'and evaluate the result' do
        before do
          @expected = {
            data: {
              createRequest: {
                request: {
                  id: '1',
                  title: request[:title],
                  content: request[:content],
                  user: { id: @user.id.to_s } 
                }
              }
            }
          }
          create_request
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
