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
end

Schema = GraphQL::Schema.define do
  query QueryType
end
