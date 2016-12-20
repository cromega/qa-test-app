require "digest/sha1"

class User < ApplicationRecord
  before_save do
    if new_record? || password_changed?
      self.password = Digest::SHA1.hexdigest self.password
    end
  end

  validates :username, uniqueness: true, length: { minimum: 4 }
  validates :email, format: { with: /@/, message: "has to look like an email address" }
  validates :password, confirmation: true, presence: true, if: ->{ password_changed? }
  validates :password_confirmation, presence: true, if: ->{ password_changed? }
end
