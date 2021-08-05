require "rails_helper"

module Mutations
  RSpec.describe UpdatePost, type: :request do
    subject { Post.create!(title: "Some title", body: "Some body :)", author: "Some author") }

    describe ".resolve" do
      context "Invalid Post" do
        def invalid_post_query(post_id)
          <<~GQL
            mutation {
              updatePost(input: {
                id: "#{post_id}",
                title: "",
                body: "",
                author: "",
              }) {
                id
                title
                body
                author
              }
            }
          GQL
        end

        let(:invalid_post_query_id) {
          <<~GQL
            mutation {
              updatePost(input: {
                id: "not_an_id",
                body: "A new body",
              }) {
                id
                title
                body
                author
              }
            }
          GQL
        }

        it "Fails with blank arguments" do
          post("/graphql", params: {query: invalid_post_query(subject.id)})

          expect(json_response["data"]).to be_nil
          expect(json_response["errors"][0]["message"]).to eql(
            "Invalid input: Title can't be blank, Body can't be blank, Author can't be blank"
          )
        end

        it "Fails with non existing id" do
          post("/graphql", params: {query: invalid_post_query_id})

          expect(json_response["data"]).to be_nil
          expect(json_response["errors"][0]["message"]).to eql(
            "Record not found: Couldn't find Post with 'id'=not_an_id"
          )
        end
      end

      context "Valid Post" do
        def valid_post_query(post_id)
          <<~GQL
            mutation {
              updatePost(input: {
                id: "#{post_id}",
                body: "Updated by Titou",
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
          expect(json_response["data"]["updatePost"]).to include(
            "title" => "Some title",
            "body" => "Updated by Titou",
            "author" => "Some author",
            "createdAt" => be_present,
            "updatedAt" => be_present
          )
        end
      end
    end
  end
end
