module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)
        if @user.save
          token = generate_token(@user)
          render json: { user: @user, token: token }, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def generate_token(user)
        payload = { user_id: user.id }
        JWT.encode(payload, Rails.application.credentials.secret_key_base)
      end
    end
  end
end
