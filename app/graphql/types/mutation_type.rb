module Types
  class MutationType < Types::BaseObject
    field :login, Types::UserType, null: false do
      argument :email, String, required: true
      argument :password, String, required: true
    end
    def login(email:, password:)
      user = User.find_by(email: email)
      if user&.authenticate(password)
        user.token = user.to_sgid(expires_in: 12.hours, for: 'graphql')
        user
      else
        raise GraphQL::ExecutionError.new("Invalid email or password")
      end
    end


    field :register, Types::UserType, null: false do
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
    end
    def register(**kwargs)
      user = User.new(kwargs)
      if user.save
        user.token = user.to_sgid(expires_in: 12.hours, for: 'graphql')
        user
      else
        raise GraphQL::ExecutionError.new("Register failed.")
      end
    end

    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_post, mutation: Mutations::CreatePost
    field :update_post, mutation: Mutations::UpdatePost
    field :delete_post, mutation: Mutations::DeletePost
    field :create_comment, mutation: Mutations::CreateComment
  end
end
