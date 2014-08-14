require_relative 'feature_spec_helper'

describe "the navbar", type: :feature do
  it "has buttons" do
    visit "/"
    expect(page).to have_content("Home")
  end

  # should move out of navbar test because it tests the carosel
  it "has a menu button" do
    visit "/"
    expect(page).to have_link("View Our Menu")
    click_link("View Our Menu")
    expect(current_url).to eq("http://www.example.com/menu")
  end
end
