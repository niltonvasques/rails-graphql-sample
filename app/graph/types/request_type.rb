RequestType = GraphQL::ObjectType.define do
  name 'Request'
  description 'Request object'
  field :id, !types.ID
  field :title, !types.String, 'Title'
  field :content, !types.String, 'Content'
  field :user, UserType, 'Owner'
  field :created_at, !types.String, 'User creation date'
  field :updated_at, !types.String, 'User update date'
end
