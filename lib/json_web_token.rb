require 'jwt'
class JsonWebToken
    class << self
      def encode(user_data, expiration = (24).hours.from_now.to_i)
        payload = {data: user_data, exp: expiration }
        puts "Payload #{payload}"
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
      end
   
      def decode(token)
        body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        HashWithIndifferentAccess.new body
      rescue
        nil
      end
    end
   end