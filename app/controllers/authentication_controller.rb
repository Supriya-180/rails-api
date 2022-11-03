class AuthenticationController < ApplicationController
	  skip_before_action :authenticate_user

	  # POST /auth/login
	  def login
	    @user = User.find_by_email(params[:email])
	    if @user&.authenticate(params[:password])
	      token = JsonWebToken.encode(user_id: @user.id)
	      render json: { token: token,
	                     user: @user}, status: :ok
	    else
	      render json: { error: 'invalid email or password' }, status: :unauthorized
	    end
	  end

	  private

	  def login_params
	    params.permit(:email, :password)
	  end
end
