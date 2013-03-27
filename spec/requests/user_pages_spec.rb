require 'spec_helper'

describe "User pages" do

  subject { page }

    describe "signup page"   do
      before { visit signup_path }
      let(:submit)   { "Create my account" }
      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
        describe "after submission"  do
          before { click_button submit}
          it { should have_selector('title', text: 'Sign up') }
          it { should have_content('error') }
        end
      end
      describe "with valid information" do
        before do
          fill_in "Vorname",            with: "Klaus"
          fill_in "Nachname",         with: "Mustermann"
          fill_in "Email",                   with: "mustermann@example.com"
          fill_in "Password",            with: "foobar"
          fill_in "Confirmation",     with: "foobar"
        end
        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end
 #       describe "after saving the user" do
  #        before { click_button submit }
  #        let(:user)    { User.find_by_email('altenhofer@web.de') }
  #        it { should have_selector('title', text: user.Nachname) }
  #        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
  #      end
      end
  end

  describe "profile page" do
       let(:user)   {FactoryGirl.create(:user)}
       before  { visit user_path(user) }
       it { should have_selector('h1',   text:  user.nachname) }
       it { should have_selector('title',  text: user.nachname) }
  end

   describe "edit" do
      let(:user)    { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit edit_user_path(user)
      end
      it { should have_selector('h1', text: "Update your profile")}
      it { should have_selector('title', text: "Edit user")}
  end


end

  describe User do

    before do
      @user = User.new(vorname:"Example",nachname: "User", email: "user@example.com",
                       password: "foobar", password_confirmation: "foobar")
    end

    subject { @user }

    it { should respond_to(:vorname) }
    it { should respond_to(:nachname) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

    it { should be_valid }

        describe "when nachname is not present" do
        before { @user.nachname = " " }
          it { should_not be_valid }
        end
        describe "when vorname is not present" do
         before { @user.vorname = " " }
         it { should_not be_valid }
        end
        describe "when nachname is too long" do
        before { @user.nachname = "a" * 51 }
        it { should_not be_valid }
        end
        describe "when email format is valid" do
        it "should be valid" do
           addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
           addresses.each do |valid_address|
          @user.email = valid_address
          @user.should be_valid
          end
         end
       end
       describe "when email address is already taken" do
          before do
           user_with_same_email = @user.dup
           user_with_same_email.email = @user.email.upcase
           user_with_same_email.save
         end
          it { should_not be_valid }
       end
       describe "when password is not present" do
        before { @user.password = @user.password_confirmation = " " }
        it { should_not be_valid }
       end
       describe "when password doesn't match confirmation" do
         before { @user.password_confirmation = "mismatch" }
         it { should_not be_valid }
       end
       describe "with a password that's too short" do
          before { @user.password = @user.password_confirmation = "a" * 3 }
          it { should be_invalid }
        end
       describe "email address with mixed case" do
                let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
                it "should be saved as all lower-case" do
                  @user.email = mixed_case_email
                  @user.save
                  @user.reload.email.should == mixed_case_email.downcase
               end
       end
      describe "return value of authenticate method" do
          before { @user.save }
          let(:found_user) { User.find_by_email(@user.email) }

          describe "with valid password" do
             it { should == found_user.authenticate(@user.password) }
          end

          describe "with invalid password" do
              let(:user_for_invalid_password) { found_user.authenticate("invalid") }
              it { should_not == user_for_invalid_password }
             specify { user_for_invalid_password.should be_false }
           end
           describe "with valid password" do
               it { should == found_user.authenticate(@user.password) }
           end
           describe "with invalid password" do
            let(:user_for_invalid_password) { found_user.authenticate("invalid") }
            it { should_not == user_for_invalid_password }
            specify { user_for_invalid_password.should be_false }
           end
     end

    describe "remember token" do
      before { @user.save}
      its(:remember_token) {should_not be_blank}
    end

  end



