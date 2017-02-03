RemoveRequestMutation = GraphQL::Relay::Mutation.define do
  name 'RemoveRequest'

  # Accessible from `input` in the resolve function:
  input_field :id, !types.ID

  return_field :removed, !types.Boolean

  resolve lambda { |inputs, ctx|
    raise 'Unauthorized' unless ctx[:current_user] and ctx[:current_user].admin?

    Request.find(inputs[:id]).destroy

    { removed: true }
  }
end
