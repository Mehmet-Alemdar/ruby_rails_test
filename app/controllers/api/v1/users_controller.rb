class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    if params[:user].nil? || params[:user][:username].nil? || params[:user][:password].nil?
      render json: { error: 'Username and password are required' }, status: :unprocessable_entity
    else
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { message: 'User deleted' }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy_all
    if User.destroy_all
      render json: { message: 'All users deleted' }, status: :ok
    else
      render json: { message: 'Failed to delete users' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
