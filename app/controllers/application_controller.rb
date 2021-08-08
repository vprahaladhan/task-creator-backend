class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def set_token(user)
    JsonWebToken.encode({user_id: user.id}, (24).hours.from_now.to_i)
  end

  def get_current_user
    puts "Calling get current user"
    user = nil
    puts "Token 1 >> #{request.headers['Authorization']}"
    if request.headers['Authorization']
      puts "Token 2 >> #{request.headers['Authorization'].split(' ')[1]}"
      encoded_token = request.headers['Authorization'].split(' ')[1]
      token = JsonWebToken.decode_http_token(encoded_token)
      puts "Token >> #{token}"
      user = User.find(token["data"]["user_id"])
    end
  end
end
