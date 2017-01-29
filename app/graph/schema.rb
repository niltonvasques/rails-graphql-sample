# def paginated_resolver(desc)
#   argument :page, types.Int
#   argument :page_size, types.Int
#   description desc
#   resolve -> (obj, args, ctx) {
#     page = args[:page] || 1
#     page_size = args[:page_size] || Gif::PAGE_SIZE
#     yield.page(page).per(page_size)
#   }
# end

QueryType = GraphQL::ObjectType.define do
  name 'query'
  description 'The root of all queries'

  field :users, types[UserType] do
    resolve ->(_obj, _args, _ctx) { User.all }
  end

  field :user do
    type UserType
    argument :id, !types.ID
    description 'Find a user by id'
    resolve ->(_obj, args, _ctx) { User.find_by(args['id']) }
  end
end

# Define the mutation type
MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :registerUser, field: RegisterUserMutation.field
  field :signIn, field: SignInMutation.field
end

Schema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
end
