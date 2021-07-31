module Types
  class PostType < Types::BaseObject
    description "A blog post"

    field :id, ID, null: false
    field :title, String, null: true, description: "The title of a post"
    field :body, String, null: true, description: "The body of a post"
    field :author, String, null: true, description: "The author of a post"
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
