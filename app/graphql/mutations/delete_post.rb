module Mutations
  class DeletePost < BaseMutation
    argument :id, String, required: true

    type Types::PostType

    def resolve(id:)
      Post.find(id).destroy
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Record not found: #{e}")
    end
  end
end
