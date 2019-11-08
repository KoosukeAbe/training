# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: true

  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :login_id, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, presence: true, on: :create

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
