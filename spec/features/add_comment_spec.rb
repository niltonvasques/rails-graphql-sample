require 'rails_helper'

RSpec.describe GraphqlController, type: :controller do
  before do
    @user = sign_in_as_admin
    @req = FactoryGirl.create(:request)
  end

  mutation = <<EOF
    mutation addComment($input: AddCommentInput!) {
      addComment(input: $input) {
        comment { id, title, comment, user { id } }
      }
    }
EOF
  input = { title: 'title', comment: 'content', request_id: 1 }
  expected = {
    addComment: {
      comment: {
        id: '1',
        title: input[:title],
        comment: input[:comment],
        user: { id: '1002' }
      }
    }
  }

  it_behaves_like 'a creatable mutation', Comment, mutation, input, expected
end
