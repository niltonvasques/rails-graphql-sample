CloseRequestMutation = GraphQL::Relay::Mutation.define do
  name 'CloseRequest'

  input_field :id, !types.ID

  return_field :request, RequestType

  # The resolve proc is where you alter the system state.
  resolve lambda { |inputs, ctx|
    raise 'Unauthorized' unless ctx[:current_user]

    request = Request.find(inputs[:id].to_i)

    # Only agents or user that create request should close request
    raise 'Unauthorized' unless AuthorizationHelper.can_edit_request(request, ctx[:current_user])

    request.update(open: false)

    {
      request: request
    }
  }
end
