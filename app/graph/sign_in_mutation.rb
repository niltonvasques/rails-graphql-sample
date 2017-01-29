SignInMutation = GraphQL::Relay::Mutation.define do
  # Used to name derived types, eg `"AddCommentInput"`:
  name "SignIn"

  # Accessible from `input` in the resolve function:
  input_field :email, !types.ID
  input_field :password, !types.String

  # The result has access to these fields,
  # resolve must return a hash with these keys
  return_field :token, !types.String

  # The resolve proc is where you alter the system state.
  resolve ->(inputs, ctx) {
    user = User.find_by(email: inputs[:email])
    if user.sign_in(inputs[:password])
      {
        token: user.token
      }
    else
      raise "Bad credentials"
    end
  }
end
