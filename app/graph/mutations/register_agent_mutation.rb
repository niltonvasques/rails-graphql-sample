RegisterAgentMutation = GraphQL::Relay::Mutation.define do
  name 'RegisterAgent'

  input_field :name, !types.ID
  input_field :email, !types.ID
  input_field :password, !types.String
  input_field :password_confirmation, !types.String

  return_field :agent, UserType

  # The resolve proc is where you alter the system state.
  resolve lambda { |inputs, ctx|

    raise "Unauthorized" unless ctx[:current_user] and ctx[:current_user].admin?

    agent = User.create!(name: inputs[:name], email: inputs[:email], password: inputs[:password],
                         password_confirmation: inputs[:password_confirmation],
                         agent: true, customer: false)
    {
      agent: agent
    }
  }
end
