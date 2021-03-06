RequestType = GraphQL::ObjectType.define do
  name 'Request'
  description 'Request object'
  field :id, !types.ID
  field :title, !types.String, 'Title'
  field :content, !types.String, 'Content'
  field :user, UserType, 'Owner'
  field :open, !types.Boolean, 'Open'
  field :created_at, !types.String, 'User creation date'
  field :updated_at, !types.String, 'User update date'
  field :comments, types[CommentType] do
    resolve ->(obj, _args, _ctx) { obj.comments }
  end
end
