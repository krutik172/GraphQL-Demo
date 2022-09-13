# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :post_id, Integer, null: false
    field :commenter, String
    field :body, String
  end
end
