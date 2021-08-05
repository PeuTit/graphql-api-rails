require "rails_helper"

module Mutations
  RSpec.describe CreatePost, type: :request do
    describe ".resolve" do
      context "Invalid Post" do
        let(:createPostQueryBad) {
          <<~GQL
            mutation {
              createPost(input: {
                title:"", 
                body: "",
                author: ""
              }) {
                id
                title
                body
                author
                updatedAt
                createdAt
              }
            }
          GQL
        }

        it "Fails when blank arguments are provided" do
          post("/graphql", params: {query: createPostQueryBad})

          expect(json_response["data"]).to be_nil
          expect(json_response["errors"][0]["message"]).to eql(
            "Invalid input: Title can't be blank, Body can't be blank, Author can't be blank"
          )
        end
      end

      context "Valid Post" do
        let(:validPostQuery) {
          <<~GQL
            mutation {
              createPost(input: {
                title: "sadf",
                body: "asdf",
                author: "asdf"
              }) {
                id
                title
                body
                author
                updatedAt
                createdAt
              }
            }
          GQL
        }

        it "creates a Post" do
          post("/graphql", params: {query: validPostQuery})

          expect(response.status).to eql(200)
          expect(json_response["data"]["createPost"]).to include(
            "title" => "sadf",
            "body" => "asdf",
            "author" => "asdf",
            "createdAt" => be_present,
            "updatedAt" => be_present
          )
          expect(json_response["errors"]).to be_nil
        end
      end
    end
  end
end
