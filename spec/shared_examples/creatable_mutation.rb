shared_examples_for 'a creatable mutation' do |model, mutation, input, expected|
  context 'create' do
    let(:create) do
      variables = { input: input }.to_json
      post :query, params: { query: mutation, variables: variables }, format: :json
    end

    describe 'when try create' do
      it { expect { create }.to change(model, :count).by(1) }

      describe 'and evaluate the result' do
        before do
          @expected = {
            data: expected
          }
          create
        end
        it { expect(response.body).to be_eql @expected.to_json }
      end
    end
  end
end
