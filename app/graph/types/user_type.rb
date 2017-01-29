UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'User object'
  field :id, !types.ID
  field :name, !types.String, 'User name'
  field :email, !types.String, 'User email'
  field :customer, !types.Boolean, 'Customer?'
  field :agent, !types.Boolean, 'Agent?'
  field :admin, !types.Boolean, 'Admin?'
  field :created_at, !types.String, 'User creation date'
  field :updated_at, !types.String, 'User update date'
end
