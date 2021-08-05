class AuthController < ApplicationController
    
    def login
        user = User.find_by(username: login_params[:username])
        if user && user.authenticate(login_params[:password])
             token = JsonWebToken.encode({user_id: user.id}, (24).hours.from_now.to_i)
            render json: {user: user, token: token, message: "Login success"}
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def get_user
        if request.headers['Authorization']
            encoded_token = request.headers['Authorization'].split(' ')[1]
            token = JsonWebToken.decode(encoded_token)
            puts "User: #{token[:data][:user_id]}"
            user_id = token[:data][:user_id]
            user = User.find(user_id)
            render json: user
        end
    end

    private

    def login_params
        params.require(:auth).permit(:username, :password)
    end

end