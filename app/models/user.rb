class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  normalizes :email, with: -> email { email.downcase }

  has_secure_password

  attr_accessor :remember_token

  def self.digest(str)
    BCrypt::Password.create(str, cost: BCrypt::Engine.cost)
  end

  def remember
    self.remember_token = SecureRandom.urlsafe_base64
    remember_digest = self.class.digest(remember_token)
    update_attribute(:remember_digest, remember_digest)
    remember_digest
  end

  def authenticated?(remember_token)
    remember_digest &&
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  def session_token
    remember_digest || remember
  end
end
