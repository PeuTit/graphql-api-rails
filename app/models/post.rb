class Post < ApplicationRecord
  validates :title, presence: true, length: {maximum: 32}
  validates :body, presence: true, length: {maximum: 2000}
  validates :author, presence: true
end
