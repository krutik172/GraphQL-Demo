class Mutations::UpdateUser < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false
  
    def resolve(name:, email:)
      if context[:current_user]!= nil
        current_user = context[:current_user]
        user = User.find(current_user.id)
        user.update(name: name)
    
        if(user.errors.blank?)
          {user: user, errors: []}
        else
          {user: [], errors: user.errors.full_messages}
        end
      else
        raise GraphQL::ExecutionError, "Authentication failed, you must be signed in!"
      end
    end
  
end