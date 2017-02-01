require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'create' do
    let(:input) do
      { id: @req.id }
    end

    let(:close_request) do
      mutation = <<EOF
        mutation closeRequest($input: CloseRequestInput!) {
          closeRequest(input: $input) {
            request { id }
          }
        }
EOF
      variables = { input: input }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try close request' do
      before do
        @req = create(:request)
      end
      describe 'with good credentials' do
        before do
          sign_in_as_admin

          @expected = {
            data: {
              closeRequest: {
                request: {
                  id: @req.id.to_s
                }
              }
            }
          }
          close_request
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end

      describe 'with a different user' do
        before do
          sign_in_as_customer
          @expected = {
            error: 'Unauthorized'
          }
          close_request
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end

      describe 'with bad credentials' do
        before do
          @expected = {
            error: 'Unauthorized'
          }
          close_request
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
