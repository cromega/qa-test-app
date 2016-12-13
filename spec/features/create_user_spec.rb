require "features/feature_helper"


describe "Create a user", driver: :selenium do

  before do
    visit "/users/new"
  end

  it "creates a new user" do

    fill_in('Username', with: 'Sirion')
    fill_in('Email', with: 'siriondragon@gmail.com')
    fill_in('Password', with: 'ilovefire')
    fill_in('Password confirmation', with: 'ilovefire')
    click_button('Create')

    expect(page).to have_content ('User has been created successfully!')


  end

  context "with an invalid email address" do
    it "displays an error message" do

      fill_in('Username', with: 'Sirion')
      fill_in('Email', with: 'siriondragon.gmail.com')
      fill_in('Password', with: 'ilovefire')
      fill_in('Password confirmation', with: 'ilovefire')
      click_button('Create')

      expect(page).to have_content ('Email has to look like an email address')
    end
  end

context "with a wrong password confirmation" do
    it "displays an error message" do

      fill_in('Username', with: 'Sirion')
      fill_in('Email', with: 'siriondragon@gmail.com')
      fill_in('Password', with: 'ilovefire')
      fill_in('Password confirmation', with: 'ilovewater')
      click_button('Create')

      expect(page).to have_content ("Password confirmation doesn't match Password")
    end
  end

  context "with a too short username" do
    it "displays an error message" do

      fill_in('Username', with: 'Sir')
      fill_in('Email', with: 'siriondragon@gmail.com')
      fill_in('Password', with: 'ilovefire')
      fill_in('Password confirmation', with: 'ilovewater')
      click_button('Create')

      expect(page).to have_content ("Username is too short (minimum is 4 characters)")
      sleep 2
    end
  end

end