require 'jwt'
class JsonWebToken
  class << self
    def encode(user_data, expiration = (24).hours.from_now.to_i)
      payload = {data: user_data, exp: expiration }
      puts "Payload #{payload}"
      JWT.encode(payload, Rails.application.secrets.secret_key_base)

      # encoded_token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
      # puts "Encoded Token > #{encoded_token}"
      # body = JWT.decode(encoded_token, Rails.application.secrets.secret_key_base)
      # puts "Decoded token > #{body}"
      # puts "Hash >> #{HashWithIndifferentAccess.new body[0]}"
      # encoded_token
    end
   
    def decode_http_token(token)
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      decoded_token_hash = HashWithIndifferentAccess.new decoded_token
      decoded_token_hash
    rescue
      nil
    end
  end
end