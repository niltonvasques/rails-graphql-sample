require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'list requests' do
    let(:list_requests) do
      query = 'query { requests { id, title, content } }'
      post :query, params: { query: query }, format: :json
    end
    describe 'with good credentials' do
      before do
        requests = [build_stubbed(:request)]
        allow(Request).to receive(:all).and_return(requests)
        @expected = {
          data: {
            requests: [{
              id: requests.first.id.to_s,
              title: requests.first.title,
              content: requests.first.content
            }]
          }
        }
        list_requests
      end
      it { expect(response.body).to be_eql @expected.to_json }
    end
  end
end
