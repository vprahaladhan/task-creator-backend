class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def set_token(user)
        puts "set token reached"
        JsonWebToken.encode({user_id: user.id}, (24).hours.from_now.to_i)
    end

    def get_current_user
      puts "Auth", request.headers['Authorization']
        encoded_token = request.headers['Authorization'].split(' ')[1]
        token = JsonWebToken.decode_http_token(encoded_token)
        puts "Token hEEEEERE #{token}"
        user_id = token["data"]["user_id"]
        user = User.find(user_id)
        user
    end
end
