class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :edit_profile, :update_profile]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @reservations = current_user.reservations.includes(:room)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(account_user_params)
      redirect_to user_path(@user), notice: "アカウント情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user

    if @user.update(profile_user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction)
  end

  def account_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def profile_user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end

  def require_login
    redirect_to login_path, alert: "ログインしてください" unless logged_in?
  end

  


end
