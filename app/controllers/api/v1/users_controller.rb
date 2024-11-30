module Api
  module V1
    class UsersController < ApplicationController
      include TokenGenerator

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
    end
  end
end
