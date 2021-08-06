class AuthController < ApplicationController
    
    def login
        user = User.find_by(username: login_params[:username])
        if user && user.authenticate(login_params[:password])
            token = set_token(user)
            render json: {user: user, token: token, message: "Login success"}
        else
            render json: {errors: user.errors.full_messages}
        end
    end

    def get_user
        if request.headers['Authorization']
           user = get_current_user 
           render json: user
        end
    end

    private

    def login_params
        params.require(:auth).permit(:username, :password)
    end

end