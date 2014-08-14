require_relative 'feature_spec_helper'

describe "the navbar", type: :feature do
  it "has buttons" do
    pending
    visit "/"
    expect(page).to have_content("Home")
  end
end
