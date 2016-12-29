require "digest/sha1"

class User < ApplicationRecord
  before_save do
    if needs_password_update?
      self.password = Digest::SHA1.hexdigest self.password
    end
  end

  validates :username, uniqueness: true, length: { minimum: 4 }
  validates :email, format: { with: /@/, message: "has to look like an email address" }
  validates :password, confirmation: true, presence: true, if: ->{ needs_password_update? }
  validates :password_confirmation, presence: true, if: ->{ needs_password_update? }

  private

  def needs_password_update?
    new_record? || (password_changed? && !password.blank?)
  end
end
