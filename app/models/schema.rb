UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'User object'
  field :id, !types.ID
  field :name, !types.String, 'User name'
  field :email, !types.String, 'User email'
  field :created_at, !types.String, 'User creation date'
  field :updated_at, !types.String, 'User update date'
end

#def paginated_resolver(desc)
#  argument :page, types.Int
#  argument :page_size, types.Int
#  description desc
#  resolve -> (obj, args, ctx) {
#    page = args[:page] || 1
#    page_size = args[:page_size] || Gif::PAGE_SIZE
#    yield.page(page).per(page_size)
#  }
#end

QueryType = GraphQL::ObjectType.define do
  name 'query'
  description 'The root of all queries'

  field :users, types[UserType] do
    resolve -> (obj, args, ctx) { User.all }
  end

  field :user do
    type UserType
    argument :id, !types.ID
    description "Find a user by id"
    resolve -> (obj, args, ctx) { User.find_by(args['id']) }
  end
end

RegisterUserMutation = GraphQL::Relay::Mutation.define do
  # Used to name derived types, eg `"AddCommentInput"`:
  name "RegisterUser"

  # Accessible from `input` in the resolve function:
  input_field :name, !types.ID
  input_field :email, !types.ID
  input_field :password, !types.String
  input_field :password_confirmation, !types.String

  # The result has access to these fields,
  # resolve must return a hash with these keys
  return_field :user, UserType

  # The resolve proc is where you alter the system state.
  resolve ->(inputs, ctx) {
    user = User.create!(name: inputs[:name], email: inputs[:email], password: inputs[:password], 
                        password_confirmation: inputs[:password_confirmation])
    {
      user: user
    }
  }
end

# Define the mutation type
MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :registerUser, field: RegisterUserMutation.field
end

Schema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
end
