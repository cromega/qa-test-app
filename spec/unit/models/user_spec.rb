require 'rails_helper'

describe User, type: :model do
  describe "attribute" do
    describe "username" do
      before do
        User.create(username: "test", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
      end

      it "is unique" do
        user = User.create(username: "test", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
        expect(user.errors.full_messages).to include "Username has already been taken"
      end

      it "is at least 4 characters long" do
        user = User.create(username: "asd", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
        expect(user.errors.full_messages).to include "Username is too short (minimum is 4 characters)"
      end
    end

    describe "email" do
      it "has to look like an email address" do
        user = User.new(username: "test", email: "bademail", password: "foobar", password_confirmation: "foobar")
        user.validate
        expect(user.errors.full_messages.first).to eq "Email has to look like an email address"
      end
    end

    describe "password" do
      it "has to match the confirmation" do
        user = User.new(username: "test", email: "test@test", password: "pw", password_confirmation: "different")
        user.validate
        expect(user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
      end

      it "is required" do
        user = User.new(username: "test", email: "test@test", password: "", password_confirmation: "")
        user.validate
        expect(user.errors.full_messages.first).to eq "Password can't be blank"
      end

    end
  end

  describe "hooks" do
    describe "before_save" do
      context "when it's a new record" do
        it "saves the password hashed" do
          u = User.create(username: "test", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
          expect(u.password).to eq "8843d7f92416211de9ebb963ff4ce28125932878"
        end
      end

      context "when the password is not updated" do
        it "does not change the password" do
          u = User.create(username: "test", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
          u.update(username: "test2")
          expect(u.password).to eq "8843d7f92416211de9ebb963ff4ce28125932878"
        end
      end

      context "when the password is updated" do
        it "saves the password hashed" do
          u = User.create(username: "test", email: "asd@asd.com", password: "foobar", password_confirmation: "foobar")
          u.update(password: "foobar2", password_confirmation: "foobar2")
          expect(u.password).to eq "c0ac73e304ca4fd4275985fe1e5ee6a113399eee"
        end
      end
    end
  end
end
