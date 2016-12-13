require "features/feature_helper"

describe "Create a user", driver: :selenium do
  it "creates a new user" do
    visit "/users/new"

    fill_in('Username', with: 'Sirion')
    fill_in('Email', with: 'siriondragon@gmail.com')
    fill_in('Password', with: 'ilovefire')
    fill_in('Password confirmation', with: 'ilovefire')
    click_button('Create')

    expect(page).to have_content ('User has been created successfully!')

    sleep 2
  end

end