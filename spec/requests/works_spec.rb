require 'spec_helper'

describe "Home pages" do
  describe "Home page" do
    it "should have the content 'Welcome to AKN App' "  do
        visit '/home_pages/home'
        page.should have_content ('Welcome to AKN App')
    end
  end
end
