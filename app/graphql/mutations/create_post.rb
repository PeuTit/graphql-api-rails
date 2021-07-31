module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true
    argument :author, String, required: true

    type Types::PostType

    def resolve(title:, body:, author:)
      Post.create!(
        title: title,
        body: body,
        author: author
      )
    end
  end
end
