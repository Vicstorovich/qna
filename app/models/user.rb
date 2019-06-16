require "digest/md5"

class User < ApplicationRecord
  SALT = "my_super_cache".freeze

  validates :email, presence: true, uniqueness: true, email: true

  def email=(e)
    e = e.strip if e
    super
  end

  def password=(value)
    self.encrypted_password = password_hash(value)
  end

  def valid_password?(value)
    encrypted_password == password_hash(value)
  end

  private

  def password_hash(value)
    Digest::MD5.hexdigest(value + SALT)
  end
end
