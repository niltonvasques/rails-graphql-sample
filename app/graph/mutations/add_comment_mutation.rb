AddCommentMutation = GraphQL::Relay::Mutation.define do
  name 'AddComment'

  # Accessible from `input` in the resolve function:
  input_field :request_id, !types.ID
  input_field :title, !types.String
  input_field :comment, !types.String

  return_field :comment, CommentType

  resolve lambda { |inputs, ctx|
    raise 'Unauthorized' unless ctx[:current_user]

    request = Request.find(inputs[:request_id])

    # Only agents or user that create request should comment
    raise 'Unauthorized' unless AuthorizationHelper.can_edit_request(request, ctx[:current_user])

    comment = request.comments.create!(title: inputs[:title], comment: inputs[:comment],
                                       user: ctx[:current_user])

    { comment: comment }
  }
end
