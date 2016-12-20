FactoryGirl.define do
  factory :user do
    username "test"
    email "test@test"
    password "foobar"
    password_confirmation { password }
  end
end


