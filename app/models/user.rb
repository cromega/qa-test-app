require "digest/sha1"

class User < ApplicationRecord
  before_save do
    self.password = Digest::SHA1.hexdigest self.password
  end

  validates :username, uniqueness: true, length: { minimum: 4 }
  validates :email, format: { with: /@/, message: "has to look like an email address" }
  validates :password, confirmation: true
end
