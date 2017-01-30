CreateRequestMutation = GraphQL::Relay::Mutation.define do
  name 'CreateRequest'

  # Accessible from `input` in the resolve function:
  input_field :title, !types.ID
  input_field :content, !types.ID

  return_field :request, RequestType

  resolve lambda { |inputs, ctx|
    raise 'Unauthorized' unless ctx[:current_user] and ctx[:current_user].customer?

    request = Request.create!(title: inputs[:title], content: inputs[:content],
                              user: ctx[:current_user])

    { request: request }
  }
end
