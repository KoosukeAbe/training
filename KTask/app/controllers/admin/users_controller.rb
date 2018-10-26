# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.save!
      redirect_to admin_users_path, flash: { success: t('flash.user.create_success') }
    rescue StandardError
      flash.now[:danger] = t('flash.user.create_failure')
      render :new
    end

    def edit
    end

    def show
      @tasks = @user.tasks
    end

    def update
      @user.update!(user_params)
      redirect_to admin_users_path, flash: { success: t('flash.user.update_success') }
    rescue StandardError
      flash.now[:danger] = t('flash.user.update_failure')
      render :edit
    end

    def destroy
      @user.destroy!
      redirect_to admin_users_path, flash: { success: t('flash.user.delete_success') }
    rescue StandardError
      redirect_to admin_users_path, flash: { danger: t('flash.user.delete_failure') }
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
  end
end
