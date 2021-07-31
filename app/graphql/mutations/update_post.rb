module Mutations
  class UpdatePost < BaseMutation
    argument :id, String, required: true
    argument :title, String, required: false
    argument :body, String, required: false
    argument :author, String, required: false

    type Types::PostType

    def resolve(id:, title:, body:, author:)
      Post.find(id).tap do |post|
        post.update!(
          title: title,
          body: body,
          author: author
        )
      end
    end
  end
end
