class Mutations::CreateComment < Mutations::BaseMutation
    argument :commenter, String, required: true
    argument :body, String, required: true
    argument :post_id, Integer, required: true
    field :comment, Types::CommentType, null: false
    field :errors, [String], null: false
    

    def resolve(commenter:,body:,post_id:)
      if context[:current_user]!= nil
        comment = Comment.new(commenter: commenter,body: body,post_id: post_id)
        if comment.save
          {
            comment: comment,
            errors: []
          }
        else
          {
            comment: nil,
            errors: comment.errors.full_messages
          }
        end
      else
        raise GraphQL::ExecutionError, "Authentication failed, you must be signed in!"
      end
    end

end