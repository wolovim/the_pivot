require_relative 'feature_spec_helper'

describe "the temporary homepage", type: :feature do
  it "shows going soon" do
    visit "/"
    expect(page).to have_content("Endangered Eats: going soon!")
  end
end
