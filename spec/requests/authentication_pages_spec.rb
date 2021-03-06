require 'spec_helper'

describe "Authentication" do

  subject { page }
  describe "signin page"  do
    before { visit login_path }


    it { should have_selector('title', text: 'Sign in') }

    describe "with_invalid_information" do
      before { click_button I18n.t("text.login") }
      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end
   describe "with valid information" do
      let(:user)    { FactoryGirl.create(:user) }

      before do
        fill_in "Email",            with: user.email.upcase
        fill_in "Password",     with: user.password
        click_button "Sign in"
      end
      it { should have_selector('title', text: user.lastname) }
      it { should have_link('Profile', href: edit_user_path(user)) }
      it { should have_link('Settings', href: user_path(user)) }
      it { should have_link('Sign out',  href: logout_path) }
      it { should_not have_link('Sign in', href: login_path) }
    end
  end
  describe "authorization" do
       describe "for non-signed-in users" do
         let(:user)  { FactoryGirl.create(:user) }

         describe "in the Users controller" do

              describe "visiting the edit page" do
                before { visit edit_user_path(user) }
                it { should have_selector('title', text: 'Sign in') }
              end
              describe "submitting to the update action" do
                before { put user_path(user) }
                specify { response.should redirect_to(login_path) }
              end
         end
       end
  end
end

