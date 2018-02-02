class UsersController < Api::V1::ApiController
  skip_before_action :authorize_request, only: :create

  api :POST, '/signup', 'Create new user'
  param :email, String, required: true
  param :password, String, required: true
  param :password_confirmation, String, required: true
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation
    )
  end
end
