require "features/feature_helper"


describe "Changing profile details", driver: :selenium do
  def create_user
    visit "/users/new"
    fill_in('Username', with: username)
    fill_in('Email', with: username + "@test")
    fill_in('Password', with: 'ilovefire')
    fill_in('Password confirmation', with: 'ilovefire')
    click_button('Create')
  end

  def login(username, password)
    click_link('Log in')
    fill_in('Username', with: username)
    fill_in('Password', with: password)
    click_button('Log in')
  end

  before do
    create_user
    login(username, password)
  end

  let(:username) { "testuser" }
  let(:password) { "ilovefire" }

  context "when the user changes password" do
    let(:new_password) { "newpassword"}

    it "changes password" do
      click_link('Profile')
      fill_in('Password', with: new_password)
      fill_in('Password confirmation', with: new_password)
      click_button('Save')
      expect(page).to have_content ('User details updated')

      visit "/logout"
      login(username, new_password)
      expect(page).to have_content ("Welcome #{username}!")
    end
  end

  context "when the user changes the username" do
    let(:new_username) { "new_username" }

    it "changes the username" do
      click_link('Profile')
      fill_in('Username', with: new_username)
      click_button('Save')
      expect(page).to have_content ('User details updated')

      visit "/logout"
      login(new_username, password)
      expect(page).to have_content ("Welcome #{new_username}!")
    end
  end
end
