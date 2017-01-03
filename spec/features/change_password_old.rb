require "features/feature_helper"


describe "Changes user password", driver: :selenium do


  it "changes password correctly" do
visit "/users/new"
    fill_in('Username', with: 'Sirion')
    fill_in('Email', with: 'siriondragon@gmail.com')
    fill_in('Password', with: 'ilovefire')
    fill_in('Password confirmation', with: 'ilovefire')
    click_button('Create')

sleep 2

visit "/login"
    fill_in('Username', with: 'Sirion')
    fill_in('Password', with: 'ilovefire')
    click_button('Log in')
    sleep 2
    click_link('Profile')
    fill_in('Password', with: 'password2')
    fill_in('Password confirmation', with: 'password2')
    click_button('Save')
    expect(page).to have_content ('User details updated')
    sleep 3

visit "/logout"
sleep 2
click_link('Log in')
sleep 1
fill_in('Username', with: 'Sirion')
fill_in('Password', with: 'password2')
sleep 2
click_button('Log in')
expect(page).to have_content ('Welcome Sirion!')
sleep 2


  end
end