class AuthController < ApplicationController
  # skip_before_action :get_current_user, only: :login

  def login
    user = User.find_by(username: login_params[:username])
    if user && user.authenticate(login_params[:password])
      token = set_token(user)
      render json: {user: user, token: token, message: "Login success"}
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  def logout
    render json: {message: get_current_user ? 'Logout success' : 'Login before logging out!'}
  end

  def get_user
    if request.headers['Authorization']
      user = get_current_user 
      render json: user
    end
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end