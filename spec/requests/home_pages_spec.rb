require 'spec_helper'

describe "Home pages" do

     subject { page }
     shared_examples_for "all home_pages" do
       it { should have_selector('h3', text: heading) }
       it { should have_selector('title', text: full_title(page_title)) }
     end

     describe "Home page" do
          before { visit root_path }
          let(:heading)          { I18n.t( "text.home_page_title")  }
          let(:page_title)      { '' }

          it_should_behave_like "all home_pages"
          it { should_not have_selector 'title', text: ' | Home' }
     end

     describe "Help page" do
       before { visit help_path }
       let(:heading)          { 'Help'  }
       let(:page_title)      { 'Help' }

       it_should_behave_like "all home_pages"
     end

     describe "About page" do
       before { visit about_path }
       let(:heading)          { 'About us'  }
       let(:page_title)      { 'About' }

       it_should_behave_like "all home_pages"
     end

     describe "Contact page" do
       before { visit contact_path }
       let(:heading)          { 'Contact'  }
       let(:page_title)      { 'Contact' }

       it_should_behave_like "all home_pages"
     end

     it "should have the right links on the layout" do
       visit root_path
       click_link "About"
       page.should have_selector 'title', text: full_title('About')
       click_link "Help"
       page.should have_selector 'title', text: full_title('Help')
       click_link "Contact"
       page.should have_selector 'title', text: full_title('Contact')
       click_link I18n.t("text.akn_title")
       page.should have_selector 'title', text: full_title('')
       click_link "Sign in"
       page.should have_selector 'title', text: full_title('Sign in')
     end


end
