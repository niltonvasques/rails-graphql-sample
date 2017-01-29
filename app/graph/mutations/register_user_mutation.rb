RegisterUserMutation = GraphQL::Relay::Mutation.define do
  # Used to name derived types, eg `"AddCommentInput"`:
  name 'RegisterUser'

  # Accessible from `input` in the resolve function:
  input_field :name, !types.ID
  input_field :email, !types.ID
  input_field :password, !types.String
  input_field :password_confirmation, !types.String

  # The result has access to these fields,
  # resolve must return a hash with these keys
  return_field :user, UserType

  # The resolve proc is where you alter the system state.
  resolve lambda { |inputs, _ctx|
    user = User.create!(name: inputs[:name], email: inputs[:email], password: inputs[:password],
                        password_confirmation: inputs[:password_confirmation])
    {
      user: user
    }
  }
end
