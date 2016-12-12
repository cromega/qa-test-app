require "feature/feature_helper"

describe "Main page", type: :feature, js: true, driver: :selenium do
  it "works" do
    visit "/"
    expect(page).to have_content "Qa Test Page"
  end

  it "works with pure selenium objects" do
    visit "/"
    driver = page.driver.browser
    title = driver.find_element(:css, "h1")
    expect(title.text).to eq "Qa Test Page"
  end
end
