class Mutations::CreatePost < Mutations::BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true
    field :post, Types::PostType, null: false
    field :errors, [String], null: false
    

    def resolve(title:,body:)
      if context[:current_user]!= nil
        post = Post.new(title: title,body: body, user: context[:current_user])
        if post.save
          {
            post: post,
            errors: []
          }
        else
          {
            post: nil,
            errors: post.errors.full_messages
          }
        end
      else
        raise GraphQL::ExecutionError, "Authentication failed, you must be signed in!"
      end
    end
end