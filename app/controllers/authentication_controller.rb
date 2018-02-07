class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  resource_description do
    short 'Authentication errors'
    error message: MissingToken, desc: 'Unauthorized'
    error message: InvalidToken, desc: 'invalid credentials'
    formats ['json']
  end

  api :POST, '/auth/login', 'User login'
  param :email, String, required: true
  param :password, String, required: true
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
