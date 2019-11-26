# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception

  def current_user
    if cookies[:user_remember_token]
      if defined? @current_user
        @current_user
      else
        remember_token = User.encrypt(cookies[:user_remember_token])
        @current_user = User.find_by(remember_token: remember_token)
      end
    end
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.remember_token = User.encrypt(remember_token)
    user.save!(validate: false)
    @current_user = user
  end

  def sign_out
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    current_user.present?
  end

  private

  def require_sign_in!
    redirect_to login_path unless signed_in?
  end

  def redirect_if_unauthorized
    redirect_to root_path unless current_user.administrator?
  end
end
