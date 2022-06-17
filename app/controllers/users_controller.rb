class UsersController < ApplicationController

  def create
    new_user = User.create(user_params)
    if new_user.valid?
      session[:user_id] = new_user.id
      render json: new_user, status: :created
    else
      render json: {error: "Information invalid, please try again"}, status: :unprocessable_entity
    end
  end

  def show
    current_user = User.find_by(id: session[:user_id])
    if current_user
      render json: current_user
    else
      render json: {error: "No user is logged in, please login"}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end

end
