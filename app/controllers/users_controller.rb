class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  def index
    @users = User.all.reverse
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(allowed_user_params)

    if @user.save
      redirect_to users_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @user.update(allowed_user_params)
      redirect_to users_path
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def allowed_user_params
    params.expect(user: [ :username, :email, :password ])
  end
end
