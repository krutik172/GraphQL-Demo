class Mutations::DeletePost < Mutations::BaseMutation
    argument :id, ID, required: true
  
    field :post, Types::PostType, null: false
  
    def resolve(id:)
      if context[:current_user]!= nil
        user = context[:current_user]
        post = user.posts.find(id)
        post.destroy!
        { post: post }

      else
        raise GraphQL::ExecutionError, "Authentication failed, you must be signed in!"
      end
    end
  end