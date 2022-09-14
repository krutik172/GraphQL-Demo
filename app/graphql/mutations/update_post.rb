class Mutations::UpdatePost < Mutations::BaseMutation
  argument :title, String, required: true
  argument :body, String, required: true
  argument :id, Integer, required: true

  field :post, Types::PostType, null: false
  field :errors, [String], null: false

  def resolve(title:,body:, id:)
    unless context[:current_user].nil?
      post = Post.find(id)
      post.update(title: title, body: body)
  
      if(post.errors.blank?)
        {post: post, errors: []}
      else
        {post: [], errors: post.errors.full_messages}
      end
    else
      raise GraphQL::ExecutionError, "Authentication failed, you must be signed in!"
    end
  end
end