class UsersController < ApplicationController
  def get_users
    render json: {users: User.all}
  end  
  
  def get_user
    render json: {user: get_current_user}
  end

  def add_user
    user = User.new(user_params)
    if user.valid?
      user.save
      render json: {user: user, token: set_token(user)}
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  def edit_user
    user = get_current_user
    user.update(user_params)
    render json: {user: user}
  end

  def destroy
    get_current_user.destroy
    render json: {user: nil, message: 'User successfully deleted!'}
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end