require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'report requests closed in last month' do
    let(:report) do
      query = 'query { reportRequestsClosedInLastMonth { id, title, content } }'
      post :query, params: { query: query }, format: :json
    end
    describe 'with good credentials' do
      before do
        sign_in_as_admin
        requests = [build_stubbed(:request)]
        allow(Request).to receive_message_chain(:where, :where) { requests }
        @expected = {
          data: {
            reportRequestsClosedInLastMonth: [{
              id: requests.first.id.to_s,
              title: requests.first.title,
              content: requests.first.content
            }]
          }
        }
        report
      end
      it { expect(response.body).to be_eql @expected.to_json }
    end

    describe 'not signed in' do
      before do
        @expected = {
          error: 'Unauthorized'
        }
        report
      end
      it { expect(response.body).to be_eql @expected.to_json }
    end

    describe 'signed in as customer' do
      before do
        sign_in_as_customer
        @expected = {
          error: 'Unauthorized'
        }
        report
      end
      it { expect(response.body).to be_eql @expected.to_json }
    end
  end
end
