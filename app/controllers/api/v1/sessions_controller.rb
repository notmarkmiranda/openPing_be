module Api
  module V1
    class SessionsController < ApplicationController
      include TokenGenerator

      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = generate_token(user)
          render json: { user: user, token: token }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
  end
end
