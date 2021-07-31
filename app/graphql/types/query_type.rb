module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :all_posts, [PostType], null: true do
      description "Get all posts"
    end

    def all_posts
      Post.all
    end

    field :post, PostType, null: true do
      description "Get a specific post"
      argument :id, ID, required: true
    end

    def post(id:)
      Post.find(id)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Record not found: #{e}")
    end
  end
end
