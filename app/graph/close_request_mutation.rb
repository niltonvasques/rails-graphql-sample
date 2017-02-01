CloseRequestMutation = GraphQL::Relay::Mutation.define do
  name 'CloseRequest'

  input_field :id, !types.ID

  return_field :request, RequestType

  # The resolve proc is where you alter the system state.
  resolve lambda { |inputs, ctx|
    raise 'Unauthorized' unless ctx[:current_user]

    request = Request.find(inputs[:id].to_i)

    raise 'Unauthorized' if !ctx[:current_user].agent? and request.user_id != ctx[:current_user].id

    request.update(open: false)

    {
      request: request
    }
  }
end
