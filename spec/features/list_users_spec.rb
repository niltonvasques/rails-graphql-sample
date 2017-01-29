require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  context 'list users' do
    let(:list_users) do
      query = 'query { users { id, name, email, customer, agent, admin } }'
      post :query, params: { query: query }, format: :json
    end
    before do
      @user = create(:user)
      @password = 'foobar'
    end
    describe 'with good credentials' do
      before do
        users = [build_stubbed(:user)]
        allow(User).to receive(:all).and_return(users)
        @expected = {
          data: {
            users: [{
              id: users.first.id.to_s,
              name: users.first.name,
              email: users.first.email,
              customer: users.first.customer,
              agent: users.first.agent,
              admin: users.first.admin
            }]
          }
        }
        list_users
      end
      it { expect(response.body).to be_eql @expected.to_json }
    end
  end
end
