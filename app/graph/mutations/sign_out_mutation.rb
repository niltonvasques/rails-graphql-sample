SignOutMutation = GraphQL::Relay::Mutation.define do
  name 'SignOut'

  input_field :email, !types.ID
  input_field :password, !types.String

  return_field :result, !types.Boolean

  # The resolve proc is where you alter the system state.
  resolve lambda { |inputs, _ctx|
    user = User.find_by(email: inputs[:email])

    raise 'Bad credentials' unless user.authenticate(inputs[:password])

    user.sign_out

    {
      result: true
    }
  }
end
