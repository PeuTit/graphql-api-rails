require "rails_helper"

RSpec.describe Post do
  describe "Validations" do
    subject { described_class.new(title: "Lorem", body: "Ipsum", author: "Author") }

    context "Invalid Post" do
      describe "title" do
        it "must be present" do
          subject.title = nil
          expect(subject).to_not be_valid
        end
      end

      describe "body" do
        it "must be present" do
          subject.body = nil
          expect(subject).to_not be_valid
        end
      end

      describe "author" do
        it "must be present" do
          subject.author = nil
          expect(subject).to_not be_valid
        end
      end
    end

    context "Valid Post" do
      describe "title" do
        it "is present" do
          expect(subject).to be_valid
        end
        it "must be less than 32 characters" do
          subject.title = "A very long title that is even longer than something very long, I dont know if thats enough"
          expect(subject).to_not be_valid
        end
      end

      describe "body" do
        it "is present" do
          expect(subject).to be_valid
        end
        it "must be less than 2000 characters" do
          subject.title =
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam hendrerit velit et eros sodales gravida. Nunc tempus dignissim aliquet. Pellentesque quis ipsum rutrum felis efficitur molestie. Nulla vulputate, dolor sed maximus vehicula, ligula quam cursus velit, id sagittis elit nisi at lorem. Pellentesque sit amet massa sem. Vivamus id purus vel leo tristique scelerisque id non ante. Sed congue eget metus vitae tempus.
        Quisque ac eleifend odio, vel blandit dui. Suspendisse potenti. Vestibulum finibus urna vitae risus fermentum luctus. Sed at ex justo. Nunc finibus ornare metus feugiat aliquam. Nam sed ornare urna. Nulla imperdiet fringilla egestas. Proin rhoncus aliquam porttitor. Quisque ac mi ac justo iaculis bibendum vitae nec velit. Maecenas molestie purus at pellentesque convallis. In dapibus purus diam, ut consequat diam sollicitudin a. Sed vel eros eget nisi interdum viverra. In quis nisi suscipit, maximus odio id, dignissim nunc.
        Pellentesque dapibus neque sed massa laoreet tempus. Aliquam a est sapien. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vehicula rhoncus nunc, quis fermentum purus rutrum at. Mauris in tortor est. Phasellus nec laoreet neque. Nunc egestas ligula vel maximus suscipit. Vestibulum aliquet at ipsum nec placerat. Nulla ullamcorper dui et mollis dignissim. Praesent convallis ornare semper. Aliquam congue nibh justo.
        Proin nec tellus vel ipsum aliquet maximus. Ut et suscipit justo. Donec a tortor vitae lectus dictum tempus scelerisque non orci. In in mollis nisl, a facilisis justo. Curabitur dapibus ipsum augue. Proin imperdiet aliquet felis nec volutpat. Fusce vel leo consectetur, convallis leo sed, tempor quam. Ut ornare imperdiet libero. Donec tellus orci, mollis eu accumsan a, imperdiet vitae arcu. Suspendisse faucibus maximus tortor, dignissim volutpat sem consectetur sit amet.
        Proin sagittis nisl sapien, vel dictum orci iaculis quis. Integer ac massa suscipit diam bibendum blandit non maximus ipsum. Duis fermentum odio.
        "
          expect(subject).to_not be_valid
        end
      end

      describe "author" do
        it "is present" do
          expect(subject).to be_valid
        end
      end
    end
  end
end
