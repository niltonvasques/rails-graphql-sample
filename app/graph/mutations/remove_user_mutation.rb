RemoveUserMutation = GraphQL::Relay::Mutation.define do
  name 'RemoveUser'

  # Accessible from `input` in the resolve function:
  input_field :id, !types.ID

  return_field :removed, !types.Boolean

  resolve lambda { |inputs, ctx|
    raise 'Unauthorized' unless ctx[:current_user] and ctx[:current_user].admin?

    User.find(inputs[:id]).destroy

    { removed: true }
  }
end
