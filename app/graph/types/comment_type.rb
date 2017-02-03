CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  description 'Comment object'

  field :id, !types.ID
  field :title, !types.String, 'Title'
  field :comment, !types.String, 'Comment'
  field :user, UserType, 'Owner'
  field :request, RequestType do
    resolve ->(obj, _args, _ctx) { obj.commentable }
  end
  field :created_at, !types.String, 'Comment creation date'
  field :updated_at, !types.String, 'Comment update date'
end
