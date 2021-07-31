module Mutations
  class DeletePost < BaseMutation
    argument :id, String, required: true

    type Types::PostType

    def resolve(id:)
      Post.find(id).destroy
    end
  end
end
