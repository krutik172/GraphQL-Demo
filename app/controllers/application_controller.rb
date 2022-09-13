class ApplicationController < ActionController::API
    def ensure_signed_in!
        redirect_to root_path unless current_user
      end
    
      def current_user
        if session[:user_id]
          User.find_by(id: session[:user_id])
        end
      end
    #   helper_method :current_user
    
      def sign_in(user)
        session[:user_id] = user.id
      end
    
      def sign_out
        session[:user_id] = nil
      end
end
