class Api::V1::AuthenticationController < Api::V1::ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:user][:email])
    if @user&.valid_password?(params[:user][:password])
      id = @user.id
      token = JsonWebTokenService.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { id: id, token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private
    def login_params
      params.require(:user).permit(:email, :password)
    end
end