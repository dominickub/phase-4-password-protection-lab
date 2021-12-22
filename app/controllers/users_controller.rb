class UsersController < ApplicationController
    def create
        users = User.create!(user_params)
        if users.valid?
            session[:user_id] = users.id
            render json: users
        else
            render json: {error:"error, you hoe"}, status: :unprocessable_entity
        end
    end

    def show
        users = User.find_by(id: session[:user_id])
        if users
            render json: users
        else
            render json: {error:"errors all around"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
