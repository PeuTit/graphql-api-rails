module Mutations
  class UpdatePost < BaseMutation
    argument :id, String, required: true
    argument :title, String, required: false
    argument :body, String, required: false
    argument :author, String, required: false

    type Types::PostType

    def resolve(id:, **args)
      Post.find(id).tap do |post|
        post.update!(args)
      end
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(", ")}")
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Record not found: #{e}")
    end
  end
end
