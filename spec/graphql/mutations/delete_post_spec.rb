require "rails_helper"

module Mutations
  RSpec.describe DeletePost, type: :request do
    subject { Post.create!(title: "Some title", body: "Some body :)", author: "Some author") }

    describe ".resolve" do
      context "Invalid Id" do
        let(:invalid_post_query_id) {
          <<~GQL
            mutation {
              deletePost(input: {
                id: "not_an_id",
              }) {
                id
                title
                body
                author
              }
            }
          GQL
        }

        it "Fails with non existing id" do
          post("/graphql", params: {query: invalid_post_query_id})

          expect(json_response["data"]).to be_nil
          expect(json_response["errors"][0]["message"]).to eql(
            "Record not found: Couldn't find Post with 'id'=not_an_id"
          )
        end
      end

      context "Valid Id" do
        def valid_post_query(post_id)
          <<~GQL
            mutation {
              deletePost(input: {
                id: "#{post_id}",
              }) {
                id
                title
                body
                author
                createdAt
                updatedAt
              }
            }          
          GQL
        end

        it "Return the new version of the post" do
          post("/graphql", params: {query: valid_post_query(subject.id)})

          expect(json_response["errors"]).to be_nil
          expect(json_response["data"]["deletePost"]).to include(
            "title" => "Some title",
            "body" => "Some body :)",
            "author" => "Some author",
            "createdAt" => be_present,
            "updatedAt" => be_present
          )
        end
      end
    end
  end
end
