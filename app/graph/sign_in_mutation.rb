SignInMutation = GraphQL::Relay::Mutation.define do
  # Used to name derived types, eg `'AddCommentInput'`:
  name 'SignIn'

  # Accessible from `input` in the resolve function:
  input_field :email, !types.ID
  input_field :password, !types.String

  # The result has access to these fields,
  # resolve must return a hash with these keys
  return_field :token, !types.String

  # The resolve proc is where you alter the system state.
  resolve lambda { |inputs, _ctx|
    user = User.find_by(email: inputs[:email])

    raise 'Bad credentials' unless user.sign_in(inputs[:password])

    {
      token: user.token
    }
  }
end
