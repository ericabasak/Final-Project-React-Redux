class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  # this function is concerned with the headers, specifically
  #  the key of "authorization". Auth_header returns a
  # a JWT token in the format of Bearer <Token>
  def auth_header
    # { Authorization: 'Bearer <token>' }
    puts "------request------"
    puts request.headers.first(50)
    request.headers['Authorization']
  end

  # to get the token, use the .split(" ")[1] method on Bearer <Token>
  # 
  def decoded_token
    if auth_header()
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  # this function returns a true or false value
  def logged_in?
    !!logged_in_user
  end

  # this function is called first to see whether a user is authorized
  def authorized
    render json: { message: 'Please log in!' }, status: :unauthorized unless logged_in?
  end
end