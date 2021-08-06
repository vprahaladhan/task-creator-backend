class UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        puts "eneter create method"
        user = User.create(user_params)
        puts user.username, user.password
        if user.valid?
            user.save
            token = set_token(user)
            render json: {user: user, token: token}
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
