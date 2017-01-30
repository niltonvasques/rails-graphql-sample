def create_authorized_mutation(admin, agent)
  GraphQL::Relay::Mutation.define do
    name "Register#{ admin ? 'Admin' : 'Agent' }"

    input_field :name, !types.ID
    input_field :email, !types.ID
    input_field :password, !types.String
    input_field :password_confirmation, !types.String

    return_field :agent, UserType

    # The resolve proc is where you alter the system state.
    resolve lambda { |inputs, ctx|
      raise 'Unauthorized' unless ctx[:current_user] and ctx[:current_user].admin?

      agent = User.create!(name: inputs[:name], email: inputs[:email], password: inputs[:password],
                           password_confirmation: inputs[:password_confirmation],
                           agent: agent, customer: false, admin: admin)
      {
        agent: agent
      }
    }
  end
end

RegisterAgentMutation = create_authorized_mutation(false, true)
RegisterAdminMutation = create_authorized_mutation(true, true)
