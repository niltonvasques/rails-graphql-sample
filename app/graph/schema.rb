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
    resolve ->(_obj, args, _ctx) { User.find(args['id']) }
  end

  field :requests, types[RequestType] do
    resolve lambda { |_obj, _args, ctx|
      raise 'Unauthorized' unless ctx[:current_user]

      return ctx[:current_user].requests if ctx[:current_user].customer?

      Request.all
    }
  end

  field :request do
    type RequestType
    argument :id, !types.ID
    description 'Find a request by id'
    resolve lambda { |_obj, args, ctx|
      raise 'Unauthorized' unless ctx[:current_user]

      return ctx[:current_user].requests.find(args['id']) if ctx[:current_user].customer?

      Request.find(args['id'])
    }
  end
end

# Define the mutation type
MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  # Auth mutations
  field :registerUser, field: RegisterUserMutation.field
  field :registerAgent, field: RegisterAgentMutation.field
  field :registerAdmin, field: RegisterAdminMutation.field
  field :signIn, field: SignInMutation.field
  field :signOut, field: SignOutMutation.field

  # Request mutations
  field :createRequest, field: CreateRequestMutation.field
  field :closeRequest, field: CloseRequestMutation.field
  field :addComment, field: AddCommentMutation.field
end

Schema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
end
