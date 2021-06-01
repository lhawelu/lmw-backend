class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.create(user_params)
    if user.valid?
      render json: { message: 'Account created. Pleaes log in.' }, status: :created
    else
      render json: { message: user.errors.full_messages }, status: :not_acceptable
    end
  end

  def profile
    render json: { user: UserSerializer.new(@@user) }
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :email_address)
  end

end
