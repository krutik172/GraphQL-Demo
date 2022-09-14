class Mutations::CreateComment < Mutations::BaseMutation
  argument :body, String, required: true
  argument :post_id, Integer, required: true

  field :comment, Types::CommentType, null: false
  field :errors, [String], null: false
  

  def resolve(body:,post_id:)
    unless context[:current_user].nil?
      current_user = context[:current_user]
      comment = current_user.comments.build(commenter: current_user.name ,body: body,post_id: post_id)
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